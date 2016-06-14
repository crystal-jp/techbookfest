PANDOC  = pandoc
CRYSTAL = crystal

PANDOC_FILTER = build/pandoc_filter

PANDOC_OPT  = \
	--latex-engine=lualatex                \
	-V documentclass=ltjsbook              \
	--number-sections --toc                \
	--chapters
CRYSTAL_OPT = --release

MD = \
	index.md

.PHONY: all
all: build/techbookfest.pdf

build/techbookfest.pdf: $(MD) $(PANDOC_FILTER) build/
	$(PANDOC) -f markdown --filter $(PANDOC_FILTER) $(MD) -o $@ $(PANDOC_OPT)

build/pandoc_filter: tools/pandoc_filter.cr build/
	$(CRYSTAL) build -o $@ $(CRYSTAL_OPT) $<

build/:
	mkdir -p build

.PHONY: clean
clean:
	rm techbookfest.pdf
	rm tools/pandoc_filter
