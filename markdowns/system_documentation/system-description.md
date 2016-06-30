# General System Description

## System Function or Purpose

Freedonia Compliance
is an online catalog of the current compliance state of Freedonia Compliance, operated by GovReady.

## Information System Components and Boundaries

GovReady runs two VPCs (development and production) for Freedonia Compliance. In each is a single node running Nginx, Node.js and Gitbook with content built from Git repositories hosted by GitHub.

The Freedonia Compliance Information System is hosted within the AWS East Public Cloud in the Northern Virginia Region. AWS services utilized include EC2, EBS, VPC, S3, MFA, Route 53, ELB and IAM. These are listed as leveraged hardware, network and server components.

Physical aspects of the
Freedonia Compliance information system
are outside of the authorization boundary due to all hardware being physically managed by AWS. While other services are reviewed and approved for use by the GSA OCISO, they were deemed to be ancillary support services that do not directly process/store data but rather provide general support services. These services include Cloudwatch, Cloudtrail, CloudFormation, AWS Config and Trusted Advisor.

TKTK: Update the ff paragraph:
The authorization boundary diagram represented within Figure 9-1 depicts the core components which make up the System in its entirety.  The diagram specifically depicts, outlined in red, those components that are within the authorization boundary and those that are outside of the boundary. AWS components outside the boundary belong to an authorized System thus allowing for inheritance of the component. Other support services outside the Cloud.Gov information system authorization boundary include, Pager Duty, New Relic, Slack, Trello, GitHub, Code Climate and Cloudability.  Pagerduty, Slack and Trello are communication tools used by 18F developers and support staff while New Relic, GitHub and Code climate are developer based tools in support of the Cloud.Gov system. .

## Network Architecture
The following architectural diagram(s) provides a visual depiction of the system network components that constitute Cloud.Gov.

TKTK

## Freedonia/GovReady Security Domain Stack

### Identification and Authentication Control

TKTK: How to write this so that:
- We consume AWS/IAM setting by consuming freedonia-aws-compliance
  - And leverage CloudFormation or IAM+SDK or Terraform to build to spec
- We consume generic tooling for, say, GitHub and SSH by consuming freedonia-tooling-compliance
- The actual I&A for fd-comp is minimal

### ACLs, Software defined Firewalls and Security Groups

### Audit Logging, Monitoring and intrusion detection

### Vulnerability Scanning, Penetration testing

- InSpec?
- OpenVAS?

### Cloud Inventory and Asset Management

- TKTK

### Static and Dynamic Code Analysis

- TKTK

### Incident Response Resolution and Communication

- TKTK

### Configuration Management and Version Control

- TKTK

# System Environment


### Cloud.Gov Virtual Private Cloud (VPC) environment

#### Public Subnet

#### Private Subnet - Core Tier

#### Private Subnet - Metrics

#### User Accounts

TODO: Update for Freedonia Compliance

All users have their employee status categorized with a sensitivity level in accordance with PS-2. Employees (or contractors) of service providers are considered Internal Users. All other users are considered External Users. User privileges (authorization permission after authentication takes place) are described in the table that follows.  At this time all users who have access to the 18F AWS VPC and the underlying Cloud.Gov PaaS are internal users. There is no external access granted to users outside of the 18F/USDS programs and GSA.

A user account represents an individual person within the context of a Cloud Foundry installation. A user can have different roles in different spaces within an org, governing what level and type of access they have within that space. The combination of these roles defines the user’s overall permissions in the org and within specific spaces in that org.  A list of standard cloud foundry user account types can be found in the table below.

## Types of Users

TODO: Update for Freedonia Compliance

| Role            | Internal or External | Sensitivity Level | Authorized Privileges and Functions Performed                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|-----------------|----------------------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Org Manager     | Internal             | High              | Add and manage users, View users and edit org roles, View the org quota, Create, view, edit, and delete spaces, Invite and manage users in spaces, View the status, number of instances, service bindings, and resource use of each application in every space in the org, Add domains                                                                                                                                                                                                      |
| Org Auditor     | Internal             | Low               | View users and org roles, View the org quota                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| Space Manager   | Internal             | High              | Add and manage users in the space, View the status, number of instances, service bindings, and resource use of each application in the space                                                                                                                                                                                                                                                                                                                                                |
| Space Developer | Internal             | Moderate          |  Deploy an application,  Start or stop an application,  Rename an application, Delete an application, Create, view, edit, and delete services in a space, Bind or unbind a service to an application, Rename a space, View the status, number of instances, service bindings, and resource use of each application in the space, Change the number of instances, memory allocation, and disk limit of each application in the space, Associate an internal or external URL with an application |
| Space Auditor   | Internal             | Low               | View the status, number of instances, service bindings, and resource use of each application in the space                                                                                                                                                                                                                                                                                                                                                                                   |

## Hardware Inventory

None - Leveraged from AWS Infrastructure|
-|

## Software Inventory

TODO: How do we make this executable?

| Hostname                              | Function                                                                                                                                                                                                                                             | Version   | Patch Level | Virtual (Yes / No) |
|---------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|-------------|--------------------|
| Code Climate | CloudFoundry Static code analysis tool for the source code| Latest Version| NA| Yes|
|GitHub| CloudFondry and Cloud.Gov code repository and version control| Latest Version| NA | Yes|
|Freedonia  AMI| operating system used in deployed EC2 instances for Cloud.Gov| Ubuntu 12.04 LTS| 12| Yes|

The following table lists all other applications and components used in relation to the Cloud.Gov PaaS information system.

|Component Name| Function| Version| Patch Level| Virtual|
|--------------|---------|--------|------------|--------|
|Nessus| Vulnerability scanner for the Cloud.Gov platform| Latest Version |NA|Yes|
|New Relic| Application and performance metrics for Cloud.Gov| Latest Version|NA| Yes|
|Cloudability| Monitor, optimize and govern Cloud Costs related to the AWS Infrastructure| Latest Version |NA| Yes|
|Slack| Message, alert and communications app | Latest Version | NA |Yes|
Trello| Used for agile, scrum and story boarding| Latest Version | NA | Yes|
|VisualOps| Visual DevOps tool for AWS| Latest Version| NA | Yes|
|Pager Duty| Incident communication platform used by DevOps| Latest Version|


## Network Inventory
None - Leveraged from AWS Infrastructure|
-|

## Ports, Protocols and Services
| Ports (T or U) | Protocols | Services                                     | Purpose                                                                                                                                     | Used By                                |
|----------------|-----------|----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| 80 (T)         | HTTP      | HTTP                                         | CF ec2 web service                                                                                                                          | AWS, Cloud Foundry                     |
| 22 (T)         | SSH       | Secure Shell (SSH)                           | Secure command line interface                                                                                                               | AWS, Cloud Foundry Jumpbox             |
| 53 (U)         | DNS       | DNS Service                                  | Inbound DNS requests                                                                                                                        | AWS, Cloud Foundry                     |
| 123 (T)        | NTP       | Network Time Protocol (NTP)                  | Sync time within the network                                                                                                                | Cloud Foundry, AWS CloudTrail, Syslogs |
| 1              | ICMP      | Internet Control Message                     | Information and diagnostics for network devices (Ping)                                                                                      | AWS, Cloud Foundry                     |

## System Interconnections
None - Not Applicable|
-|
