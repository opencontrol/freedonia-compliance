# ADD COMPONENTS

This document describes extending the simple Freedonia Compliance SSP to having more control content.

Authoring a System Security Plan in MS Word requires thinking like a writer and adding additional control narratives to the word document.

Authoring a System Security Plan in OpenControl requires thinking like a software engineer by referencing the controls in the main proceedure files (e.g., 'starndard' and 'certification') and then adding the control details to the appropriate source files included in the build (e.g., 'component'). 

In this lesson our Freedonia compliance engineers first make all `standard` and `certification` details local to the Freedonia-Compliance repository and then add an additional component which provides an additional control. The revised SSP includes the content of the added control.

| Paradigm shift alert |
| -------------------- |
| Viewed in isolation, updating multiple different files seems more laborious than changing text in a single word document. But we are actually breaking our System Secrity Plan into smaller, individually referenceable pieces. Such pieces can be re-used and re-assembled automatically again and again across multiple SSP's automagically. The re-use saves us much more time in the future.|

The OpenControl content for this step is in the `lesson_2` directory.

# Step 1 - Making all references local

The intial Freedonia-Compliance OpenControl referendes its `standard` and `certification` as dependencies. That means our OpenControl System Security Plan depends on content located that originates from another, separate repository. Referenced dependencies in shared repositories allows us to quickly re-use content written by others we trust. But we cannot alter remote content easily, so let's first remove dependencies and switch to local content.

| Paradigm shift alert |
| -------------------- |
| Sharing of control content will make nervous security specialists who believe System Security Plans should be secret. Technically, we are not sharing our System Security Plan by re-using control content written by others.  What is being shared is commonly known information regarding how particular components of a system satisfy security controls. The components of your system and the customization of your controls can be secret to your organization. |

Since our main `openconrol.yaml` file defines where to find the various content for the SSP, we need to update that first.

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

Let's convert the `standards` and `certifications` in `dependencies:` to local repository files:

```
schema_version: "1.0.0"
name: freedonia.fd
metadata:
  description: hello_world
  maintainers:
    - pburkholder@pobox.com
components:
  - ./AT_policy
standards:
  - ./lesson_2/standards/FRIST-800-53.yaml
certifications:
  - ./lesson_2/certifications/FredRAMP-low.yaml
dependencies:
  systems:
    - url: https://github.com/opencontrol/freedonia-aws-compliance/
      revision: master
```

| Observations |
|---------------|
| * It is not possible to reference a local repository file in the `dependencies` section |
| * It is not possible to list the same `standard` or `certification` listed both locally in the repository and as `dependencies`|

For convenience, our forward thinking Freedonia software engineers have made `FRIST-800-53.yaml` and `FredRAMP-low.yaml` into local files in the `lesson_2` directory.

The way they created local repository files was to actually copy the files from the remote files they existed into the `lesson_2` directoryusing `wget`. Be I created the `lesson_2` directory and then used `wget` to get the files. You do not need to do this, because I already did. But here are the steps as reference.

```
mkdir lesson_2
cd lesson_2
mkdir certifications
mkdir standards
cd certifications/
wget https://raw.githubusercontent.com/opencontrol/freedonia-frist/master/certifications/FredRAMP-low.yaml
wget https://raw.githubusercontent.com/opencontrol/freedonia-frist/master/certifications/opencontrol.yaml
cd ../standards/
wget https://raw.githubusercontent.com/opencontrol/freedonia-frist/master/standards/FRIST-800-53.yaml
```

Let's copy over our `lesson_2/opencontrol.yaml.lesson_2` file:
```
cp lesson_2/opencontrol.yaml.lesson_2 ./opencontrol.yaml
```


Our new `opencontrol.yaml` is copied from `lesson_2/opencontrol.yaml.lesson_2` and looks like:
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

Next we will see how an additional control gets included in the System Security Plan by referencing the control in the `standard` and the `certification`.

# Step 2 - Referencing controls

For an OpenControl-based System Security Plan to include a control, the control must be referenced in the `standard` file and the `certification` file. This makes sense. If the control isn't part of the standard, why would it exist in the SSP? If the control wasn't selected of a particular certification against the standard, why would it exist in the SSP?

For a control to be included in the SSP, the following must be true:
- The standards file must refer to one or more controls listed (e.g., satified) by the component
- The certification generated must include identifiers of the one or more controls listed (e.g., satisfied) by the component.
- The opencontrol.yaml file must refer to the component
- The `schema_version` in the `component.yaml` file must be supported by the version of `Compliance-Masonry` being used.

In this step, we will discuss referencing of the control in the `standard` and `certification`.

Add the `AT-3` control to the certification and to standard by adding a reference to the unique control ID to the relevant `standard` and `certification` files.  (By convention, FRIST-800-53 security controls use the family abbreviation and a number as unique control identifiers.)

`certifications/FredRAMP-low.yaml` now looks like the below after appending the `AT-3` control:

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

And appending `AT-3` to `standards/FRIST-800-53.yaml` looks like this:

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

Compiling an SSP will work and include the added `AT-3` control but with an interesting result. The section describing `AT-3` will say: "No information found for the combination of standard FRIST-800-53 and control AT-3."

Here are the steps:

```
Gregs-MacBook-Pro:freedonia-compliance greg$ make clean pdf
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

open assets/example.pdf
```

`AT-3`, now part of the `standard` and the `certification` appears in the generated `example.pdf` because it is in the standard and in the certification.

As soon as an a component satifing the `AT-3` control is added to the repo, control content will appear in the System Security Plan. 

# Step 3 - Adding components and control content

Our Freedonia engineers have two choices to include a component in the repo that addresses the AT-3 control. 

Choice 1 is to simply refence existing shared OpenControl content that describes how the component and how it satifies `AT-3`. That's pretty easy and just involves referencing the component in the `dependencies` section.

Choice 2 is to add an OpenControl component file directly to the local repository that describes how the component statifies `AT-3`. This is more involved, but provides more and easier control over the content because the file is local to the rpository.

This section provies and example of Choice 2, adding an OpenControl compoent file to the local repository.

1. Find an existing component you like and copy the file, e.g., https://github.com/18F/cg-compliance/blob/master/AT_Policy/component.yaml

2. create a new directory in `freedonia-compliance` with the name of the component, e.g. `AT_policy`

On *nix:
```
mkdir lesson_2/AT_policy
```

3. Create the `component.yaml` file in the newly created directory.
```
cd lesson_2/AT_policy
touch component.yaml
```

4. Let's `wget` some existing content.

Curl content:
```
# wget raw version of content, example below
# Note that the URL to raw content is different from URL to GitHub page displaying content
wget https://raw.githubusercontent.com/18F/cg-compliance/master/AT_Policy/component.yaml
```

5. Change "18f" to "81Fr"

6. Now that we have the new `component.yaml` file in our local repository, we need to reference the file in our main `opencongrol.yaml` file by adding a line to the `components` section.

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

7.  OK. Now we can try re-running `compliance-masonry` and we should see new references to AT.


```
Gregs-MacBook-Pro:freedonia-compliance greg$ make clean pdf
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

Gregs-MacBook-Pro:freedonia-compliance greg$ open assets/example.pdf 
```

And there's the new control.

| Observations |
|---------------|
| - The first time seems tedious, but we did a lot of work here moving files into the local repository and setting up references.  |
| -  As we go forward, we just need to add control references to `standard` and `certification` files and in add re-usable content to the components. |
| - Because we are working in versioning repository, we also have an excellent record of all changes |



# Step 4 - Publishing the repository

Steps to put this new repository online.

# Step 5 - Recompiling the SSP


# Common Errors

## Referencing a local file in dependencies

Referencing a local repository file in the `dependencies` section with version XX of `Compliance-Masontry` causses an error that looks like this:

```
Gregs-MacBook-Pro:freedonia-compliance greg$ make clean pdf
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

### Currrent reference handling seems like a premature optimization

The sometimes references to a YAML file vs a reference to a repo that you then have to find the opencontrol file and detect the YAML file is pretty painful and seems risky, like the `certifications/opencontrol.yaml` file that is just used to refer to an `FedRAMP-low.yaml` file in same directory. Supporting such optional references in initial version seems liek premature optimization. We simply don't have that many providers of information. The real use case is modifying a local version repo or file version. It would at least be nice to explain how the code works to resolve the possibilities.


### Issues:

Error
`Unknown schema version`
Fix
Is the correct `schema_version: x.x.x` listed in the `component.yaml` files?



