
default:
	echo "no default action"

clean:
	rm -rf exports/ _book/ opencontrols/

pdf: exports
	cd exports && gitbook pdf ./ ./compliance.pdf

exports: opencontrols
	compliance-masonry docs gitbook FredRAMP-low

opencontrols: opencontrol.yaml
	compliance-masonry get
