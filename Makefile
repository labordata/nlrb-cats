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
	    R_WITHDRAWAL.csv L_BLUE_BOOK_CHAPTER.csv			\
	    L_BLUE_BOOK_CODES.csv L_BLUE_BOOK_DIVISION.csv		\
	    L_BLUE_BOOK_HEADING.csv L_BLUE_BOOK_SECTION.csv		\
	    L_CASE_PARTY.csv L_COUNTY.csv L_GEOGRAPHIC_DIVISION.csv	\
	    L_GEOGRAPHIC_REGION.csv L_LABOR_ORG_CODE.csv		\
	    L_NAICS_CODE.csv L_NAICS_INDUSTRY.csv			\
	    L_NAICS_INDUSTRY_GROUP.csv L_NAICS_SECTOR.csv		\
	    L_NAICS_SUBSECTOR.csv L_NAICS_US_INDUSTRY.csv		\
	    L_NLRB_BRANCH.csv L_NLRB_DISTRICT.csv L_NLRB_DIVISION.csv	\
	    L_NLRB_OFFICE.csv L_NLRB_OFFICE_TYPE.csv			\
	    L_NLRB_REGION.csv L_ORGANIZATION.csv			\
	    L_ORGANIZATION_NAME.csv L_PARTICIPANT_GROUP.csv		\
	    L_PARTI_TYPE.csv L_PARTY_SCOPE.csv L_PARTY_TYPE.csv		\
	    L_R_ACTION_FIELDS.csv L_R_BARGAIN_UNIT_CODE.csv		\
	    L_R_BARGAIN_UNIT_SCOPE.csv L_R_BLOCK_DETERMINATION.csv	\
	    L_R_BOARD_ACTION_CODE.csv L_R_BOARD_ACTION_SRC_REASON.csv	\
	    L_R_BOARD_RECEIVED_REASON.csv L_R_CASE_ELECT_TYPE.csv	\
	    L_R_CASE_GROUP_TYPE.csv L_R_CASE_TYPE.csv			\
	    L_R_CHALLENGE_ACT_RESULT.csv L_R_CHALLENGE_ACT_TYPE.csv	\
	    L_R_CHALLENGE_ISSUE.csv L_R_CLOSING_METHOD.csv		\
	    L_R_CLOSING_STAGE.csv L_R_ELECT_AGREE_TYPE.csv		\
	    L_R_ELECT_MODE.csv L_R_OBJECTION_ISSUE.csv			\
	    L_R_OBJ_ACT_RESULT.csv L_R_OBJ_ACT_TYPE.csv			\
	    L_R_PART_ROLE_TYPE.csv L_R_POSTELEC_DET_EOT.csv		\
	    L_R_POSTELEC_DET_P_P.csv L_R_POSTELEC_HO_DIRECTED.csv	\
	    L_R_PREELEC_DET_EOT.csv L_R_PREELEC_HEAR_DET_P_P.csv	\
	    L_R_PREELEC_RD_DEC_TYPE.csv L_R_PREELEC_RD_ISSUE_DEC.csv	\
	    L_R_PREELEC_RD_RECON.csv L_R_RD_ACTION_DET.csv		\
	    L_R_RD_ACTION_TYPE.csv L_R_REASON_TRANSFER.csv		\
	    L_R_REOPEN_REASON.csv L_R_STATUS.csv L_R_TALLY_TYPE.csv	\
	    L_R_TARGETS.csv L_R_TARGET_DESCRIPTION.csv			\
	    L_R_TRANSFER_TYPE.csv L_STATE.csv
	for csv in $(basename $^); do \
	    csvs-to-sqlite -t $$(echo $$csv | tr [:upper:] [:lower:]) $$csv.csv $@; \
	done
	sqlite3 $@ < scripts/schema.sql
	sqlite3 $@ < scripts/transform.sql
	echo 'create index idx_nlrb_case_case_type on nlrb_case (case_type)' | sqlite3 $@
	sqlite-utils transform $@ l_blue_book_division --pk bb_division
	sqlite-utils transform $@ l_blue_book_chapter --pk bb_chapter
	sqlite-utils add-foreign-key $@ l_blue_book_chapter bb_division l_blue_book_division bb_division
	sqlite-utils transform $@ l_blue_book_heading --pk bb_heading --pk bb_chapter --pk bb_division
	sqlite-utils add-foreign-keys $@ l_blue_book_heading bb_division l_blue_book_division bb_division l_blue_book_heading bb_chapter l_blue_book_chapter bb_chapter
	sqlite-utils transform $@ l_blue_book_section --pk bb_section --pk bb_heading --pk bb_chapter --pk bb_division
	sqlite-utils add-foreign-keys $@ l_blue_book_section bb_division l_blue_book_division bb_division l_blue_book_section bb_chapter l_blue_book_chapter bb_chapter
	sqlite-utils transform $@ l_blue_book_codes --pk blue_book_code
	sqlite-utils add-foreign-keys $@ l_blue_book_codes bb_division l_blue_book_division bb_division l_blue_book_codes bb_chapter l_blue_book_chapter bb_chapter
	sqlite-utils add-foreign-key $@ pre_elect_rd_bb blue_book_code l_blue_book_codes blue_book_code
	sqlite-utils transform $@ l_case_party --pk party
	sqlite-utils add-foreign-keys $@ post_elect_rd_act brief_party l_case_party party post_elect_rd_act eot_party l_case_party party pre_elect_hearing p_p_party l_case_party party pre_elect_rd_decision brief_rcvd_party l_case_party party pre_elect_rd_decision eot_party l_case_party party pre_elect_rd_decision recon_request_party l_case_party party block reqproc_board_party l_case_party party block_cases req_proceed_party l_case_party party challenge_issue challenge_party l_case_party party objection_issue objection_party l_case_party party post_elect_hearing p_p_party l_case_party party
	sqlite-utils transform $@ l_county --pk county_code --pk state
	sqlite-utils transform $@ l_state --pk state
	sqlite-utils transform $@ l_geographic_division --pk geographic_division
	sqlite-utils transform $@ l_geographic_region --pk geographic_region
	sqlite-utils add-foreign-keys $@ l_county state l_state state elect_scheduled election_state l_state state election election_state l_state state l_nlrb_office state l_state state participant state l_state state post_elect_hearing hearing_state l_state state pre_elect_hearing hearing_state l_state state
	sqlite-utils add-foreign-keys $@ l_state geographic_division l_geographic_division geographic_division l_state geographic_region l_geographic_region geographic_region
	sqlite-utils transform $@ l_labor_org_code --pk labor_org_code
	sqlite-utils add-foreign-key $@ participant labor_org_code l_labor_org_code labor_org_code
	sqlite-utils transform $@ l_naics_sector --pk naics_sector
	sqlite-utils transform $@ l_naics_subsector --pk naics_subsector --pk naics_sector
	sqlite-utils add-foreign-key $@ l_naics_subsector naics_sector l_naics_sector naics_sector
	sqlite-utils transform $@ l_naics_industry_group --pk naics_industry_group --pk naics_subsector --pk naics_sector
	sqlite-utils transform $@ l_naics_industry --pk naics_industry_code --pk naics_industry_group --pk naics_subsector --pk naics_sector
	sqlite-utils transform $@ l_naics_industry --pk naics_industry_code --pk naics_industry_group --pk naics_subsector --pk naics_sector
	sqlite-utils transform $@ l_naics_us_industry --pk naics_us_industry_code --pk naics_industry_code --pk naics_industry_group --pk naics_subsector --pk naics_sector
	sqlite-utils transform $@ l_naics_code --pk naics_code
	sqlite-utils add-foreign-key $@ nlrb_case naics_code l_naics_code naics_code
	sqlite-utils transform $@ l_nlrb_branch --pk branch
	sqlite-utils transform $@ l_nlrb_district --pk district
	sqlite-utils transform $@ l_nlrb_division --pk division
	sqlite-utils transform $@ l_nlrb_region --pk region
	sqlite-utils transform $@ l_nlrb_office_type --pk office_type
	sqlite-utils transform $@ l_nlrb_office --pk nlrb_office_id
	sqlite-utils add-foreign-keys $@ l_nlrb_office region l_nlrb_region region l_nlrb_office branch l_nlrb_branch branch l_nlrb_office division l_nlrb_division division l_nlrb_office district l_nlrb_district district l_nlrb_office office_type l_nlrb_office_type office_type
	sqlite-utils convert $@ nlrb_case nlrb_office_id '"{:0>2}".format(value)'
	sqlite-utils add-foreign-key $@ nlrb_case nlrb_office_id l_nlrb_office nlrb_office_id
	sqlite-utils add-foreign-key $@ transfer_history former_case_number nlrb_case r_case_number
	sqlite-utils transform $@ l_organization --pk organization_id
	sqlite-utils add-foreign-key $@ l_organization_name organization_id l_organization organization_id
	sqlite-utils transform $@ l_parti_type --pk parti_type
	sqlite-utils transform $@ l_participant_group --pk participant_group
	sqlite-utils transform $@ l_party_scope --pk party_scope
	sqlite-utils add-foreign-keys $@ participant parti_type l_parti_type parti_type participant participant_group l_participant_group participant_group participant party_scope l_party_scope party_scope
	sqlite-utils transform $@ l_party_type --pk party_type
	sqlite-utils add-foreign-key $@ l_case_party party_type l_party_type party_type
	sqlite-utils transform $@ l_r_bargain_unit_code --pk bargaining_unit_code
	sqlite-utils transform $@ l_r_bargain_unit_scope --pk bargaining_unit_scope
	sqlite-utils add-foreign-keys $@ bargaining_unit bargaining_unit_code l_r_bargain_unit_code bargaining_unit_code bargaining_unit bargaining_unit_scope l_r_bargain_unit_scope bargaining_unit_scope
	sqlite-utils transform $@ l_r_block_determination --pk block_determination
	sqlite-utils add-foreign-key $@ block reqproc_board_deter l_r_block_determination block_determination
	sqlite-utils transform $@ l_r_board_received_reason --pk received_reason
	sqlite-utils transform $@ l_r_board_action_src_reason --pk action_source --pk received_reason
	sqlite-utils add-foreign-key $@ l_r_board_action_src_reason received_reason l_r_board_received_reason received_reason
	sqlite-utils transform $@ l_r_board_action_code --pk action_code
	sqlite-utils add-foreign-keys $@ post_elect_board_act board_action_code l_r_board_action_code action_code pre_elect_board_act board_action_code l_r_board_action_code action_code post_elect_board_act ruling_action_code l_r_board_action_code action_code pre_elect_board_act ruling_action_code l_r_board_action_code action_code post_elect_board_act received_reason l_r_board_received_reason received_reason pre_elect_board_act received_reason l_r_board_received_reason received_reason
	sqlite-utils transform $@ l_r_case_elect_type --pk election_type
	sqlite-utils add-foreign-keys $@ elect_scheduled election_type l_r_case_elect_type election_type election election_type l_r_case_elect_type election_type
	sqlite-utils transform $@ l_r_case_group_type --pk case_group_type
	sqlite-utils add-foreign-key $@ case_group case_group_type l_r_case_group_type case_group_type
	sqlite-utils transform $@ l_r_case_type --pk case_type
	sqlite-utils add-foreign-key $@ nlrb_case case_type l_r_case_type case_type
	sqlite-utils transform $@ l_r_challenge_act_type --pk challenge_action
	sqlite-utils transform $@ l_r_challenge_act_result --pk challenge_result
	sqlite-utils add-foreign-key $@ l_r_challenge_act_result challenge_action l_r_challenge_act_type challenge_action
	sqlite-utils transform $@ l_r_challenge_issue --pk challenge_issue
	sqlite-utils add-foreign-keys $@ challenge_issue challenge_issue l_r_challenge_issue challenge_issue challenge_issue challenge_action l_r_challenge_act_type challenge_action challenge_issue challenge_result l_r_challenge_act_result challenge_result
	sqlite-utils transform $@ l_r_closing_method --pk closing_method
	sqlite-utils transform $@ l_r_closing_stage --pk closing_stage
	sqlite-utils add-foreign-keys $@ closed_case closing_stage l_r_closing_stage closing_stage closed_case closing_method l_r_closing_method closing_method
	sqlite-utils transform $@ l_r_elect_agree_type --pk election_agreement_type
	sqlite-utils add-foreign-key $@ elect_agreement election_agreement_type l_r_elect_agree_type election_agreement_type
	sqlite-utils transform $@ l_r_elect_mode --pk election_mode
	sqlite-utils add-foreign-keys $@ elect_scheduled election_mode l_r_elect_mode election_mode election election_mode l_r_elect_mode election_mode
	sqlite-utils transform $@ l_r_obj_act_type --pk objection_action
	sqlite-utils transform $@ l_r_obj_act_result --pk objection_result
	sqlite-utils add-foreign-key $@ l_r_obj_act_result objection_action l_r_obj_act_type objection_action
	sqlite-utils transform $@ l_r_objection_issue --pk objection_issue
	sqlite-utils add-foreign-keys $@ objection_issue objection_issue l_r_objection_issue objection_issue objection_issue objection_action l_r_obj_act_type objection_action objection_issue objection_result l_r_obj_act_result objection_result
	sqlite-utils transform $@ l_r_part_role_type --pk participant_role
	sqlite-utils add-foreign-key $@ participant participant_role l_r_part_role_type participant_role
	sqlite-utils transform $@ l_r_postelec_det_eot --pk post_elect_determ_eot
	sqlite-utils transform $@ l_r_postelec_ho_directed --pk ho_report_directed
	sqlite-utils transform $@ l_r_rd_action_type --pk rd_action_type
	sqlite-utils transform $@ l_r_rd_action_det --pk rd_action_determination
	sqlite-utils add-foreign-key $@ l_r_rd_action_det rd_action_type l_r_rd_action_type rd_action_type
	sqlite-utils add-foreign-keys $@ post_elect_rd_act eot_determination l_r_postelec_det_eot post_elect_determ_eot post_elect_rd_act ho_report_directed l_r_postelec_ho_directed ho_report_directed post_elect_rd_act rd_action_type l_r_rd_action_type rd_action_type post_elect_rd_act rd_action_determination l_r_rd_action_det rd_action_determination
	sqlite-utils transform $@ l_r_preelec_det_eot --pk determination_eot
	sqlite-utils transform $@ l_r_preelec_rd_dec_type --pk rd_decision_type
	sqlite-utils transform $@ l_r_preelec_rd_recon --pk rd_reconsider
	sqlite-utils add-foreign-keys $@ pre_elect_rd_decision determination_eot l_r_preelec_det_eot determination_eot pre_elect_rd_decision rd_decision_type l_r_preelec_rd_dec_type rd_decision_type pre_elect_rd_decision rd_recon_deter l_r_preelec_rd_recon rd_reconsider
	sqlite-utils transform $@ l_r_preelec_rd_issue_dec --pk issue_code
	sqlite-utils add-foreign-key $@ pre_elect_rd_issues issue_code l_r_preelec_rd_issue_dec issue_code
	sqlite-utils transform $@ l_r_reason_transfer --pk reason_transfer
	sqlite-utils transform $@ l_r_transfer_type --pk transfer_type
	sqlite-utils add-foreign-keys $@ transfer_history reason_transfer l_r_reason_transfer reason_transfer transfer_history transfer_type l_r_transfer_type transfer_type
	sqlite-utils transform $@ l_r_reopen_reason --pk reopen_reason
	sqlite-utils add-foreign-key $@ reopened_case reopen_reason l_r_reopen_reason reopen_reason
	sqlite-utils transform $@ l_r_status --pk status
	sqlite-utils add-foreign-key $@ nlrb_case status l_r_status status
	sqlite-utils transform $@ l_r_tally_type --pk tally_type
	sqlite-utils add-foreign-key $@ election_tally tally_type l_r_tally_type tally_type
	sqlite-utils transform $@ l_r_targets --pk target
	sqlite-utils add-foreign-key $@ l_r_target_description target l_r_targets target
	sqlite-utils transform $@ l_r_postelec_det_p_p --pk post_elect_determ_p_p
	sqlite-utils add-foreign-key $@ post_elect_hearing p_p_determination l_r_postelec_det_p_p post_elect_determ_p_p
	sqlite-utils transform $@ l_r_preelec_hear_det_p_p --pk determination_request_p_p
	sqlite-utils add-foreign-key $@ pre_elect_hearing p_p_determination l_r_preelec_hear_det_p_p determination_request_p_p
	sqlite-utils transform $@ l_r_action_fields --pk action_table_code --pk action_field_code

L_R_ACTION_FIELDS.csv : L_R_ACTION_FIELDS.csv.badheaders
	cat $< | awk 'NR==1{$$0=tolower($$0)}1' | sed '1 s/table_name/tbl_name/' > $@

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
