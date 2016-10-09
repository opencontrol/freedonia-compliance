# ADD COMPONENTS

This document describes how to extend the simple Freedonia Compliance System Security Plan (SSP) to include more control content.

Table of Contents
=================

  * [Add Components Overview](#add-components-overview)
    * [Step 1 - Making all references local](#step-1---making-all-references-local)
    * [Step 2 - Referencing controls](#step-2---referencing-controls)
    * [Step 3 - Adding components and control content](#step-3---adding-components-and-control-content)
    * [Step 4 - Publishing the repository](#step-4---publishing-the-repository)
    * [Step 5 - Recompiling the SSP](#step-5---recompiling-the-ssp)
  * [Common Errors](#common-errors)
    * [Referencing a local file in dependencies](#referencing-a-local-file-in-dependencies)
  * [Observations](#observations)
    * [Current reference handling seems like a premature optimization](#current-reference-handling-seems-like-a-premature-optimization)
      * [Issues:](#issues)
	  
# Add Components Overview

Authoring a System Security Plan in MS Word requires thinking like a writer and adding additional control narratives to the word document.

Authoring a System Security Plan in OpenControl requires thinking like a software engineer by referencing the controls in the main procedure files (e.g., `standards` and `certifications`) and then adding the control details to the appropriate source files included in the build (e.g., 'component'). 

In this lesson our Freedonia Compliance engineers first make all `standards` and `certifications` details local to the *freedonia-compliance* repository and then add an additional component which provides an additional control. The revised SSP includes the content of the added control.

| Paradigm shift alert |
| -------------------- |
| Viewed in isolation, updating multiple different files seems more laborious than changing text in a single MS Word document. But we are actually breaking our System Security Plan into smaller, individually referenceable pieces. Such pieces can be re-used and re-assembled automatically again and again across multiple SSP's automagically. The re-use saves us much more time in the future.|

The OpenControl content for this step is in the `lesson_2` directory.

## Step 1 - Making all references local

The intial Freedonia-Compliance OpenControl references its `standards` and `certifications` as dependencies. That means our OpenControl System Security Plan depends on content located that originates from another, separate repository. Referenced dependencies in shared repositories allows us to quickly re-use content written by others we trust. But we cannot alter remote content easily, so let's first remove dependencies and switch to local content.

| Paradigm shift alert |
| -------------------- |
| Sharing of control content will make nervous security specialists who believe System Security Plans should be secret. Technically, we are not sharing our System Security Plan by re-using control content written by others.  What is being shared is commonly known information regarding how particular components of a system satisfy security controls. The components of your system and the customization of your controls can be secret to your organization. |

Since our main `opencontrol.yaml` file defines where to find the various content for the SSP, we need to update that first.

Here's the original `opencontrol.yaml` file from Freedonia-Compliance.

```
schema_version: "1.0.0"
name: freedonia.fd
metadata:
  description: hello_world
  maintainers:
    - pburkholder@pobox.com
components:
  - ./AU_policy
dependencies:
  standards:
    - url: https://github.com/opencontrol/freedonia-frist/
      revision: master
  certifications:
    - url: https://github.com/opencontrol/freedonia-frist/
      revision: master
  systems:
    - url: https://github.com/opencontrol/freedonia-aws-compliance/
      revision: master
```

Before converting the `standards` and `certifications` in `dependencies:` to point to local repository files, some observations:


| Observations |
|---------------|
| * It is not possible to reference a local repository file in the `dependencies` section |
| * It is not possible to list the same `standards` or `certifications` locally in the repository and as `dependencies`|

For convenience, our forward thinking Freedonia software engineers have pulled `FRIST-800-53.yaml` and `FredRAMP-low.yaml` into local files in the `lesson_2` directory using wget. Here are the steps as reference:
```
mkdir lesson_2
cd lesson_2
mkdir certifications standards
wget -P certifications https://raw.githubusercontent.com/opencontrol/freedonia-frist/master/certifications/FredRAMP-low.yaml
wget -P certifications https://raw.githubusercontent.com/opencontrol/freedonia-frist/master/certifications/opencontrol.yaml
wget -P standards https://raw.githubusercontent.com/opencontrol/freedonia-frist/master/standards/FRIST-800-53.yaml
```

The `lessen_2` directory also has a pre-created YAML file with local reference links. The pre-prepared `lesson_2/opencontrol.yaml.step1` looks like:
```
schema_version: "1.0.0"
name: freedonia.fd
metadata:
  description: hello_world
  maintainers:
    - pburkholder@pobox.com
components:
  - ./AU_policy
standards:
  - ./lesson_2/standards/FRIST-800-53.yaml
certifications:
  - ./lesson_2/certifications/FredRAMP-low.yaml
dependencies:
  systems:
    - url: https://github.com/opencontrol/freedonia-aws-compliance/
      revision: master
```

Copy it to the top level - overwriting the local `opencontrol.yaml` file - so that *compliance-masonry* can find it:
```
cp lesson_2/opencontrol.yaml.step1 ./opencontrol.yaml
```

## Step 2 - Referencing controls

We're going to add the `AT-3` control to *freedonia-compliance*.

For a control to be included in the SSP, the following must be true:
- The `standards` file must refer to one or more controls listed (e.g., satified) by the component
- The `certifications` generated must include identifiers of one or more controls listed (e.g., satisfied) by the component.
- The `opencontrol.yaml` file must refer to the component
- The `schema_version` in the `component.yaml` file must be supported by the version of *compliance-masonry* being used.

Therefore, the `AT-3` control must be referenced in `standards` and `certifications`.

_If you look at the files in `lesson_2` you'll see that the `certifications` and `standards` discussed below have already been created, so no action - other than compiling the new SSP - is required in this step._

Add a reference to the unique control ID `AT-3` to the relevant `standards` and `certifications` files.  (By convention, FRIST-800-53 security controls use the family abbreviation and a number as unique control identifiers.)

Now `lesson_2/certifications/FredRAMP-low.yaml` looks like:

```
name: FredRAMP-low
standards:

  FRIST-800-53:
    AU-1: {}
    AU-2: {}
    PE-2: {}
    SC-1: {}
    SC-7: {}
    AT-3: {}
```

And `lesson_2/standards/FRIST-800-53.yaml` looks like:

```
name: FRIST-800-53
AU-1:
  family: AU
  name: Audit and Accountability Policy and Procedures
AU-2:
  family: AU
  name: Audit Events
AU-2 (3):
  family: AU
  name: Audit Events | Reviews and Updates
PE-2:
  family: PE
  name: Physical Access Authorizations
SC-1:
  family: SC
  name: System and Communications Protection Policy and Procedures
SC-7:
  family: SC
  name: Boundary Protection
XX-1:
  family: XX
  name: Dummy Mock Control
AT-3:
  family: AT
  name: Role-Based Security Training
```

Compiling the SSP will include the added `AT-3` control:
```
$ make clean pdf
rm -rf exports/ opencontrols/
compliance-masonry get
Compliance Dependencies Installed
compliance-masonry docs gitbook FredRAMP-low
New Gitbook Documentation Created
cd exports && gitbook pdf ./ ../assets/example.pdf
info: 6 plugins are installed 
info: loading plugin "highlight"... OK 
info: loading plugin "search"... OK 
info: loading plugin "lunr"... OK 
info: loading plugin "sharing"... OK 
info: loading plugin "fontsettings"... OK 
info: loading plugin "theme-default"... OK 
info: found 15 pages 
info: found 1 asset files 
info: >> generation finished with success in 5.9s ! 
info: >> 1 file(s) generated 

$ open assets/example.pdf
```

Note that the section describing `AT-3` says: "No information found for the combination of standard FRIST-800-53 and control AT-3."

Since `AT-3` is now part of the `standards` and the `certifications` it appears in the generated `example.pdf` but the content is missing because there is no component satisfying the control.

## Step 3 - Adding components and control content

Our Freedonia engineers have two choices to include a component in the repo that addresses the AT-3 control. 

- Choice 1 is to simply reference existing shared OpenControl content that describes the component and how it satifies `AT-3`. That's pretty easy and just involves referencing the component in the `dependencies` section.
- Choice 2 is to add an OpenControl component file directly to the local repository that describes how the component statifies `AT-3`. This is more involved, but provides better control over the content because the file is local to the repository.

This section provides an example of Choice 2, adding an OpenControl component file to the local repository.

Create a new directory in `freedonia-compliance` with the name of the component, e.g. `AT_policy`. Then pull in an example `component.yaml` file and convert it for use by Freedonia.

This step has already been done by the Freedonia engineers. For completeness, here are the steps (on *nix):
```
mkdir -p lesson_2/AT_policy
wget -P lesson_2/AT_policy https://raw.githubusercontent.com/18F/cg-compliance/master/AT_Policy/component.yaml
sed -i -- 's/18F/81Fr/g' lesson_2/AT_policy/component.yaml
```

Reference the new component file in the main `opencontrol.yaml` file by adding a line to the `components` section.
The `lessen_2` directory also has a pre-created YAML file containing the component reference. The pre-prepared `lesson_2/opencontrol.yaml.step3` looks like:
```
schema_version: "1.0.0"
name: freedonia.fd
metadata:
  description: hello_world
  maintainers:
    - pburkholder@pobox.com
components:
  - ./AU_policy
  - ./lesson_2/AT_policy
standards:
  - ./lesson_2/standards/FRIST-800-53.yaml
certifications:
  - ./lesson_2/certifications/FredRAMP-low.yaml
dependencies:
  systems:
    - url: https://github.com/opencontrol/freedonia-aws-compliance/
      revision: master
```

Copy it to the top level - overwriting the local `opencontrol.yaml` file - so that *compliance-masonry* can find it:
```
cp lesson_2/opencontrol.yaml.step3 opencontrol.yaml
```

Now re-run `compliance-masonry` and we should see new references to AT.
```
$ make clean pdf
rm -rf exports/ opencontrols/
compliance-masonry get
Compliance Dependencies Installed
compliance-masonry docs gitbook FredRAMP-low
New Gitbook Documentation Created
cd exports && gitbook pdf ./ ../assets/example.pdf
info: 6 plugins are installed 
info: loading plugin "highlight"... OK 
info: loading plugin "search"... OK 
info: loading plugin "lunr"... OK 
info: loading plugin "sharing"... OK 
info: loading plugin "fontsettings"... OK 
info: loading plugin "theme-default"... OK 
info: found 15 pages 
info: found 1 asset files 
info: >> generation finished with success in 4.7s ! 
info: >> 1 file(s) generated 

$ open assets/example.pdf 
```

And there's the new control.

| Observations |
|---------------|
| - The first time seems tedious, but we did a lot of work here moving files into the local repository and setting up references.  |
| -  As we go forward, we just need to add control references to the `standards` and `certifications` files and in add re-usable content to the components. |
| - Because we are working in versioning repository, we also have an excellent record of all changes |


## Step 4 - Publishing the repository

Steps to put this new repository online.

## Step 5 - Recompiling the SSP


# Common Errors

## Referencing a local file in dependencies

Referencing a local repository file in the `dependencies` section with version XX of `Compliance-Masonry` causses an error that looks like this:

```
$ make clean pdf
rm -rf exports/ opencontrols/
compliance-masonry get
Unable to parse yaml data - yaml: unmarshal errors:
  line 11: cannot unmarshal !!str `./lesso...` into common.Entry
  line 13: cannot unmarshal !!str `./lesso...` into common.Entry
make: [opencontrols] Error 1 (ignored)
compliance-masonry docs gitbook FredRAMP-low
Error: `opencontrols/certifications` directory does exist
make: *** [exports] Error 1
```

# Observations

## Current reference handling seems like a premature optimization

The sometimes references to a YAML file vs a reference to a repo that you then have to find the opencontrol file and detect the YAML file is pretty painful and seems risky, like the `certifications/opencontrol.yaml` file that is just used to refer to an `FedRAMP-low.yaml` file in same directory. Supporting such optional references in initial version seems like premature optimization. We simply don't have that many providers of information. The real use case is modifying a local version repo or file version. It would at least be nice to explain how the code works to resolve the possibilities.


### Issues:

Error
`Unknown schema version`
Fix
Is the correct `schema_version: x.x.x` listed in the `component.yaml` files?

