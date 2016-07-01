# This makefile provides some shortcuts to generating update documents
# based on any changes in the input files. Typical usage to make a
# PDF complete from all sources:
#    `make clean pdf`
# or likewise for serving the content:
#    `make clean serve`
#
# FIXME: Add rules so generated files are compared instead of their directories

CM := compliance-masonry

default: pdf

clean:
	rm -rf exports/ opencontrols/

pdf: exports
	cd exports && gitbook pdf ./ ./compliance.pdf

serve: exports
	cd exports && gitbook serve

exports: opencontrols
	${CM} docs gitbook FredRAMP-low

opencontrols: opencontrol.yaml */component.yaml certifications/*yaml standards/*yaml markdowns/*/*md markdowns/*md
	${CM} get

coverage:
	${CM} diff FredRAMP-low
