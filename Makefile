PANDOC  = pandoc
CRYSTAL = crystal

PANDOC_FILTER = build/pandoc_filter

PANDOC_OPT  = \
	--latex-engine=lualatex               \
	-V documentclass=bxjsbook             \
	-V papersize=b5                       \
	-V classoption=pandoc                 \
	-V classoption=jafont=ipaex           \
	--number-sections --toc --toc-depth=2 \
	--chapters                            \
	--listings -H tools/header.tex
CRYSTAL_OPT = --release

MD =                                       \
	index.md                                 \
	pine/README.md                           \
	arcage/README.md                         \
	ucmsky/crystal-and-web/README.md         \
	ucmsky/metaprogramming-crystal/README.md \
	rhysd/README.md                          \
	nob-suz/README.md                        \
	MakeNowJust/README.md                    \

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
