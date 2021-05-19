CREATE TABLE IF NOT EXISTS "nlrb_case" (
  "r_case_number" TEXT NOT NULL PRIMARY KEY,
  "case_type" TEXT,
  "status" TEXT,
  "nlrb_office_id" INTEGER,
  "docket_num" INTEGER,
  "inquiry_id" TEXT,
  "case_name" TEXT,
  "date_filed" TEXT,
  "hearing_target_date" TEXT,
  "election_target_date" TEXT,
  "employer_on_petition" TEXT,
  "union_involved_on_petition" TEXT,
  "intervenor_on_petition" TEXT,
  "self_certification" INTEGER,
  "post_elect_self_cert" INTEGER,
  "naics_code" INTEGER,
  "num_employees_requested" INTEGER,
  "description_requested" TEXT
);
CREATE TABLE IF NOT EXISTS "action" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "recurrence" INTEGER,
  "action_table_code" TEXT,
  "action_field_code" TEXT,
  "action_date" TEXT,
  "date_entered" TEXT,
  "action_control" INTEGER,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
);
CREATE TABLE IF NOT EXISTS "bargaining_unit" (
"r_case_number" TEXT,
  "case_type" TEXT,
  "status" TEXT,
  "nlrb_office_id" INTEGER,
  "docket_num" INTEGER,
  "inquiry_id" TEXT,
  "case_name" TEXT,
  "date_filed" TEXT,
  "hearing_target_date" TEXT,
  "election_target_date" TEXT,
  "employer_on_petition" TEXT,
  "petitioner_on_petition" TEXT,
  "union_involved_on_petition" TEXT,
  "intervenor_on_petition" TEXT,
  "self_certification" TEXT,
  "post_elect_self_cert" TEXT,
  "naics_code" INTEGER,
  "num_employees_requested" INTEGER,
  "description_requested" TEXT
);
CREATE TABLE IF NOT EXISTS "block" (
  "r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "recurrence" INTEGER,
  "blocked" TEXT,
  "unblocked" TEXT,
  "reqproc_board_filed_date" TEXT,
  "reqproc_board_party" TEXT,
  "reqproc_board_deter_date" TEXT,
  "reqproc_board_deter" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)    
);
CREATE TABLE IF NOT EXISTS "block_cases" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "sequence" INTEGER,
  "recurrence" INTEGER,
  "c_case_number" TEXT,
  "req_proceed_filed" TEXT,
  "req_proceed_party" TEXT,
  "req_proceed_withdrawn" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)    
);
CREATE TABLE IF NOT EXISTS "case_group" (
"r_case_group_id" TEXT  NOT NULL PRIMARY KEY,
  "case_group_type" TEXT,
  "date_created" TEXT,
  "date_dissolved" TEXT
);
CREATE TABLE IF NOT EXISTS "case_case_group" (
  "r_case_group_id" TEXT,
  "r_case_number" TEXT,
  "sequence" INTEGER,
  "date_case_added" TEXT,
  "lead" TEXT,
  "date_case_removed" TEXT,
  PRIMARY KEY (r_case_group_id, r_case_number, sequence),
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number),    
  FOREIGN KEY (r_case_group_id) REFERENCES case_group(r_case_group_id)  
  
);
CREATE TABLE IF NOT EXISTS "challenge_issue" (
"election_id" TEXT,
  "sequence" INTEGER,
  "challenge_party" TEXT,
  "challenge_issue" INTEGER,
  "number" INTEGER,
  "challenge_action" INTEGER,
  "challenge_result" INTEGER,
  PRIMARY KEY (election_id, sequence),  
  FOREIGN KEY (election_id) REFERENCES election(election_id)    
);
CREATE TABLE IF NOT EXISTS "challenge_tabulation" (
"election_id" TEXT,
  "challenge_action" INTEGER,
  "sequence" INTEGER,
  "number_eligible" INTEGER,
  "number_ineligible" INTEGER,
  "number_withdrawn" INTEGER,
  "number_unresolved" INTEGER,
  FOREIGN KEY (election_id, sequence) REFERENCES challenge_issue(election_id, sequence)  
  
);
CREATE TABLE IF NOT EXISTS "closed_case" (
"r_case_number" TEXT,
  "action_sequence" INTEGER,
  "closing_date" TEXT,
  "closing_stage" TEXT,
  "closing_method" TEXT,
  "date_file_archives" TEXT,
  "date_file_to_records" TEXT,
  "date_file_destroyed" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
);
CREATE TABLE IF NOT EXISTS "dismissal" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "date_letter_issued" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
);
CREATE TABLE IF NOT EXISTS "election" (
"election_id" TEXT NOT NULL PRIMARY KEY,
  "date_election" TEXT,
  "election_type" TEXT,
  "election_mode" TEXT,
  "election_time" TEXT,
  "election_city" TEXT,
  "election_state" TEXT,
  "expedited_under_8b7" TEXT,
  "globe_sonotone_election" TEXT,
  "ballots_impounded" TEXT
);
CREATE TABLE IF NOT EXISTS "election_tally" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "election_id" TEXT,
  "tally_id" INTEGER,
  "tally_date" TEXT,
  "tally_type" TEXT,
  "self_determination_tally" TEXT,
  "num_employees_eligible" INTEGER,
  "num_void_ballots" INTEGER,
  "num_votes_against" INTEGER,
  "num_valid_votes" INTEGER,
  "num_challenges" INTEGER,
  "challenges_determinative" TEXT,
  "runoff_required" TEXT,
  "majority_for" TEXT,
  "num_for_inclusion" INTEGER,
  "num_against_inclusion" INTEGER,
  "num_sustained_challenges" INTEGER,
  PRIMARY KEY (unit_id, election_id, tally_id),
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number),
  FOREIGN KEY (election_id) REFERENCES election(election_id)  
);
CREATE TABLE IF NOT EXISTS "elect_agreement" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "date_approved" TEXT,
  "election_agreement_type" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
);
CREATE TABLE IF NOT EXISTS "elect_certification" (
"election_id" TEXT,
  "cert_of_representative" TEXT,
  "cert_of_results" TEXT,
  "certified_bargaining_agent" TEXT,
  PRIMARY KEY (election_id),
  FOREIGN KEY (election_id) REFERENCES election(election_id)    
);
CREATE TABLE IF NOT EXISTS "elect_scheduled" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "election_mode" TEXT,
  "election_type" TEXT,
  "election_state" TEXT,
  "election_time" TEXT,
  "election_city" TEXT,
  "schedule_date" TEXT,
  "self_deter_election" TEXT,
  "expedited_under_8b7" TEXT,
  "scheduled_tally_date" TEXT,
  "election_cancelled" TEXT,
  "date_excelsior_list_due" TEXT,
  "date_excelsior_list_received" TEXT,
  "date_excelsior_list_sent" TEXT,
  "date_eligible" TEXT,
  "election_place" TEXT,
  "additional_languages" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
);
CREATE TABLE IF NOT EXISTS "elect_votes_for" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "election_id" TEXT,
  "tally_id" INTEGER,
  "sort_order" INTEGER,
  "labor_organization" TEXT,
  "votes_for" INTEGER,
  PRIMARY KEY (unit_id, election_id, tally_id, sort_order),
  FOREIGN KEY (unit_id, election_id, tally_id) REFERENCES election_tally(unit_id, election_id, tally_id)    
);
CREATE TABLE IF NOT EXISTS "impact_category" (
"r_case_number" TEXT,
  "history_sequence" INTEGER,
  "preelection" INTEGER,
  "postelection" INTEGER,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)    
);
CREATE TABLE IF NOT EXISTS "objection_issue" (
"election_id" TEXT,
  "sequence" INTEGER,
  "objection_issue_date" TEXT,
  "objection_party" TEXT,
  "objection_issue" TEXT,
  "objection_action" INTEGER,
  "objection_result" INTEGER,
  PRIMARY KEY (election_id, sequence),
  FOREIGN KEY (election_id) REFERENCES election(election_id)    
);
CREATE TABLE IF NOT EXISTS "participant" (
"r_case_number" TEXT NOT NULL,
  "participant_id" INTEGER NOT NULL,
  "participant_role" TEXT,
  "participant_group" TEXT,
  "name_for_correspondence" TEXT,
  "name_prefix" TEXT,
  "first_name" TEXT,
  "mid_name" TEXT,
  "last_name" TEXT,
  "name_suffix" TEXT,
  "street_address_1" TEXT,
  "street_address_2" TEXT,
  "city" TEXT,
  "state" TEXT,
  "zip" TEXT,
  "phone_num" TEXT,
  "phone_ext" TEXT,
  "cell_phone" TEXT,
  "fax_num" TEXT,
  "e_mail_address" TEXT,
  "formal_name" TEXT,
  "parent_name" TEXT,
  "exclusive_service" TEXT,
  "incumbent_union" TEXT,
  "labor_org_code" INTEGER,
  "local_dist_id" TEXT,
  "afl_cio" TEXT,
  "party_scope" TEXT,
  "parti_type" TEXT,
  PRIMARY KEY (r_case_number, participant_id),
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
);
CREATE TABLE IF NOT EXISTS "post_elect_board_act" (
"r_case_number" TEXT,
  "received_date" TEXT,
  "received_reason" TEXT,
  "ruling_action_code" INTEGER,
  "exception_withdrawn_date" TEXT,
  "board_decision_date" TEXT,
  "board_action_code" INTEGER,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
);
CREATE TABLE IF NOT EXISTS "post_elect_hearing" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "election_id" TEXT,
  "action_sequence" INTEGER,
  "recurrence" INTEGER,
  "noh_issued" TEXT,
  "hearing_scheduled" TEXT,
  "p_p_request_date" TEXT,
  "p_p_party" TEXT,
  "p_p_determination" TEXT,
  "p_p_order_issued" TEXT,
  "hearing_opened" TEXT,
  "hearing_closed" TEXT,
  "hearing_days" INTEGER,
  "date_reschedule_issued" TEXT,
  "staff_id" TEXT,
  "length_of_transcript" INTEGER,
  "hearing_time" TEXT,
  "hearing_city" TEXT,
  "hearing_state" TEXT,
  "hearing_address" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number),
  FOREIGN KEY (election_id) REFERENCES election(election_id)  
);
CREATE TABLE IF NOT EXISTS "post_elect_rd_act" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "election_id" TEXT,
  "action_sequence" INTEGER,
  "recurrence" INTEGER,
  "brief_due" TEXT,
  "brief_filed" TEXT,
  "brief_party" TEXT,
  "eot_request_date" TEXT,
  "eot_party" TEXT,
  "eot_determination_date" TEXT,
  "eot_determination" TEXT,
  "action_date" TEXT,
  "rd_action_type" INTEGER,
  "rd_action_determination" INTEGER,
  "review_due_date" TEXT,
  "date_ho_report" TEXT,
  "ho_report_directed" TEXT,
  "exceptions_due_date" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number),
  FOREIGN KEY (election_id) REFERENCES election(election_id)    
);
CREATE TABLE IF NOT EXISTS "pre_elect_board_act" (
"r_case_number" TEXT,
  "action_sequence" INTEGER,
  "recurrence" INTEGER,
  "received_date" TEXT,
  "received_reason" TEXT,
  "ruling_decision_date" TEXT,
  "ruling_action_code" INTEGER,
  "exception_withdrawn_date" INTEGER,
  "board_decision_date" TEXT,
  "board_action_code" INTEGER,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)    
);
CREATE TABLE IF NOT EXISTS "pre_elect_hearing" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "recurrence" INTEGER,
  "date_notice_issued" TEXT,
  "date_hearing_scheduled" TEXT,
  "date_rescheduled_issued" TEXT,
  "length_of_transcript" INTEGER,
  "p_p_party" TEXT,
  "p_p_determination" TEXT,
  "p_p_rcvd_region" TEXT,
  "p_p_response_date" TEXT,
  "hearing_opened" TEXT,
  "hearing_closed" TEXT,
  "hearing_days_on_record" INTEGER,
  "hearing_off_rep_date" TEXT,
  "hearing_time" TEXT,
  "hearing_city" TEXT,
  "hearing_state" TEXT,
  "hearing_address" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
  
);
CREATE TABLE IF NOT EXISTS "pre_elect_rd_bb" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "blue_book_code" TEXT,
  "recurrence" INTEGER,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
  
);
CREATE TABLE IF NOT EXISTS "pre_elect_rd_decision" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "recurrence" INTEGER,
  "determination_eot" TEXT,
  "eot_party" TEXT,
  "eot_filed_date" TEXT,
  "eot_deter_brief_date" TEXT,
  "brief_rcvd_party" TEXT,
  "pre_election_brief_rcvd" TEXT,
  "rd_decision_issued_date" TEXT,
  "rd_decision_type" TEXT,
  "recon_request_filed" TEXT,
  "recon_request_party" TEXT,
  "rd_recon_deter" TEXT,
  "rd_recon_deter_date" TEXT,
  "brief_due_date" TEXT,
  "review_due_date" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
  
);
CREATE TABLE IF NOT EXISTS "pre_elect_rd_issues" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "recurrence" INTEGER,
  "issue_code" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)    
);
CREATE TABLE IF NOT EXISTS "reopened_case" (
"r_case_number" TEXT,
  "action_sequence" INTEGER,
  "date_reopened" TEXT,
  "reopen_reason" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
  
);
CREATE TABLE IF NOT EXISTS "transfer_history" (
"r_case_number" TEXT,
  "history_date" TEXT,
  "sequence" INTEGER,
  "date_data_received" TEXT,
  "request_date" TEXT,
  "reason_transfer" TEXT,
  "transfer_type" TEXT,
  "transfer_order_date" TEXT,
  "new_case_number" TEXT,
  "former_case_number" TEXT,
  "sent_date" TEXT,
  "received_date" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
  
);
CREATE TABLE IF NOT EXISTS "withdrawal" (
"r_case_number" TEXT,
  "unit_id" TEXT,
  "action_sequence" INTEGER,
  "withdrawal_approved_date" TEXT,
  "with_prejudice_flag" TEXT,
  FOREIGN KEY (r_case_number) REFERENCES nlrb_case(r_case_number)  
  
);
