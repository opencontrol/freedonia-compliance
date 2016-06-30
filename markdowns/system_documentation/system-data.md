# Freedonia compliance

This System Security Plan provides an overview of the security requirements for
the Freedonia Compliance (freedonia-compliance)
and describes the controls in place or planned for implementation to provide a level of security appropriate for the information to be transmitted, processed or stored by the system.  Information security is vital to our critical infrastructure and its effective performance and protection is a key component of our national security program.  Proper management of information technology systems is essential to ensure the confidentiality, integrity and availability of the data transmitted, processed or stored by the


Freedonia Compliance information system.  

The security safeguards implemented for
Freedonia Compliance
meet the policy and control requirements set forth in this System Security Plan.  All systems are subject to monitoring consistent with applicable laws, regulations, agency policies, procedures and practices.  

Unique Identifier | Information System Name | Information System Abbreviation
----------------- | ----------------------- | ---
freedonia-compliance | Freedonia Compliance | fd-comp


# Security Objectives Categorization (FIPS 199)
Security Objective | Low, Moderate or High
--------------- |----------
Confidentiality | Low
Integrity       | Low
Availability    | Low

# Information System Categorization
The overall information system sensitivity categorization is noted in the table that follows.

Low | Moderate | High
--- | --- | ---
X    |    |


Using this categorization, in conjunction with the risk assessment and any unique security requirements, we have established the security controls for this system, as detailed in this SSP.


## Information Types


The following tables identify the information types that are input, stored, processed, and/or output from
Freedonia Compliance.
The selection of information types is based on guidance provided by OMB Federal Enterprise Architecture Program Management Office Business Reference Model 2.0, and FIPS Pub 199, Standards for Security Categorization of Federal Information and Information Systems which is based on NIST SP 800-60, Guide for Mapping Types of Information and Information Systems to Security Categories.

TKTK: The following table needs updating for Freedonia Compliance, currently showing Cloud.gov specs:

|Information Type | Confidentiality   | Integrity | Availability|
|-----------------|-------------------|-----------|-------------|
|C.3.5.1 System Development           |Low        | Moderate    | Low
|C.3.5.2 life-cycle/Change Management |Low        | Moderate    | Low
|C.3.5.3 System Maintenance           |Low        | Moderate    | Low      
|C.3.5.4 Infrastructure Maintenance   |Low        | Low         | Low

## E-Authentication Determination

### E-Authentication Question
Yes | No  | E-Authentication Question
--- | --- | ---
 x  |     | Does the system require authentication via the Internet?
 x  |     | Is data being transmitted over the Internet via browsers?
 x  |     | Do users connect to the system from over the Internet?

Note: Refer to OMB Memo M-04-04 E-Authentication Guidance for Federal Agencies for more information on e-Authentication.

TKTK: The above table is inherited from Cloud.gov

The summary E-Authentication Level is recorded in the table that follows.

### E-Authentication Determination
|System Name| System Owner| Assurance Level| Date Approved|
|-----------|
|Cloud.Gov Platform as a Service| 18F/GSA| Level 2| Feb 18, 2016|

TKTK: The above table is inherited from Cloud.gov

## Information System Owner
Name | Title | Organization | Address | Phone Number | Email Address
--- | --- | --- | --- | --- | ---
Peter Burkholder | Freedonia President-for-Life | GovReady | Address | 202-555-1212 | 1800 J Street NW, Washington, DC 20001 | pburkholder [at] govready.com

## Authorizing Official
Name | Title | Organization | Address | Phone Number | Email Address
--- | --- | --- | --- | --- | ---
Aaron Snow | Authorizing Official | 18F/GSA | 1800 F Street, NW Washington DC 20405 |  | aaron.snow [at] gsa.gov

## Other Designated Contacts
Name | Title | Organization | Address | Phone Number | Email Address
---  | ---   | ---          | ---     | ---          | ---

## Assignment of Security Responsibility
Name | Title | Organization | Address | Phone Number | Email Address
----|----|----|----|----|----

## Information System Operational Status
The system is currently in the life-cycle phase noted in the table that follows.  (**Only operational systems can be granted an ATO**).

TKTK: Is a live system that is in alpha considered Operational or UnderDevelopment?

## System Status
Operational | Under Development | Major Modification | Other
------ | ------ | ------ | ---
&nbsp; |   X    | &nbsp; | &nbsp;

## Information System Type

(this space currently blank)


## Leveraged Authorizations

The Cloud.Gov information system plans to leverage a pre-existing Provisional Authorization.  Provisional Authorizations leveraged by this IAWS FedRAMP ATO (issued by the HHS are noted in the table that follows.  

Information System Name | Service Provider Owner | Date Granted
--- | --- | ---
AWS FedRamp Agency ATO (issued by the HHS) | Amazon |	May 13, 2013

TKTK Clarify how the above applies to a generic implementation on a public cloud.
