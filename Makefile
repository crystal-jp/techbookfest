PANDOC  = pandoc
CRYSTAL = crystal

PANDOC_FILTER = build/pandoc_filter

PANDOC_OPT  = \
	--latex-engine=lualatex               \
	-V documentclass=ltjsbook             \
	--number-sections --toc --toc-depth=2 \
	--chapters                            \
	--listings -H tools/header.tex
CRYSTAL_OPT = --release

MD =            \
	index.md

.PHONY: all
all: build/techbookfest.pdf

build/techbookfest.pdf: $(MD) $(PANDOC_FILTER) tools/header.tex build/
	$(PANDOC) -f markdown --filter $(PANDOC_FILTER) $(MD) -o $@ $(PANDOC_OPT)

build/pandoc_filter: tools/pandoc_filter.cr build/
	$(CRYSTAL) compile -o $@ $(CRYSTAL_OPT) $<

build/:
	mkdir -p build

.PHONY: clean
clean:
	rm -rf build/