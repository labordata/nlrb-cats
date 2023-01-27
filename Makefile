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
	    R_WITHDRAWAL.csv L_ALLEGATION_TYPE.csv			\
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
	    L_SUPERVISOR_TYPE.csv CL_C_CLOSED_CASE_REPORT.csv		\
	    CL_C_CLOSED_CASE_REPORT_ALLEG.csv CL_C_WITHDRAWAL.csv	\
	    C_10K.csv C_ADVICE.csv C_ALJ_DECISION.csv			\
	    C_ALJ_DECISION_BB.csv C_ALJ_MOTION.csv C_ALLEGATION.csv	\
	    C_ALLEG_ACTION.csv C_AMENDMENT.csv C_APPEAL.csv		\
	    C_Bankruptcy.csv C_BOARD_DECISION.csv C_BOARD_DEC_BB.csv	\
	    C_BOARD_OTHER_MOTIONS.csv C_CASE.csv			\
	    C_CASE_CASE_GROUP.csv C_CASE_GROUP.csv C_CLOSING.csv	\
	    C_COLLECTION_ACTIVITIES.csv C_COMPLAINT.csv			\
	    C_COMPLIANCE_GOALS.csv C_COMPLIANCE_SPEC.csv		\
	    C_CONTEMPT.csv C_DEFERRAL.csv C_DISCOVERY.csv		\
	    C_DISMISSAL.csv C_ENFORCEMENT.csv C_HEARING.csv		\
	    C_IMPACT_CATEGORY.csv C_INJUNCTION_10J.csv			\
	    C_INJUNCTION_10L.csv C_INJ_10J_APPEAL.csv			\
	    C_MOTIONS_AFFECT_CMP.csv C_MOTION_SUMM_JUDGE.csv		\
	    C_PARTICIPANT.csv C_REGIONAL_COMPLIANCE.csv			\
	    C_REGIONAL_DETER.csv C_REOPENING.csv C_R_BLOCK.csv		\
	    C_SETTLEMENT.csv C_SUPREME_COURT.csv C_SUP_ALJD_CMP.csv	\
	    C_SUP_BOARD_DEC_CMP.csv C_TRANSFER_HISTORY.csv		\
	    L_C_10J_ADVICE_DETER.csv L_C_10J_BOARD_DETER.csv		\
	    L_C_10J_BRIEF_TYPE.csv L_C_10J_DISCOVERY_TYPE.csv		\
	    L_C_10J_FINAL.csv L_C_10J_JUDGEMENT.csv			\
	    L_C_10J_MOTION_DETERM.csv L_C_10J_MOTION_TYPE.csv		\
	    L_C_10J_REASON_CEASE.csv L_C_10J_REG_DETERM_CODE.csv	\
	    L_C_10L_CO_DETERM.csv L_C_10L_DISCOVERY_TYPE.csv		\
	    L_C_10L_FINAL.csv L_C_10L_MOTION_DETERM.csv			\
	    L_C_10L_REASON_CEASE.csv L_C_10L_REG_DETERM.csv		\
	    L_C_ABEYANCE_CODE.csv L_C_ACCORDANCE_WITH.csv		\
	    L_C_ACTION_FIELDS.csv L_C_ADVICE_DETERMINATION.csv		\
	    L_C_ADVICE_TYPE.csv L_C_ALJ_CMP_DETER.csv			\
	    L_C_ALJ_DETERMINATION.csv L_C_ALJ_MOT_TYP.csv		\
	    L_C_ALLEG_ACT_TYPE.csv L_C_AMENDMENT_REASON.csv		\
	    L_C_AMENDMENT_TYPE.csv L_C_APP_BRIEF_PLEADING.csv		\
	    L_C_APP_COURT_ACT_TYPE.csv L_C_APP_COURT_ACTION.csv		\
	    L_C_APPEAL_ACTION.csv L_C_APPEAL_DETER.csv			\
	    L_C_APPELLATE_COURT.csv L_C_APPELLATE_ENF_DETER.csv		\
	    L_C_BANK_PET_TYPE.csv L_C_BD_CONTEMPT.csv			\
	    L_C_BD_DETER_CERTIORARI.csv L_C_BOARD_DETERMINATION.csv	\
	    L_C_BOARD_MOTION_DETER.csv L_C_BOARD_MOTION_TYPE.csv	\
	    L_C_BOARD_RECON_DETER.csv L_C_CASE_GROUP_TYPE.csv		\
	    L_C_CASE_NOTE_TOPIC.csv L_C_CASE_SCOPE.csv			\
	    L_C_CASE_TYPE.csv L_C_CLOSE_DETERMINATION.csv		\
	    L_C_CLOSE_METHOD.csv L_C_CLOSE_TIMING.csv			\
	    L_C_CMP_LETTER_TYPE.csv L_C_CMP_SPEC_SW_ACTION.csv		\
	    L_C_CMP_SPEC_SW_PARTICIPATION.csv				\
	    L_C_COMP_MOTION_DETER.csv L_C_COMP_MOTION_FORUM.csv		\
	    L_C_COMP_MOTION_TYPE.csv L_C_COMPLAINT_REASON.csv		\
	    L_C_COMPLIANCE_REASON.csv L_C_CONTEMPT_DETER.csv		\
	    L_C_CONTEMPT_SETTLEMENT.csv L_C_DEFERRAL_TYPE.csv		\
	    L_C_DISCHARGE_BANK_ACT.csv L_C_DISCOVERY_CT_DETER.csv	\
	    L_C_DISMISSAL_REVOKE.csv L_C_ENF_COURT_ACT_TYPE.csv		\
	    L_C_ENF_COURT_ACTION.csv L_C_ENFORCEMENT_SETTLEMENT.csv	\
	    L_C_ESCROW_ACC_LOC.csv L_C_FORMAL_SETTLE_TYPE.csv		\
	    L_C_FS_SUBMITTED.csv L_C_GC_RECOMMENDATION.csv		\
	    L_C_GOAL_DESCRIPTION.csv L_C_GOALS.csv			\
	    L_C_HEAC_DET_P_P.csv L_C_HEARING_TYPE.csv			\
	    L_C_INJ_APPELLATE_DEC.csv L_C_INJ_COURT_ORDER_TYP.csv	\
	    L_C_INJ_EVIDENCE_TYPE.csv L_C_INJ_REL_TYPE.csv		\
	    L_C_INJ_RELIEF_DETER.csv L_C_INJ_RELIEF_RECIPIENT.csv	\
	    L_C_METHOD_OF_DISP.csv L_C_MOTION_SUMM_JUDGE.csv		\
	    L_C_OVERAGE_DECISION.csv L_C_OVERAGE_REASON.csv		\
	    L_C_P_P_DETER_SOURCE.csv L_C_PART_ROLE_TYPE.csv		\
	    L_C_POSTING_TYPE.csv L_C_PROOF_CLAIM_CAT.csv		\
	    L_C_REASON_TRANSFER.csv L_C_REG_DET_AGENDA_TYP.csv		\
	    L_C_REG_DET_DEC_LEVEL.csv L_C_REG_DET_TYPE.csv		\
	    L_C_REOPEN_REASON.csv L_C_SETTLE_PART.csv			\
	    L_C_SETTLEMENT_BD.csv L_C_SOM_DETERMINATION.csv		\
	    L_C_SPIELBERG_DETERM.csv L_C_STATUS.csv			\
	    L_C_SUPREME_CT_DETER.csv L_C_SUPREME_CT_PET_DETER.csv	\
	    L_C_TIMING_OF_DISP.csv L_C_TRANSFER_TYPE.csv		\
	    L_C_WILLINGNESS_TYPE.csv L_C_WITH_DISPOSITION.csv		\
	    L_C_WITH_REVOCATION.csv L_C_WITH_SCOPE.csv
	sqlite3 $@ < scripts/schema.sql
	for csv in $(basename $^); do \
	    csvs-to-sqlite -t $$(echo $$csv | tr [:upper:] [:lower:]) $$csv.csv $@ || exit 1 ; \
	done
	sqlite-utils convert $@ r_case nlrb_office_id '"{:0>2}".format(value)'

L_%_ACTION_FIELDS.csv : L_%_ACTION_FIELDS.csv.badheaders
	cat $< | \
            awk 'NR==1{$$0=tolower($$0)}1' | \
            sed '1 s/table_name/tbl_name/' | \
            csvsort -I | \
            uniq >  $@

%.csv : %.csv.badheaders
	cat $< | awk 'NR==1{$$0=tolower($$0)}1' | csvsort -I | uniq > $@

%.csv.badheaders : %.xml.utf8
	xml2csv --input $< --output $@ --tag "row"

%.xml.utf8 : %.xml
	iconv -f UTF-16 -t UTF-8 $< > $@

C_%.xml : raw/C_CATS_FINAL_DATA.zip
	unzip -p $< $@ > $@

R_%.xml : raw/R_CATS_FINAL_DATA.zip
	unzip -p $< $@ > $@

L_%.xml : raw/CATS_Lookup_Reference_Data.zip
	unzip -p $< $@ > $@

R_BARGAINING_UNIT.xml : raw/CATS_R_CASE_Data.zip
	unzip -p $< $@ > $@ 

raw/R_CATS_FINAL_DATA.zip :
	wget -O $@ "https://web.archive.org/web/20170505185504/https://www.nlrb.gov/nlrb/datagov/R_CATS_FINAL_DATA.zip"

raw/C_CATS_FINAL_DATA_split.zip :
	wget $@ "https://web.archive.org/web/20170505185504/https://www.nlrb.gov/nlrb/datagov/C_CATS_FINAL_DATA.zip"
	zip C_CATS_FINAL_DATA.zip --out $@ -s 100m

raw/C_CATS_FINAL_DATA.zip : raw/C_CATS_FINAL_DATA_split.zip
	zip -FF $< --out $@

raw/CATS_R_CASE_Data.zip :
	wget -O $@ https://web.archive.org/web/20170505184520/https://www.nlrb.gov/nlrb/bdatagov/CATS_R_CASE_Data.zip

raw/CATS_Lookup_Reference_Data.zip :
	wget -O $@ "https://web.archive.org/web/20110429172416/http://www.nlrb.gov/nlrb/datagov/CATS_Lookup_Reference_Data.zip"
