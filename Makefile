.DELETE_ON_ERROR:
.PHONY: all reports clean
.DEFAULT_GOAL:=all

CANBUSBASE:=canbusre
CANBUSDIR:=001-$(CANBUSBASE)
µNANDFSBASE:=µnandfs
µNANDFSDIR:=002-$(µNANDFSBASE)

# Common resources
RESOURCES:=../dsscaw-purp-scaled.png

µNANDFSRESOURCES:=$(RESOURCES) $(addsuffix .png,combined ExtendBlob ReadBlob \
  FSM Initialize FindBlob south)
DIRS:=$(CANBUSDIR) $(µNANDFSDIR)

REPORTS:=$(CANBUSDIR)/$(CANBUSBASE)
REPORTS+=$(µNANDFSDIR)/$(µNANDFSBASE)
REPORTS:=$(addsuffix .pdf,$(REPORTS))

LATEX:=xelatex
BIBTEX:=biber
VIEW:=evince

all: reports

reports: $(REPORTS)

$(µNANDFSDIR)/$(µNANDFSBASE).pdf: $(addprefix $(µNANDFSDIR)/,$(µNANDFSBASE).tex $(µNANDFSBASE).bib $(µNANDFSRESOURCES))
	cd $(@D) && arara -v $(<F)

$(CANBUSDIR)/$(CANBUSBASE).pdf: $(CANBUSDIR)/$(CANBUSBASE).tex $(CANBUSDIR)/$(CANBUSBASE).bib
	cd $(@D) && arara -v $(<F)

clean:
	@rm -vrf $(foreach dir,$(DIRS),$(wildcard $(dir)/*.aux) $(wildcard $(dir)/*.bbl))
	@rm -vrf $(foreach dir,$(DIRS),$(wildcard $(dir)/*.bcf) $(wildcard $(dir)/*.blg))
	@rm -vrf $(foreach dir,$(DIRS),$(wildcard $(dir)/*.log) $(wildcard $(dir)/*.out))
	@rm -vrf $(foreach dir,$(DIRS),$(wildcard $(dir)/*.pdf) $(wildcard $(dir)/*.xml))
	@rm -vrf $(foreach dir,$(DIRS),$(wildcard $(dir)/_minted-*))
