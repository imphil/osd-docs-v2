# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = OpenSoCDebug
SOURCEDIR     = .
BUILDDIR      = build

SVG2PDF       = inkscape
SVG2PDF_FLAGS =

# Build a list of SVG files to convert to PDFs
#PDFs := $(foreach dir, $(IMAGEDIRS), $(patsubst %.svg,%.pdf,$(wildcard $(SOURCEDIR)/$(dir)/*.svg)))
IMAGES_SVG := $(shell find $(SOURCEDIR) -name '*.svg')
IMAGES_PDF := $(IMAGES_SVG:.svg=.pdf)


# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

%.pdf : %.svg
	$(SVG2PDF) -f $< -A $@

# Convert images from SVG to PDF for LaTeX PDF output
images-pdf: $(IMAGES_PDF)

# Convert images to PDF before running the LaTeX PDF build
latexpdf: Makefile images-pdf
	@$(SPHINXBUILD) -M latexpdf "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

clean-images:
	-rm $(IMAGES_PDF)

clean: Makefile clean-images
	@$(SPHINXBUILD) -M clean "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)


.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
.DEFAULT: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
