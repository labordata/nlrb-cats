SHELL := /bin/bash
YEARS = 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011

.PHONY : all
all : nlrb.sqlite

# Load into sqlite, table names are the base file nameswithout the R_ prefix
nlrb.sqlite : R_ACTION.csv R_BARGAINING_UNIT.csv R_BLOCK.csv		\
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
	    R_WITHDRAWAL.csv 
	for csv in $(basename $^); do \
	    csvs-to-sqlite -t $$(echo $$csv | tr [:upper:] [:lower:]) $$csv.csv $@; \
	done
	sqlite3 $@ < scripts/schema.sql
	sqlite3 $@ < scripts/transform.sql

%.csv : %.csv.badheaders
	cat $< | awk 'NR==1{$$0=tolower($$0)}1' > $@

%.csv.badheaders : %.xml.utf8
	xml2csv --input $< --output $@ --tag "row"

%.xml.utf8 : %.xml
	iconv -f UTF-16 -t UTF-8 $< > $@

R_%.xml : raw/R_CATS_FINAL_DATA.zip
	unzip -p $< $@ > $@

R_BARGAINING_UNIT.xml : raw/CATS_R_CASE_Data.zip
	unzip -p $< $@ > $@ 

raw/R_CATS_FINAL_DATA.zip :
	wget -O $@ "https://web.archive.org/web/20170505185504/https://www.nlrb.gov/nlrb/datagov/R_CATS_FINAL_DATA.zip"

raw/CATS_R_CASE_Data.zip :
	wget -O $@ https://web.archive.org/web/20170505184520/https://www.nlrb.gov/nlrb/datagov/CATS_R_CASE_Data.zip

raw/CATS_Lookup_Reference_Data.zip :
	wget -O $@ "https://web.archive.org/web/20110429172416/http://www.nlrb.gov/nlrb/datagov/CATS_Lookup_Reference_Data.zip"
