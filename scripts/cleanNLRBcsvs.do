********************************************************************************
*
* cleanNLRBcsvs.do
* This file is meant to be run after clean_R.sh. Each block reads in one of the
* files representing a table in the CATS database, does some minimal cleaning
* such as de-stringing numeric variables, putting dates in Stata's date format,
* and encoding categorical variables, then compresses and saves out a Stata
* dataset. 
* 
* Further cleaning, such as encoding states and industries, or geocoding, are
* left as exercises for the user. Also, I do not have codebooks for each field
* in each table. For such details, I recommend contacting the NLRB directly, or
* consulting a book like McGuinnes & Norris's 1986 tome, "How to Take a Case
* Before the NLRB."
*
* Please note that this file calls several ADO files that I wrote to simplify
* the code: mdestring.ado, nlrbdate.ado, rencode.ado and swapout.ado. These need
* to be somewhere on Stata's ado-path.
*
********************************************************************************

clear
insheet using R_ACTION.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence action_control
nlrbdate action_date date_entered
rencode unit_id
rencode action_table_code
rencode action_field_code
compress
save R_ACTION.dta, replace

clear
insheet using R_BARGAINING_UNIT.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring nlrb_office_id docket_num naics_code num_employees_requested
nlrbdate date_filed hearing_target_date election_target_date
rencode case_type
rencode status
rencode self_certification, label(yesno) noextend
rencode post_elect_self_cert, label(yesno) noextend
compress
save R_BARGAINING_UNIT.dta, replace

clear
insheet using R_BLOCK.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence
nlrbdate blocked unblocked reqproc_board_filed_date reqproc_board_deter_date
rencode unit_id, label(unit_id) noextend
rencode reqproc_board_party
rencode reqproc_board_deter
compress
save R_BLOCK.dta, replace

clear
insheet using R_BLOCK_CASES.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence sequence recurrence 
nlrbdate req_proceed_filed req_proceed_withdrawn
rencode unit_id, label(unit_id) noextend
rencode req_proceed_party, label(party) noextend
compress
save R_BLOCK_CASES.dta, replace

clear
insheet using R_CASE.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring nlrb_office_id docket_num naics_code num_employees_requested
nlrbdate date_filed hearing_target_date election_target_date
rencode case_type, label(type_case) noextend
rencode status, label(status) noextend
rencode self_certification, label(yesno) noextend
rencode post_elect_self_cert, label(yesno) noextend
compress
save R_CASE.dta, replace

clear
insheet using R_CASE_CASE_GROUP.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring sequence
nlrbdate date_case_added date_case_removed
rencode lead, label(yesno) noextend
compress
save R_CASE_CASE_GROUP.dta, replace

clear
insheet using R_CASE_GROUP.csv, c n
drop if r_case_group_id == "R_Case_Group_ID"
quietly do nlrbLabels.do
nlrbdate date_created date_dissolved
rencode case_group_type, label(type_case_group) noextend
compress
save R_CASE_GROUP.dta, replace

clear
insheet using R_CHALLENGE_ISSUE.csv, c n
drop if election_id == "Election_ID"
quietly do nlrbLabels.do
mdestring sequence challenge_issue number challenge_action challenge_result
rencode challenge_party, label(party) noextend
compress
save R_CHALLENGE_ISSUE.dta, replace

clear 
insheet using R_CHALLENGE_TABULATION.csv, c n
drop if election_id == "Election_ID"
quietly do nlrbLabels.do
mdestring challenge_action sequence number_eligible number_ineligible ///
	number_withdrawn number_unresolved
compress
save R_CHALLENGE_TABULATION.dta, replace

clear
insheet using R_CLOSED_CASE.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence
nlrbdate closing_date date_file_archives date_file_to_records date_file_destroyed
rencode closing_stage, label(closing_stage) noextend
rencode closing_method, label(closing_method) noextend
compress
save R_CLOSED_CASE.dta, replace

clear
insheet using R_DISMISSAL.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence
nlrbdate date_letter_issued
rencode unit_id, label(unit_id) noextend
compress
save R_DISMISSAL.dta, replace

clear
insheet using R_ELECTION.csv, c n
drop if election_id == "Election_ID"
quietly do nlrbLabels.do
nlrbdate date_election
rencode election_type, label(type_election) noextend
rencode election_mode, label(election_mode) noextend
rencode expedited_under_8b7, label(yesno) noextend
rencode globe_sonotone_election, label(yesno) noextend
rencode ballots_impounded, label(yesno) noextend
compress
save R_ELECTION.dta, replace

clear
insheet using R_ELECTION_TALLY.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring tally_id num_employees_eligible num_void_ballots num_votes_against ///
	num_valid_votes num_challenges num_for_inclusion num_against_inclusion ///
	num_sustained_challenges
nlrbdate tally_date
rencode unit_id, label(unit_id) noextend
rencode tally_type, label(type_tally) noextend
rencode self_determination_tally, label(yesno) noextend
rencode challenges_determinative, label(yesno) noextend
rencode runoff_required, label(yesno) noextend
compress
save R_ELECTION_TALLY.dta, replace

clear
insheet using R_ELECT_AGREEMENT.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence
nlrbdate date_approved
rencode unit_id, label(unit_id) noextend
rencode election_agreement_type, label(type_elect_agree) noextend
compress
save R_ELECT_AGREEMENT.dta, replace

clear
insheet using R_ELECT_CERTIFICATION.csv, c n
drop if election_id == "Election_ID"
quietly do nlrbLabels.do
nlrbdate cert_of_representative cert_of_results
compress
save R_ELECT_CERTIFICATION.dta, replace

clear
insheet using R_ELECT_SCHEDULED.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence
nlrbdate schedule_date scheduled_tally_date date_excelsior_list_due ///
	date_excelsior_list_received date_excelsior_list_sent date_eligible
rencode unit_id, label(unit_id) noextend
rencode election_mode, label(election_mode) noextend
rencode election_type, label(type_election) noextend
rencode self_deter_election, label(yesno) noextend
rencode expedited_under_8b7, label(yesno) noextend
rencode election_cancelled, label(yesno) noextend
compress
save R_ELECT_SCHEDULED.dta, replace

clear
insheet using R_ELECT_VOTES_FOR.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring tally_id sort_order votes_for
rencode unit_id, label(unit_id) noextend
compress
save R_ELECT_VOTES_FOR.dta, replace

clear
insheet using R_IMPACT_CATEGORY.csv, c n
drop if r_case_number == "R_Case_Number"
mdestring history_sequence preelection postelection
compress
save R_IMPACT_CATEGORY.dta, replace

clear
insheet using R_OBJECTION_ISSUE.csv, c n
drop if election_id == "Election_ID"
quietly do nlrbLabels.do
mdestring sequence objection_action objection_result
nlrbdate objection_issue_date
rencode objection_party, label(party) noextend
compress
save R_OBJECTION_ISSUE.dta, replace

clear
insheet using R_PARTICIPANT.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring participant_id
replace participant_role = "AddS1" if participant_role == "Adds1"
rencode participant_role, label(part_role) noextend
rencode participant_group, label(part_group) noextend
rencode exclusive_service, label(yesno) noextend
rencode incumbent_union, label(yesno) noextend
rencode afl_cio, label(yesno) noextend
rencode party_scope, label(party_scope) noextend
rencode parti_type, label(type_participant) noextend
compress
save R_PARTICIPANT.dta, replace

clear
insheet using R_PART_VARIANT.csv, c n
drop if r_case_number == "R_Case_Number"
mdestring participant_id
compress
save R_PART_VARIANT.dta, replace

clear
insheet using R_POST_ELECT_BOARD_ACT.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring ruling_action_code board_action_code
nlrbdate received_date exception_withdrawn_date board_decision_date
rencode received_reason, label(reason_received) noextend
compress
save R_POST_ELECT_BOARD_ACT.dta, replace

clear
insheet using R_POST_ELECT_HEARING.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence hearing_days length_of_transcript
nlrbdate noh_issued hearing_scheduled p_p_request_date p_p_order_issued ///
	hearing_opened hearing_closed date_reschedule_issued
rencode unit_id, label(unit_id) noextend
rencode p_p_determination, label(determination) noextend
rencode p_p_party, label(party) noextend
compress
save R_POST_ELECT_HEARING.dta, replace

clear
insheet using R_POST_ELECT_RD_ACT.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence rd_action_type rd_action_determination
nlrbdate brief_due brief_filed eot_request_date eot_determination_date ///
	action_date review_due_date date_ho_report exceptions_due_date
rencode unit_id, label(unit_id) noextend
rencode brief_party, label(party) noextend
rencode eot_party, label(party) noextend
rencode eot_determination, label(determination) noextend
rencode ho_report_directed, label(ho_report) noextend
compress
save R_POST_ELECT_RD_ACT.dta, replace

clear
insheet using R_PRE_ELECT_BOARD_ACT.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence ruling_action_code board_action_code
nlrbdate received_date ruling_decision_date exception_withdrawn_date ///
	board_decision_date
rencode received_reason, label(reason_received) noextend
compress
save R_PRE_ELECT_BOARD_ACT.dta, replace

clear
insheet using R_PRE_ELECT_HEARING.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence length_of_transcript hearing_days_on_record
nlrbdate date_notice_issued date_hearing_scheduled date_rescheduled_issued ///
	p_p_rcvd_region p_p_response_date hearing_opened hearing_closed ///
	hearing_off_rep_date
rencode unit_id, label(unit_id) noextend
rencode p_p_party, label(party) noextend
rencode p_p_determination, label(determination) noextend
compress
save R_PRE_ELECT_HEARING.dta, replace

clear
insheet using R_PRE_ELECT_RD_BB.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence
rencode unit_id, label(unit_id) noextend
compress
save R_PRE_ELECT_RD_BB.dta, replace

clear
insheet using R_PRE_ELECT_RD_DECISION.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence
nlrbdate eot_filed_date eot_deter_brief_date pre_election_brief_rcvd ///
	rd_decision_issued_date recon_request_filed rd_recon_deter_date ///
	brief_due_date review_due_date
rencode unit_id, label(unit_id) noextend
rencode determination_eot, label(determination) noextend
rencode eot_party, label(party) noextend
rencode brief_rcvd_party, label(party) noextend
rencode rd_decision_type, label(type_rd_decision) noextend
rencode recon_request_party, label(party) noextend
rencode rd_recon_deter, label(determination) noextend
compress
save R_PRE_ELECT_RD_DECISION.dta, replace

clear
insheet using R_PRE_ELECT_RD_ISSUES.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence recurrence
rencode unit_id, label(unit_id) noextend
compress
save R_PRE_ELECT_RD_ISSUES.dta, replace

clear
insheet using R_REOPENED_CASE.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence
nlrbdate date_reopened
rencode reopen_reason, label(reason_reopen) noextend
compress
save R_REOPENED_CASE.dta, replace

clear
insheet using R_TRANSFER_HISTORY.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring sequence
nlrbdate history_date date_data_received request_date transfer_order_date ///
	sent_date received_date
rencode reason_transfer, label(reason_transfer) noextend
rencode transfer_type, label(type_transfer) noextend
compress
save R_TRANSFER_HISTORY.dta, replace

clear
insheet using R_WITHDRAWAL.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
mdestring action_sequence
nlrbdate withdrawal_approved_date
rencode unit_id, label(unit_id) noextend
rencode with_prejudice_flag, label(yesno) noextend
compress
save R_WITHDRAWAL.dta, replace

clear
insheet using CATS-FRF-R.csv, c n
drop if r_case_number == "R_Case_Number"
quietly do nlrbLabels.do
replace election_results = "LOSS" if election_results == "LOST"
split closing_method
replace closing_method = closing_method1
drop closing_method1-closing_method4
split naics_code
replace naics_code = naics_code1
drop naics_code1-naics_code14
mdestring naics_code num_elig_employees num_valid_votes num_votes_for ///
	num_votes_against
nlrbdate tally_ballot_date date_election date_filed date_closed
rencode status, label(status) noextend
rencode election_results, label(winloss) noextend
rencode closing_method, label(closing_method) noextend
rencode unit_id, label(unit_id) noextend
rencode bargaining_unit_code, label(barg_unit_code) noextend
rencode tally_type, label(type_tally) noextend
rencode multiunion, label(yesno) noextend
compress
save CATS-R-FRF.dta, replace

