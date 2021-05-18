SHELL := /bin/bash
YEARS = 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011

.PHONY : all
all : nlrb

include frf.mk

nlrb : R_ACTION.csv R_BARGAINING_UNIT.csv R_BLOCK.csv			\
	    R_BLOCK_CASES.csv R_CASE.csv R_CASE_CASE_GROUP.csv		\
	    R_CASE_GROUP.csv R_CHALLENGE_ISSUE.csv			\
	    R_CHALLENGE_TABULATION.csv R_CLOSED_CASE.csv		\
	    R_DISMISSAL.csv R_ELECTION.csv R_ELECTION_TALLY.csv		\
	    R_ELECT_AGREEMENT.csv R_ELECT_CERTIFICATION.csv		\
	    R_ELECT_SCHEDULED.csv R_ELECT_VOTES_FOR.csv			\
	    R_IMPACT_CATEGORY.csv R_OBJECTION_ISSUE.csv			\
	    R_PARTICIPANT.csv R_PART_VARIANT.csv			\
	    R_POST_ELECT_BOARD_ACT.csv R_POST_ELECT_HEARING.csv		\
	    R_POST_ELECT_RD_ACT.csv R_PRE_ELECT_BOARD_ACT.csv		\
	    R_PRE_ELECT_HEARING.csv R_PRE_ELECT_RD_BB.csv		\
	    R_PRE_ELECT_RD_DECISION.csv R_PRE_ELECT_RD_ISSUES.csv	\
	    R_REOPENED_CASE.csv R_TRANSFER_HISTORY.csv			\
	    R_WITHDRAWAL.csv CATS-FRF-R.final.csv
	for csv in $(basename $^); do \
		csvsql --db sqlite:///$@ --table $$csv --insert $$csv.csv; \
	done;

R_%.csv : $(patsubst %,%_R_%.csv,$(YEARS))
	csvstack $^ > $@

%.csv : %.xml.utf8
	xml2csv --input $< --output $@ --tag "row"

%.xml.utf8 : %.xml
	iconv -f UTF-16 -t UTF-8 $< > $@

# Explicitly set dependencies for vintage of data since
# we want to use the wildcard for the filename
1999_%.xml : raw/CATS_R_CASE_Data_1999.zip
	unzip -p $< $*.xml > $@

2000_%.xml : raw/CATS_R_CASE_Data_2000.zip
	unzip -p $< $*.xml > $@ 

2001_%.xml : raw/R_2001.zip
	unzip -p $< $*.xml > $@ 

2002_%.xml : raw/R_2002.zip
	unzip -p $< $*.xml > $@ 

2003_%.xml : raw/R_2003.zip
	unzip -p $< $*.xml > $@ 

2004_%.xml : raw/R_2004.zip
	unzip -p $< $*.xml > $@ 

2005_%.xml : raw/R_2005.zip
	unzip -p $< $*.xml > $@ 

2006_%.xml : raw/R_2006.zip
	unzip -p $< $*.xml > $@ 

2007_%.xml : raw/R_2007.zip
	unzip -p $< $*.xml > $@ 

2008_%.xml : raw/R_2008.zip
	unzip -p $< $*.xml > $@ 

2009_%.xml : raw/R_2009.zip
	unzip -p $< $*.xml > $@ 

2010_%.xml : raw/R_2010.zip
	unzip -p $< $*.xml > $@ 

2011_%.xml : raw/R_2011.zip
	unzip -p $< $*.xml > $@ 

