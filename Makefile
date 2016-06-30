CM := ${HOME}/go/src/github.com/opencontrol/compliance-masonry/compliance-masonry

default:
	echo "no default action"

clean:
	rm -rf exports/ _book/ opencontrols/

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
