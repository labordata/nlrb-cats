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
	    R_WITHDRAWAL.csv L_ALLEGATION_TYPE.csv                      \
	    L_BLUE_BOOK_CHAPTER.csv L_BLUE_BOOK_CODES.csv		\
            L_BLUE_BOOK_DIVISION.csv L_BLUE_BOOK_HEADING.csv		\
            L_BLUE_BOOK_SECTION.csv L_BRIEF_TYPE.csv L_CASE_PARTY.csv	\
            L_CCR_BACKPAY_CONTROL.csv L_CCR_BARGAIN_STATUS.csv		\
            L_CCR_CHARGE_PARTY_POS.csv L_CCR_CLOSING_STAGE.csv		\
            L_CCR_CLOSING_TYPE.csv L_CCR_COMPLAINT.csv			\
            L_CCR_CONTEMPT_REC_TYPE.csv L_COMPLIANCE_TYPE.csv		\
            L_COUNTY.csv L_COURT.csv L_COURT_TYPE.csv			\
            L_EOT_DETERMINATION.csv L_GEOGRAPHIC_DIVISION.csv		\
            L_GEOGRAPHIC_REGION.csv L_HEARING_RECORD_FORM.csv		\
            L_IMPACT_ANALYSIS_CAT.csv L_INJUNCTION_BRIEF_TYPE.csv	\
            L_INJUNCTION_MOTION_TYPE.csv L_LABOR_ORG_CODE.csv		\
            L_MEMBER_TYPE.csv L_METHOD_FILED_TYPE.csv			\
            L_MOTION_DETER.csv L_NAICS_CODE.csv L_NAICS_INDUSTRY.csv	\
            L_NAICS_INDUSTRY_GROUP.csv L_NAICS_QUALIFIER.csv		\
            L_NAICS_SECTOR.csv L_NAICS_SUBSECTOR.csv			\
            L_NAICS_US_INDUSTRY.csv L_NAME_PREFIX.csv			\
            L_NAME_SUFFIX.csv L_NLRB_BRANCH.csv L_NLRB_DISTRICT.csv	\
            L_NLRB_DIVISION.csv L_NLRB_OFFICE.csv			\
            L_NLRB_OFFICE_TYPE.csv L_NLRB_REGION.csv L_NOTE_TYPE.csv	\
            L_NOTIFICATIONS.csv L_ORGANIZATION.csv			\
            L_ORGANIZATION_NAME.csv L_PARTICIPANT_GROUP.csv		\
            L_PARTI_TYPE.csv L_PARTY_SCOPE.csv L_PARTY_TYPE.csv		\
            L_R_ACTION_FIELDS.csv L_R_AMENDMENT_REASON.csv		\
            L_R_AMENDMENT_TYPE.csv L_R_BARGAIN_UNIT_CODE.csv		\
            L_R_BARGAIN_UNIT_SCOPE.csv L_R_BLOCK_DETERMINATION.csv	\
            L_R_BOARD_ACTION_CODE.csv L_R_BOARD_ACTION_SRC_REASON.csv	\
            L_R_BOARD_RECEIVED_REASON.csv L_R_CASE_ELECT_TYPE.csv	\
            L_R_CASE_GROUP_TYPE.csv L_R_CASE_NOTE_TOPIC.csv		\
            L_R_CASE_TYPE.csv L_R_CHALLENGE_ACT_RESULT.csv		\
            L_R_CHALLENGE_ACT_TYPE.csv L_R_CHALLENGE_ISSUE.csv		\
            L_R_CLOSING_METHOD.csv L_R_CLOSING_STAGE.csv		\
            L_R_ELECT_AGREE_TYPE.csv L_R_ELECT_MODE.csv			\
            L_R_OBJECTION_ISSUE.csv L_R_OBJ_ACT_RESULT.csv		\
            L_R_OBJ_ACT_TYPE.csv L_R_PART_ROLE_TYPE.csv			\
            L_R_POSTELEC_DET_EOT.csv L_R_POSTELEC_DET_P_P.csv		\
            L_R_POSTELEC_HO_DIRECTED.csv L_R_PREELEC_DET_EOT.csv	\
            L_R_PREELEC_HEAR_DET_P_P.csv L_R_PREELEC_RD_DEC_TYPE.csv	\
            L_R_PREELEC_RD_ISSUE_DEC.csv L_R_PREELEC_RD_RECON.csv	\
            L_R_RD_ACTION_DET.csv L_R_RD_ACTION_TYPE.csv		\
            L_R_REASON_TRANSFER.csv L_R_REOPEN_REASON.csv		\
            L_R_STATUS.csv L_R_TALLY_TYPE.csv L_R_TARGETS.csv		\
            L_R_TARGET_DESCRIPTION.csv L_R_TRANSFER_TYPE.csv		\
            L_R_WITH_DET.csv L_SCOPE.csv L_STATE.csv			\
            L_SUPERVISOR_TYPE.csv
	for csv in $(basename $^); do \
	    csvs-to-sqlite -t $$(echo $$csv | tr [:upper:] [:lower:]) $$csv.csv $@; \
	done
	sqlite3 $@ < scripts/schema.sql
	sqlite3 $@ < scripts/transform.sql
	echo 'create index idx_nlrb_case_case_type on nlrb_case (case_type)' | sqlite3 $@

%.csv : %.csv.badheaders
	cat $< | awk 'NR==1{$$0=tolower($$0)}1' > $@

%.csv.badheaders : %.xml.utf8
	xml2csv --input $< --output $@ --tag "row"

%.xml.utf8 : %.xml
	iconv -f UTF-16 -t UTF-8 $< > $@

R_%.xml : raw/R_CATS_FINAL_DATA.zip
	unzip -p $< $@ > $@

L_%.xml : raw/CATS_Lookup_Reference_Data.zip
	unzip -p $< $@ > $@

R_BARGAINING_UNIT.xml : raw/CATS_R_CASE_Data.zip
	unzip -p $< $@ > $@ 

raw/R_CATS_FINAL_DATA.zip :
	wget -O $@ "https://web.archive.org/web/20170505185504/https://www.nlrb.gov/nlrb/datagov/R_CATS_FINAL_DATA.zip"

raw/CATS_R_CASE_Data.zip :
	wget -O $@ https://web.archive.org/web/20170505184520/https://www.nlrb.gov/nlrb/datagov/CATS_R_CASE_Data.zip

raw/CATS_Lookup_Reference_Data.zip :
	wget -O $@ "https://web.archive.org/web/20110429172416/http://www.nlrb.gov/nlrb/datagov/CATS_Lookup_Reference_Data.zip"
