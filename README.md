Welcome to Freedonia
====================

This project uses a stripped down version of the U.S. federal security standards to exemplify the workflow and tooling for continuous compliance

The Republic of Freedonia has a national information security policy for use of cloud providers, FredRAMP, that has been inspired by FedRAMP but with far fewer elements to their standards and certifications.

The starting point are the standards from the Fredonia Institute of Standards, FRIST-800-53, which are identical to NIST-800-53 but only have

* AU-1 - AUDIT AND ACCOUNTABILITY POLICY AND PROCEDURES: organizational control on audit policy
* AU-2 - AUDIT EVENTS: technical control at the node level (send logs to SumoLogic), set at organizational level
* PE-2 - PHYSICAL ACCESS AUTHORIZATIONS: by dint of Provisional-ATO/inheritance
* SC-1 - SYSTEM AND COMMUNICATIONS PROTECTION POLICY AND PROCEDURES: organizational control consumed as a system component, AWS,
* SC-7 - BOUNDARY PROTECTION: technical control technical control consumed as a system component (no 0.0.0.0 access in AWS)
* XX-1 - MOCK/DUMMY CONTROL: this is only here to demonstrate that a control in standard does not have to referenced in a certification.

The certification FredRAMP-low requires all the above controls except for XX-1

The system we're building is `freedonia.fd` which is a 'Hello World' webpage for Freedonia.

The minimim initial tree we need for a standalone SSP is:

```
.
├── README.md
├── certifications
│   └── FredRAMP-low.yaml
├── opencontrol.yaml
└── standards
    └── FRIST-800-53.yaml
```
