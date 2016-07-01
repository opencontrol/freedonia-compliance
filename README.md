Welcome to Freedonia
====================

This project uses a stripped down version of the U.S. federal security standards to exemplify the workflow and tooling for continuous compliance.

Scenario:
--------

For this exercise, we'll take the role of IT staff for the Republic of Freedonia.

Freedonia has a national information security policy for use of cloud providers, FredRAMP, that has been inspired by FedRAMP but with far fewer elements to their standards and certifications.

The starting point are the standards from the Freedonia Institute of Standards, FRIST-800-53, which are identical to NIST-800-53 but only have

* AU-1 - AUDIT AND ACCOUNTABILITY POLICY AND PROCEDURES: organizational control on audit policy
* AU-2 - AUDIT EVENTS: technical control at the node level (send logs to SumoLogic), set at organizational level
* PE-2 - PHYSICAL ACCESS AUTHORIZATIONS: by dint of Provisional-ATO/inheritance
* SC-1 - SYSTEM AND COMMUNICATIONS PROTECTION POLICY AND PROCEDURES: organizational control consumed as a system component, AWS,
* SC-7 - BOUNDARY PROTECTION: technical control technical control consumed as a system component (no 0.0.0.0 access in AWS)
* XX-1 - MOCK/DUMMY CONTROL: this is only here to demonstrate that a control in standard does not have to referenced in a certification.

The certification FredRAMP-low requires all the above controls except for XX-1

The system we're building is the 'Hello world' website for Freedonia, which will comprise:
- Two Amazon Web Service Virtual Private Clouds (AWS VPCs),
one each for development and production
- In each VPC, one node with `nginx` web server and the static content for a website
- A release process for this code, and some infrastructure for logging traffic

Expected SSP Documentation for the ATO
--------------------------------------

To obtain the Authority to Operate (ATO) we'll need an SSP (System Security Plan), and we use the tooling the from [OpenControl](https://github.com/opencontrol) to do so. With the tooling we can generate PDF documents, and a website that looks like this on the front page:

> ![frontpage](./assets/frontpage.png)

and like this on a page for particular control:

> ![detailpage](./assets/detailpage.png)

A complete generated PDF is [included here](./assets/example.pdf)

The minimum initial tree we need for a standalone SSP is:

```
.
├── README.md   # the file you're reading now
├── AU_policy
│   └── component.yaml        # a local description of the Audit policy (AU)
├── certifications
│   └── FredRAMP-low.yaml     # a mapping of which controls from standards/FRIST-800-53 are needed for certification
├── markdowns         
│   ├── README.md             # the introduction to the entire SSP
│   ├── SUMMARY.md            # a table of contents for narrative documents of the SSP
│   └── system_documentation  # directory for narrative documents
│       ├── about-the-ssp.md
│       ├── system-data.md
│       └── system-description.md
├── opencontrol.yaml          # the schema for SSP and its remote resources/dependencies
└── standards
    └── FRIST-800-53.yaml     # the security control standards list by family and name
```

*The 1.1.1 release of `compliance-masonry` requires at least one-component to run, hence the nearly empty `AU_policy`*

Building and updating the SSP
-----------------------------

These steps assume you already have (for a \*nix type operating system):
- `compliance-masonry` (and go prerequistes) installed per notes at https://github.com/opencontrol/compliance-masonry
  - As of 1 July 2016, testing is with version 1.1.1
- `node-js` installed for local viewing at https://localhost:4000 OR
- `calibre` installed for PDF generation
  -  For Os X with Homebrew installed, try `brew cask install calibre`

Clone this repo, then `cd` into `freedonia-compliance`.  Then run:

```
compliance-masonry get
compliance-masonry docs gitbook FredRAMP-low
cd exports && gitbook serve
# or generate the PDF `exports/compliance.pdf`:
cd exports && gitbook pdf ./ ./compliance.pdf
```

The steps above are included in the project's `Makefile` so you can reliably run, say:

```
make clean pdf
# or
make clean serve
```

Feedback
--------

Please open issues at the [ATO1Day
Project](https://github.com/pburkholder/ato1day-compliance/issues), instead of within this repository.
