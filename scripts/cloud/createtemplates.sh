#!/bin/bash -e

# Variables
INSTALL_DIR=/opt/flight/templates/
AWS_DIR=$INSTALL_DIR/aws
AZURE_DIR=$INSTALL_DIR/azure

mkdir -p $AWS_DIR
mkdir -p $AZURE_DIR

# AWS

## Domain file for network
cat << EOF > $AWS_DIR/domain.yaml
---
Description: 'Flight Domain Template'
Resources:
  flightcloudclusterNetwork:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: 10.10.0.0/16
      EnableDnsSupport: true
      EnableDnsHostnames: true

  flightcloudclusterInternetGateway:
    Type: AWS::EC2::InternetGateway
    DependsOn: flightcloudclusterNetwork

  flightcloudclusterInternetGatewayAttachment:
    Type: AWS::EC2::VPCGatewayAttachment
    Properties:
      InternetGatewayId: !Ref flightcloudclusterInternetGateway
      VpcId: !Ref flightcloudclusterNetwork

  flightcloudclusterRouteTable:
    Type: AWS::EC2::RouteTable
    DependsOn: flightcloudclusterInternetGatewayAttachment
    Properties:
      VpcId: !Ref flightcloudclusterNetwork

  flightcloudclusternetworkSubnet:
    Type: AWS::EC2::Subnet
    Properties:
      CidrBlock: 10.10.0.0/19
      VpcId: !Ref flightcloudclusterNetwork
      AvailabilityZone: !Select
        - 0
        - Fn::GetAZs: !Ref 'AWS::Region'

  flightcloudclusternetwork1SubnetRouteTableAssocation:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties:
      SubnetId: !Ref flightcloudclusternetworkSubnet
      RouteTableId: !Ref flightcloudclusterRouteTable

  flightcloudclusterRouteInternetGateway:
    Type: AWS::EC2::Route
    DependsOn: flightcloudclusterInternetGatewayAttachment
    Properties:
      RouteTableId: !Ref flightcloudclusterRouteTable
      DestinationCidrBlock: '0.0.0.0/0'
      GatewayId: !Ref flightcloudclusterInternetGateway

  flightcloudclusterSecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupName: flightcloudcluster
      GroupDescription: 'Primary SG for basic'
      VpcId: !Ref flightcloudclusterNetwork
      SecurityGroupIngress:
        -
          IpProtocol: '-1'
          FromPort: 0
          ToPort: 65535
          CidrIp: '10.10.0.0/16'
          Description: 'Allow all traffic for cluster VPC'
        -
          IpProtocol: 'tcp'
          FromPort: 22
          ToPort: 22
          CidrIp: '0.0.0.0/0'
          Description: 'Allow inbound SSH access'
        -
          IpProtocol: 'tcp'
          FromPort: 5901
          ToPort: 5911
          CidrIp: '0.0.0.0/0'
          Description: 'Allow 10 VNC sessions'
        -
          IpProtocol: 'icmp'
          FromPort: '8'
          ToPort: '-1'
          CidrIp: '0.0.0.0/0'
          Description: 'Allow ping'
      SecurityGroupEgress:
        -
          IpProtocol: '-1'
          FromPort: 0
          ToPort: 65535
          CidrIp: '0.0.0.0/0'
          Description: 'Allow outbound internet access'
EOF

## Node
cat << EOF > $AWS_DIR/node.yaml
---
Description: 'Flight Domain Template'
Parameters:
  nodename:
    Type: String 
    Description: 'Name for the node'
    Default: '%nodename%'
  sshKeyName:
    Type: String
    Description: 'EC2 KeyPair name to enable SSH access to the node'
    Default: '%sshKeyName%'
  networkSecurityGroupID:
    Type: String
    Description: 'The ID of the domain Security Group'
    Default: '%networkSecurityGroupID%'
  networkSubnetID:
    Type: String
    Description: 'The ID of the domain Network Subnet for network1'
    Default: '%networkSubnetID%'
  sourceimage:
    Type: String
    Description: 'AMI ID of the source image for this compute resource in your account'
    Default: '%sourceimage%'
Resources:

  flightclusternodenetworkInterface:
    Type: AWS::EC2::NetworkInterface
    Properties:
      SourceDestCheck: false
      GroupSet:
        - !Ref networkSecurityGroupID
      SubnetId: !Ref networkSubnetID

  flightclusternode:
    Type: AWS::EC2::Instance
    Properties:
      AvailabilityZone: !Select
        - 0
        - Fn::GetAZs: !Ref 'AWS::Region'
      ImageId: !Ref sourceimage
      KeyName: !Ref sshKeyName
      InstanceType: t2.small
      Monitoring: true
      NetworkInterfaces:
        -
          NetworkInterfaceId: !Ref flightclusternodenetworkInterface
          DeviceIndex: 0
      UserData:
        Fn::Base64:
          Fn::Join:
            - ''
            - - "#cloud-config\n"
              - "hostname: "
              - !Ref nodename
              - "\n"
              - "fqdn: "
              - !Ref nodename
              - ".pri.mycluster.cluster.local\n"
              - "system_info:\n"
              - "  default_user:\n"
              - "    name: flight\n"

  flightclusternodepublicIp:
    Type: AWS::EC2::EIP
    Properties:
      Domain: vpc

  flightclusternodepublicIpAssociation:
    Type: AWS::EC2::EIPAssociation
    Properties:
      NetworkInterfaceId: !Ref flightclusternodenetworkInterface
      AllocationId: !GetAtt flightclusternodepublicIp.AllocationId
EOF

# Azure

## Domain file for network
cat << EOF > $AZURE_DIR/domain.json
{
  "\$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.Network/virtualNetworks",
      "name": "flightcloudclusternetwork",
      "apiVersion": "2017-03-01",
      "location": "[resourceGroup().location]",
      "properties": {
        "addressSpace": {
          "addressPrefixes": [
            "10.10.0.0/16"
          ]
        },
        "subnets": [
          {
            "name": "flightcloudclusternetwork1",
            "properties": {
              "addressPrefix": "10.10.0.0/19"
            }
          }
        ]
      }
    },
    {
      "type": "Microsoft.Network/networkSecurityGroups",
      "name": "flightcloudclustersecuritygroup",
      "apiVersion": "2017-03-01",
      "location": "[resourceGroup().location]",
      "properties": {
        "securityRules": [{
           "name": "inbound-ssh",
             "properties": {
             "protocol": "TCP",
             "sourcePortRange": "*",
             "destinationPortRange": "22",
             "sourceAddressPrefix": "*",
             "destinationAddressPrefix": "*",
             "access": "Allow",
             "priority": 1000,
             "direction": "Inbound"
           }
         }]
       }
    }
  ],
  "outputs": {
    "networkSubnetID": {
      "type": "string",
      "value": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'flightcloudclusternetwork', 'flightcloudclusternetwork1')]"
    },
    "networkSecurityGroupID": {
      "type": "string",
      "value": "[resourceId('Microsoft.Network/networkSecurityGroups', 'flightcloudclustersecuritygroup')]"
    }
  }
}
EOF

## Node
cat << EOF > $AZURE_DIR/node.json
{
  "\$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "nodename": {
      "type": "string",
      "defaultValue": "%nodename%",
      "metadata": {
        "description": "Name for the node"
      }
    },
    "sshPublicKey": {
      "type": "string",
      "defaultValue": "%sshPublicKey%",
      "metadata": {
        "description": "Specify the public SSH key as a string"
      }
    },
    "networkSubnetID": {
      "type": "string",
      "defaultValue": "%networkSubnetID%",
      "metadata": {
        "description": "ID of the network subnet for the node resource to use"
      }
    },
    "networkSecurityGroupID": {
      "type": "string",
      "defaultValue": "%networkSecurityGroupID%",
      "metadata": {
        "description": "ID of the security group for the node resource to use"
      }
    },
    "sourceimage": {
      "type": "string",
      "defaultValue": "%sourceimage%",
      "metadata": {
        "description": "Path to source image for this compute resource in your account. This will look along the lines of '/subscriptions/SUBSCRIPTION_ID_HERE/resourceGroups/RESOURCE_GROUP_NAME_HERE/providers/Microsoft.Compute/images/IMAGE_NAME_HERE'"
      }
    }
  },
  "resources": [
    {
      "type": "Microsoft.Network/publicIPAddresses",
      "name": "[concat(parameters('nodename'), 'pubIP')]",
      "apiVersion": "2017-03-01",
      "location": "[resourceGroup().location]",
      "properties": {
        "publicIPAllocationMethod": "Static",
        "idleTimeoutInMinutes": 30,
        "dnsSettings": {
          "domainNameLabel": "[parameters('nodename')]"
        }
      }
    },
    {
      "type": "Microsoft.Network/networkInterfaces",
      "name": "[concat(parameters('nodename'), 'network1interface')]",
      "apiVersion": "2017-03-01",
      "location": "[resourceGroup().location]",
      "properties": {
        "ipConfigurations": [{
          "name": "[concat(parameters('nodename'), 'network1ip')]",
          "properties": {
            "privateIPAllocationMethod": "Dynamic",
            "publicIPAddress": {
              "id": "[resourceId('Microsoft.Network/publicIpAddresses', concat(parameters('nodename'), 'pubIP'))]"
            },
            "subnet": {
              "id": "[parameters('networkSubnetID')]"
            }
          }
        }],
        "networkSecurityGroup": {
          "id": "[parameters('networkSecurityGroupID')]"
        }
      },
      "dependsOn": [
        "[resourceId('Microsoft.Network/publicIpAddresses', concat(parameters('nodename'), 'pubIP'))]"
      ]
    },
    {
      "type": "Microsoft.Compute/virtualMachines",
      "name": "[concat(parameters('nodename'))]",
      "apiVersion": "2016-04-30-preview",
      "location": "[resourceGroup().location]",
      "properties": {
        "hardwareProfile": {
	      "vmSize": "Standard_DS1_v2"
	    },
        "storageProfile": {
          "osDisk": {
            "createOption": "fromImage",
            "managedDisk": {
              "storageAccountType": "Premium_LRS"
            }
          },
          "imageReference": {
            "id": "[parameters('sourceimage')]"
          }
        },
	    "osProfile": {
          "computerName": "[concat(parameters('nodename'), '.pri.mycluster.cluster.local')]",
          "adminUsername": "flight",
          "linuxConfiguration": {
            "disablePasswordAuthentication": true,
            "ssh": {
            "publicKeys": [{
              "path": "[concat ('/home/flight', '/.ssh/authorized_keys')]",
              "keyData": "[parameters('sshPublicKey')]"
              }]
            }
          }
        },
        "networkProfile": {
          "networkInterfaces": [
          {
	      "id": "[resourceId('Microsoft.Network/networkInterfaces', concat(parameters('nodename'), 'network1interface'))]",
	        "properties": {
	          "primary": true
	        }
          }
          ]
        }
      },
      "dependsOn": [
        "[resourceId('Microsoft.Network/networkInterfaces', concat(parameters('nodename'), 'network1interface'))]"
      ]
    }
  ]
}
EOF

