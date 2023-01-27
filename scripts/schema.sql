CREATE TABLE IF NOT EXISTS "r_action" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "recurrence" integer,
    "action_table_code" text,
    "action_field_code" text,
    "action_date" text,
    "date_entered" text,
    "action_control" integer,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id)
);

CREATE TABLE IF NOT EXISTS "r_bargaining_unit" (
    "r_case_number" text,
    "unit_id" text,
    "bargaining_unit_code" text,
    "bargaining_unit_scope" text,
    "num_employees_determined" integer,
    "unit_city" text,
    "unit_state" text,
    "unit_county" integer,
    "description_determined" text,
    PRIMARY KEY (r_case_number, unit_id),
    FOREIGN KEY ([bargaining_unit_code]) REFERENCES[l_r_bargain_unit_code] ([bargaining_unit_code]),
    FOREIGN KEY ([bargaining_unit_scope]) REFERENCES[l_r_bargain_unit_scope] ([bargaining_unit_scope]),
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number)
);

CREATE TABLE IF NOT EXISTS "r_block" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "recurrence" integer,
    "blocked" text,
    "unblocked" text,
    "reqproc_board_filed_date" text,
    "reqproc_board_party" text,
    "reqproc_board_deter_date" text,
    "reqproc_board_deter" text,
    FOREIGN KEY ([reqproc_board_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([reqproc_board_deter]) REFERENCES[l_r_block_determination] ([block_determination]),
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id)
);

CREATE TABLE IF NOT EXISTS "r_block_cases" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "sequence" integer,
    "recurrence" integer,
    "c_case_number" text,
    "req_proceed_filed" text,
    "req_proceed_party" text,
    "req_proceed_withdrawn" text,
    FOREIGN KEY ([req_proceed_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id)
);

CREATE TABLE IF NOT EXISTS "r_case_case_group" (
    "r_case_group_id" text,
    "r_case_number" text,
    "sequence" integer,
    "date_case_added" text,
    "lead" text,
    "date_case_removed" text,
    FOREIGN KEY (r_case_group_id) REFERENCES r_case_group (r_case_group_id)
);

CREATE TABLE IF NOT EXISTS "r_case_group" (
    "r_case_group_id" text PRIMARY KEY,
    "case_group_type" text,
    "date_created" text,
    "date_dissolved" text,
    FOREIGN KEY ([case_group_type]) REFERENCES[l_r_case_group_type] ([case_group_type])
);

CREATE TABLE IF NOT EXISTS "r_challenge_issue" (
    "election_id" text,
    "sequence" integer,
    "challenge_party" text,
    "challenge_issue" integer,
    "number" integer,
    "challenge_action" integer,
    "challenge_result" integer,
    FOREIGN KEY (election_id) REFERENCES r_election (election_id),
    FOREIGN KEY ([challenge_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([challenge_issue]) REFERENCES[l_r_challenge_issue] ([challenge_issue]),
    FOREIGN KEY ([challenge_action]) REFERENCES[l_r_challenge_act_type] ([challenge_action]),
    FOREIGN KEY ([challenge_result]) REFERENCES[l_r_challenge_act_result] ([challenge_result])
);

CREATE TABLE IF NOT EXISTS "r_challenge_tabulation" (
    "election_id" text,
    "challenge_action" integer,
    "sequence" integer,
    "number_eligible" integer,
    "number_ineligible" integer,
    "number_withdrawn" integer,
    "number_unresolved" integer,
    FOREIGN KEY (election_id) REFERENCES r_election (election_id)
);

CREATE TABLE IF NOT EXISTS "r_closed_case" (
    "r_case_number" text,
    "action_sequence" integer,
    "closing_date" text,
    "closing_stage" text,
    "closing_method" text,
    "date_file_archives" text,
    "date_file_to_records" text,
    "date_file_destroyed" text,
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number),
    FOREIGN KEY ([closing_stage]) REFERENCES[l_r_closing_stage] ([closing_stage]),
    FOREIGN KEY ([closing_method]) REFERENCES[l_r_closing_method] ([closing_method])
);

CREATE TABLE IF NOT EXISTS "r_dismissal" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "date_letter_issued" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id)
);

CREATE TABLE IF NOT EXISTS "r_election" (
    "election_id" text PRIMARY KEY,
    "date_election" text,
    "election_type" text,
    "election_mode" text,
    "election_time" text,
    "election_city" text,
    "election_state" text,
    "expedited_under_8b7" text,
    "globe_sonotone_election" text,
    "ballots_impounded" text,
    FOREIGN KEY ([election_state]) REFERENCES[l_state] ([state]),
    FOREIGN KEY ([election_type]) REFERENCES[l_r_case_elect_type] ([election_type]),
    FOREIGN KEY ([election_mode]) REFERENCES[l_r_elect_mode] ([election_mode])
);

CREATE TABLE IF NOT EXISTS "r_election_tally" (
    "r_case_number" text,
    "unit_id" text,
    "election_id" text,
    "tally_id" integer,
    "tally_date" text,
    "tally_type" text,
    "self_determination_tally" text,
    "num_employees_eligible" integer,
    "num_void_ballots" integer,
    "num_votes_against" integer,
    "num_valid_votes" integer,
    "num_challenges" integer,
    "challenges_determinative" text,
    "runoff_required" text,
    "majority_for" text,
    "num_for_inclusion" integer,
    "num_against_inclusion" integer,
    "num_sustained_challenges" integer,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY (election_id) REFERENCES r_election (election_id),
    FOREIGN KEY ([tally_type]) REFERENCES[l_r_tally_type] ([tally_type])
);

CREATE TABLE IF NOT EXISTS "r_elect_agreement" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "date_approved" text,
    "election_agreement_type" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY ([election_agreement_type]) REFERENCES[l_r_elect_agree_type] ([election_agreement_type])
);

CREATE TABLE IF NOT EXISTS "r_elect_certification" (
    "election_id" text,
    "cert_of_representative" text,
    "cert_of_results" text,
    "certified_bargaining_agent" text,
    FOREIGN KEY (election_id) REFERENCES r_election (election_id)
);

CREATE TABLE IF NOT EXISTS "r_elect_scheduled" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "election_mode" text,
    "election_type" text,
    "election_state" text,
    "election_time" text,
    "election_city" text,
    "schedule_date" text,
    "self_deter_election" text,
    "expedited_under_8b7" text,
    "scheduled_tally_date" text,
    "election_cancelled" text,
    "date_excelsior_list_due" text,
    "date_excelsior_list_received" text,
    "date_excelsior_list_sent" text,
    "date_eligible" text,
    "election_place" text,
    "additional_languages" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY ([election_state]) REFERENCES[l_state] ([state]),
    FOREIGN KEY ([election_type]) REFERENCES[l_r_case_elect_type] ([election_type]),
    FOREIGN KEY ([election_mode]) REFERENCES[l_r_elect_mode] ([election_mode])
);

CREATE TABLE IF NOT EXISTS "r_elect_votes_for" (
    "r_case_number" text,
    "unit_id" text,
    "election_id" text,
    "tally_id" integer,
    "sort_order" integer,
    "labor_organization" text,
    "votes_for" integer,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY (election_id) REFERENCES r_election (election_id)
);

CREATE TABLE IF NOT EXISTS "r_impact_category" (
    "r_case_number" text,
    "history_sequence" integer,
    "preelection" integer,
    "postelection" integer,
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number)
);

CREATE TABLE IF NOT EXISTS "r_objection_issue" (
    "election_id" text,
    "sequence" integer,
    "objection_issue_date" text,
    "objection_party" text,
    "objection_issue" text,
    "objection_action" integer,
    "objection_result" integer,
    FOREIGN KEY (election_id) REFERENCES r_election (election_id),
    FOREIGN KEY ([objection_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([objection_issue]) REFERENCES[l_r_objection_issue] ([objection_issue]),
    FOREIGN KEY ([objection_action]) REFERENCES[l_r_obj_act_type] ([objection_action]),
    FOREIGN KEY ([objection_result]) REFERENCES[l_r_obj_act_result] ([objection_result])
);

CREATE TABLE IF NOT EXISTS "r_participant" (
    "r_case_number" text,
    "participant_id" integer,
    "participant_role" text,
    "participant_group" text,
    "name_for_correspondence" text,
    "name_prefix" text,
    "first_name" text,
    "mid_name" text,
    "last_name" text,
    "name_suffix" text,
    "street_address_1" text,
    "street_address_2" text,
    "city" text,
    "state" text,
    "zip" text,
    "phone_num" text,
    "phone_ext" text,
    "cell_phone" text,
    "fax_num" text,
    "e_mail_address" text,
    "formal_name" text,
    "parent_name" text,
    "exclusive_service" text,
    "incumbent_union" text,
    "labor_org_code" integer,
    "local_dist_id" text,
    "afl_cio" text,
    "party_scope" text,
    "parti_type" text,
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number),
    FOREIGN KEY ([state]) REFERENCES[l_state] ([state]),
    FOREIGN KEY ([labor_org_code]) REFERENCES[l_labor_org_code] ([labor_org_code]),
    FOREIGN KEY ([parti_type]) REFERENCES[l_parti_type] ([parti_type]),
    FOREIGN KEY ([participant_group]) REFERENCES[l_participant_group] ([participant_group]),
    FOREIGN KEY ([party_scope]) REFERENCES[l_party_scope] ([party_scope]),
    FOREIGN KEY ([participant_role]) REFERENCES[l_r_part_role_type] ([participant_role])
);

CREATE TABLE IF NOT EXISTS "r_part_variant" (
    "r_case_number" text,
    "participant_id" integer,
    "variant_name" text,
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number)
);

CREATE TABLE IF NOT EXISTS "r_post_elect_board_act" (
    "r_case_number" text,
    "received_date" text,
    "received_reason" text,
    "ruling_action_code" integer,
    "exception_withdrawn_date" text,
    "board_decision_date" text,
    "board_action_code" integer,
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number),
    FOREIGN KEY ([board_action_code]) REFERENCES[l_r_board_action_code] ([action_code]),
    FOREIGN KEY ([ruling_action_code]) REFERENCES[l_r_board_action_code] ([action_code]),
    FOREIGN KEY ([received_reason]) REFERENCES[l_r_board_received_reason] ([received_reason])
);

CREATE TABLE IF NOT EXISTS "r_post_elect_hearing" (
    "r_case_number" text,
    "unit_id" text,
    "election_id" text,
    "action_sequence" integer,
    "recurrence" integer,
    "noh_issued" text,
    "hearing_scheduled" text,
    "p_p_request_date" text,
    "p_p_party" text,
    "p_p_determination" text,
    "p_p_order_issued" text,
    "hearing_opened" text,
    "hearing_closed" text,
    "hearing_days" integer,
    "date_reschedule_issued" text,
    "staff_id" text,
    "length_of_transcript" integer,
    "hearing_time" text,
    "hearing_city" text,
    "hearing_state" text,
    "hearing_address" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY (election_id) REFERENCES r_election (election_id) FOREIGN KEY ([p_p_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([hearing_state]) REFERENCES[l_state] ([state]),
    FOREIGN KEY ([p_p_determination]) REFERENCES[l_r_postelec_det_p_p] ([post_elect_determ_p_p])
);

CREATE TABLE IF NOT EXISTS "r_post_elect_rd_act" (
    "r_case_number" text,
    "unit_id" text,
    "election_id" text,
    "action_sequence" integer,
    "recurrence" integer,
    "brief_due" text,
    "brief_filed" text,
    "brief_party" text,
    "eot_request_date" text,
    "eot_party" text,
    "eot_determination_date" text,
    "eot_determination" text,
    "action_date" text,
    "rd_action_type" integer,
    "rd_action_determination" integer,
    "review_due_date" text,
    "date_ho_report" text,
    "ho_report_directed" text,
    "exceptions_due_date" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY (election_id) REFERENCES r_election (election_id),
    FOREIGN KEY ([brief_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([eot_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([eot_determination]) REFERENCES[l_r_postelec_det_eot] ([post_elect_determ_eot]),
    FOREIGN KEY ([ho_report_directed]) REFERENCES[l_r_postelec_ho_directed] ([ho_report_directed]),
    FOREIGN KEY ([rd_action_type]) REFERENCES[l_r_rd_action_type] ([rd_action_type]),
    FOREIGN KEY ([rd_action_determination]) REFERENCES[l_r_rd_action_det] ([rd_action_determination])
);

CREATE TABLE IF NOT EXISTS "r_pre_elect_board_act" (
    "r_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "received_date" text,
    "received_reason" text,
    "ruling_decision_date" text,
    "ruling_action_code" integer,
    "exception_withdrawn_date" integer,
    "board_decision_date" text,
    "board_action_code" integer,
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number),
    FOREIGN KEY ([board_action_code]) REFERENCES[l_r_board_action_code] ([action_code]),
    FOREIGN KEY ([ruling_action_code]) REFERENCES[l_r_board_action_code] ([action_code]),
    FOREIGN KEY ([received_reason]) REFERENCES[l_r_board_received_reason] ([received_reason])
);

CREATE TABLE IF NOT EXISTS "r_pre_elect_hearing" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "recurrence" integer,
    "date_notice_issued" text,
    "date_hearing_scheduled" text,
    "date_rescheduled_issued" text,
    "length_of_transcript" integer,
    "p_p_party" text,
    "p_p_determination" text,
    "p_p_rcvd_region" text,
    "p_p_response_date" text,
    "hearing_opened" text,
    "hearing_closed" text,
    "hearing_days_on_record" integer,
    "hearing_off_rep_date" text,
    "hearing_time" text,
    "hearing_city" text,
    "hearing_state" text,
    "hearing_address" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY ([p_p_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([hearing_state]) REFERENCES[l_state] ([state]),
    FOREIGN KEY ([p_p_determination]) REFERENCES[l_r_preelec_hear_det_p_p] ([determination_request_p_p])
);

CREATE TABLE IF NOT EXISTS "r_pre_elect_rd_bb" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "blue_book_code" text,
    "recurrence" integer,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY ([blue_book_code]) REFERENCES[l_blue_book_codes] ([blue_book_code])
);

CREATE TABLE IF NOT EXISTS "r_pre_elect_rd_decision" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "recurrence" integer,
    "determination_eot" text,
    "eot_party" text,
    "eot_filed_date" text,
    "eot_deter_brief_date" text,
    "brief_rcvd_party" text,
    "pre_election_brief_rcvd" text,
    "rd_decision_issued_date" text,
    "rd_decision_type" text,
    "recon_request_filed" text,
    "recon_request_party" text,
    "rd_recon_deter" text,
    "rd_recon_deter_date" text,
    "brief_due_date" text,
    "review_due_date" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY ([brief_rcvd_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([eot_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([recon_request_party]) REFERENCES[l_case_party] ([party]),
    FOREIGN KEY ([determination_eot]) REFERENCES[l_r_preelec_det_eot] ([determination_eot]),
    FOREIGN KEY ([rd_decision_type]) REFERENCES[l_r_preelec_rd_dec_type] ([rd_decision_type]),
    FOREIGN KEY ([rd_recon_deter]) REFERENCES[l_r_preelec_rd_recon] ([rd_reconsider_deter])
);

CREATE TABLE IF NOT EXISTS "r_pre_elect_rd_issues" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "recurrence" integer,
    "issue_code" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id),
    FOREIGN KEY ([issue_code]) REFERENCES[l_r_preelec_rd_issue_dec] ([issue_code])
);

CREATE TABLE IF NOT EXISTS "r_reopened_case" (
    "r_case_number" text,
    "action_sequence" integer,
    "date_reopened" text,
    "reopen_reason" text,
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number),
    FOREIGN KEY ([reopen_reason]) REFERENCES[l_r_reopen_reason] ([reopen_reason])
);

CREATE TABLE IF NOT EXISTS "r_transfer_history" (
    "r_case_number" text,
    "history_date" text,
    "sequence" integer,
    "date_data_received" text,
    "request_date" text,
    "reason_transfer" text,
    "transfer_type" text,
    "transfer_order_date" text,
    "new_case_number" text,
    "former_case_number" text,
    "sent_date" text,
    "received_date" text,
    FOREIGN KEY (r_case_number) REFERENCES r_case (r_case_number),
    FOREIGN KEY (r_case_number) REFERENCES r_case (former_case_number),
    FOREIGN KEY ([new_case_number]) REFERENCES[r_case] ([r_case_number]),
    FOREIGN KEY ([reason_transfer]) REFERENCES[l_r_reason_transfer] ([reason_transfer]),
    FOREIGN KEY ([transfer_type]) REFERENCES[l_r_transfer_type] ([transfer_type])
);

CREATE TABLE IF NOT EXISTS "r_withdrawal" (
    "r_case_number" text,
    "unit_id" text,
    "action_sequence" integer,
    "withdrawal_approved_date" text,
    "with_prejudice_flag" text,
    FOREIGN KEY (r_case_number, unit_id) REFERENCES r_bargaining_unit (r_case_number, unit_id)
);

CREATE TABLE IF NOT EXISTS "l_allegation_type" (
    "nlra_section" text,
    "allegation_keyname" text,
    "case_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_brief_type" (
    "brief_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_ccr_backpay_control" (
    "backpay_control_code" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_ccr_bargain_status" (
    "other_bargain_status" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_ccr_charge_party_pos" (
    "cp_position" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_ccr_closing_stage" (
    "closing_stage" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_ccr_closing_type" (
    "closing_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_ccr_complaint" (
    "complaint" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_ccr_contempt_rec_type" (
    "contempt_recommended_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_compliance_type" (
    "type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_court" (
    "court" integer,
    "court_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_court_type" (
    "court_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_eot_determination" (
    "eot_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_hearing_record_form" (
    "record_form" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_impact_analysis_cat" (
    "impact_category" integer,
    "description" integer,
    "number_of_days" integer
);

CREATE TABLE IF NOT EXISTS "l_injunction_brief_type" (
    "i_10l_brief_type" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_injunction_motion_type" (
    "motion_type" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_member_type" (
    "member_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_method_filed_type" (
    "method_filed" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_motion_deter" (
    "motion_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_naics_qualifier" (
    "naics_code" integer,
    "naics_qualifier" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_name_prefix" (
    "name_prefix" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_name_suffix" (
    "name_suffix" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_note_type" (
    "note_type" text,
    "description" text,
    "object_tag" integer
);

CREATE TABLE IF NOT EXISTS "l_notifications" (
    "notification_id" integer,
    "participant_group" integer,
    "nlrb_office_id" integer,
    "contact_id" integer,
    "keyword" text,
    "subject" text,
    "coverage" text
);

CREATE TABLE IF NOT EXISTS "l_organization_name" (
    "organization_id" integer,
    "cnt" integer,
    "variant_name" text,
    FOREIGN KEY ([organization_id]) REFERENCES[l_organization] ([organization_id])
);

CREATE TABLE IF NOT EXISTS "l_r_amendment_reason" (
    "amendment_reason" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_r_amendment_type" (
    "amendment_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_r_case_note_topic" (
    "note_topic" integer,
    "description" text,
    "region" integer
);

CREATE TABLE IF NOT EXISTS "l_r_target_description" (
    "target" text,
    "description" text,
    FOREIGN KEY ([target]) REFERENCES[l_r_targets] ([target])
);

CREATE TABLE IF NOT EXISTS "l_r_with_det" (
    "withdrawal_req_deter" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_scope" (
    "scope" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_supervisor_type" (
    "supervisor_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "cl_c_closed_case_report" (
    "c_case_number" text,
    "action_sequence" integer,
    "washington_approval" text,
    "compliance_type" text,
    "closing_type" text,
    "complaint" text,
    "enforcement_recommend" text,
    "contempt_recommended_type" text,
    "emprein_num_discrim" integer,
    "emprein_num_accept" integer,
    "emprein_num_waiving" integer,
    "emprein_num_decline" integer,
    "emprein_num_pref_list" integer,
    "unionres_num_hall_rights" integer,
    "unionres_obj_with" integer,
    "unionres_hired" integer,
    "back_number_made_whole" integer,
    "back_total_num_rcv" integer,
    "back_total_amount_due" real,
    "back_total_employer" real,
    "back_total_union" real,
    "fees_num_individuals" integer,
    "fees_total_due" real,
    "fees_total_employers" real,
    "fees_total_union" real,
    "other_post_notice" text,
    "other_company_post" text,
    "other_union_post" text,
    "other_withdraw_assistance" text,
    "other_withdraw_notice" text,
    "other_disestablish" text,
    "other_disestablish_notice" text,
    "other_end_picketing" text,
    "other_end_picketing_date" text,
    "other_end_picketing_return" integer,
    "other_end_stoppage" text,
    "other_end_stoppage_date" text,
    "other_end_stoppage_return" integer,
    "other_bargain" text,
    "other_bargain_status" text,
    "backpay_control_code" text,
    "back_installment_flag" text,
    "court_costs" text,
    "court_costs_amount" real,
    "court_costs_collected" real,
    "check_forwarded_finance" text,
    "other_remedies" text,
    "cmp_cp_position" text,
    "agent" text,
    "regional_attorney" text,
    "regional_director" text
);

CREATE TABLE IF NOT EXISTS "cl_c_closed_case_report_alleg" (
    "c_case_number" text,
    "action_sequence" integer,
    "nlra_section" text
);

CREATE TABLE IF NOT EXISTS "cl_c_withdrawal" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "disposition_date" text,
    "disposition" text,
    "scope" text,
    "conditional" text,
    "solicited" text,
    "adjusted" text,
    "revoked_date" text,
    "revoked_reason" text
);

CREATE TABLE IF NOT EXISTS "c_10k" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "disposition_method" text,
    "disposition_date" text,
    "disposition_timing" text,
    "board_work_awarded" text,
    "board_deter_date" text
);

CREATE TABLE IF NOT EXISTS "c_advice" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "advice_submission" text,
    "advice_rcvd_submission" text,
    "advice_scope" text,
    "advice_memo_date" text,
    "advice_deter_rcvd_reg" text,
    "file_received_advice" text
);

CREATE TABLE IF NOT EXISTS "c_alj_decision" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "brief_due_date" text,
    "eot_request_rcvd_alj" text,
    "eot_brief_party" text,
    "eot_deter_date" text,
    "eot_determination" text,
    "alj_date_filed" text,
    "alj_brief_rcvd_region" text,
    "alj_brief_party" text,
    "alj_brief_type" text,
    "determination_date" text,
    "determination" text
);

CREATE TABLE IF NOT EXISTS "c_alj_decision_bb" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "blue_book_code" text
);

CREATE TABLE IF NOT EXISTS "c_alj_motion" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "date_filed" text,
    "motion_type" integer,
    "party_filing" text,
    "determination_date" text,
    "motion_determination" text
);

CREATE TABLE IF NOT EXISTS "c_allegation" (
    "c_case_number" text,
    "allegation_sequence" integer,
    "nlra_section" text,
    "allegation_keyname" text
);

CREATE TABLE IF NOT EXISTS "c_alleg_action" (
    "c_case_number" text,
    "allegation_sequence" integer,
    "sequence" integer,
    "action_result" text,
    "action_date" text,
    "action_type" text
);

CREATE TABLE IF NOT EXISTS "c_amendment" (
    "c_case_number" text,
    "sequence" integer,
    "amendment_date" text,
    "amendment_type" text,
    "amendment_reason" text
);

CREATE TABLE IF NOT EXISTS "c_appeal" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "appeal_expiration_date" text,
    "eot_date_filed" text,
    "eot_party" text,
    "eot_date_determination" text,
    "eot_determination" text,
    "appeal_date_filed" text,
    "appeal_action" text,
    "appeal_rcvd_in_region" text,
    "appeal_file_oa" text,
    "appeal_rcvd_oa" text,
    "appeal_file_rtrn_reg" text,
    "appeal_file_rcvd_reg" text,
    "appeal_date_determination" text,
    "appeal_determination" text,
    "appeal_party" text
);

CREATE TABLE IF NOT EXISTS "c_bankruptcy" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "bank_pet_filed" text,
    "bank_pet_party" text,
    "bank_pet_court" integer,
    "bank_pet_case_num" text,
    "bank_pet_type" text,
    "poc_bar_date" text,
    "poc_category" text,
    "poc_date" text,
    "dis_bank_date" text,
    "dis_bank_act" text,
    "chapter_11_approved" text,
    "amount_claimed" real,
    "amount_received" real
);

CREATE TABLE IF NOT EXISTS "c_board_decision" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "transfer_order_date" text,
    "exception_due_date" text,
    "exceptions_eot_date_filed" text,
    "exceptions_eot_party_filing" text,
    "exceptions_eot_deter_date" text,
    "exceptions_eot_determination" text,
    "oral_arg_req" text,
    "oral_argument_req_party" text,
    "oral_arg_order_date" text,
    "oral_arg_sch_date" text,
    "oral_arg_date" text,
    "exceptions_date_filed" text,
    "decision_date" text,
    "date_received_region" text,
    "determination" text,
    "citation" text,
    "request_date" text,
    "request_party" text,
    "request_deter_date" text,
    "request_determination" text,
    "motion_eot_date_filed" text,
    "motion_eot_party_filing" text,
    "motion_eot_deter_date" text,
    "motion_eot_determination" text
);

CREATE TABLE IF NOT EXISTS "c_board_dec_bb" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "blue_book_code" text
);

CREATE TABLE IF NOT EXISTS "c_board_other_motions" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "other_motion_date" text,
    "other_motion_party" text,
    "other_motion_type" text,
    "other_motion_deter_date" text,
    "other_motion_deter" text
);

CREATE TABLE IF NOT EXISTS "c_case" (
    "c_case_number" text,
    "status" text,
    "nlrb_office_id" integer,
    "case_type" text,
    "docket_num" integer,
    "case_suffix_num" integer,
    "case_name" text,
    "date_filed" text,
    "date_closed" text,
    "disposition_due" text,
    "disposition_accomplished" text,
    "charged_party_on_charge" text,
    "charging_party_on_charge" text,
    "inquiry_id" text,
    "employer_involved_on_charge" text,
    "io_assist" text,
    "naics_code" integer,
    "num_8a3_discriminatees" integer,
    "num_8b2_discriminatees" integer,
    "num_employees" integer,
    "postal" text,
    "investigation_complete" text,
    "disposition_date" text,
    "dispute_loc_city" text,
    "dispute_loc_state" text,
    "dispute_loc_county" integer,
    "dispute_loc_zip" text
);

CREATE TABLE IF NOT EXISTS "c_case_case_group" (
    "c_case_group_id" text,
    "c_case_number" text,
    "sequence" integer,
    "lead" text,
    "date_case_added" text,
    "date_case_removed" text
);

CREATE TABLE IF NOT EXISTS "c_case_group" (
    "c_case_group_id" text,
    "case_group_type" text,
    "date_dissolved" text,
    "date_created" text
);

CREATE TABLE IF NOT EXISTS "c_closing" (
    "c_case_number" text,
    "action_sequence" integer,
    "date_closed" text,
    "close_method" text,
    "close_timing" text,
    "date_file_sent_archives" text,
    "date_file_to_records" text,
    "date_file_destroyed" text,
    "preclosing_letter" text,
    "notice_of_closing_date" text
);

CREATE TABLE IF NOT EXISTS "c_collection_activities" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "liens_filed_date" text,
    "liens_filed_court" integer,
    "liens_filed_amount" real,
    "liens_filed_citation" text,
    "escrow_established" text,
    "escrow_location" text,
    "escrow_terms" text,
    "garnishment_date" text,
    "garnishment_party" text,
    "garnishment_court" integer,
    "garnishment_citation" text
);

CREATE TABLE IF NOT EXISTS "c_complaint" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "issued" text,
    "contain_noh" text,
    "answer_to_complaint" text,
    "date_of_withdrawal_order" text
);

CREATE TABLE IF NOT EXISTS "c_compliance_goals" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "letter_date" text,
    "letter_type" text,
    "posting_goal" text,
    "not_post_party" text,
    "posting_type" text,
    "notices_post_dates" text,
    "post_expires" text,
    "reinstatement_goal" text,
    "reinstatement_offered" text,
    "closing_goal" text,
    "backpay_received" text
);

CREATE TABLE IF NOT EXISTS "c_compliance_spec" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "comp_spec_issued" text,
    "backpay_estimate_number" integer,
    "backpay_estimate_amount" real,
    "date_spec_answer_received" text,
    "date_spec_withdrawn" text,
    "date_sw_approved" text,
    "sw_action" text,
    "scope" text,
    "sw_participation" text
);

CREATE TABLE IF NOT EXISTS "c_contempt" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "petition_date" text,
    "brief_rcvd_date" text,
    "brief_rcvd_party" text,
    "brief_pleading" text,
    "oral_arg_sch_date" text,
    "oral_arg_date" text,
    "court_deter_date" text,
    "court_action_type" text,
    "court_action_action" text,
    "som_date_deter" text,
    "som_determination" text,
    "som_filed" text,
    "request_date" text,
    "request_party" text,
    "request_deter_date" text,
    "request_determination" integer,
    "date_received_region" text,
    "citation" text,
    "court" integer,
    "eot_date_filed" integer,
    "eot_party" integer,
    "eot_determination_date" integer,
    "eot_determination" integer,
    "date_settlement_approved" text,
    "settlement_type" text
);

CREATE TABLE IF NOT EXISTS "c_deferral" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "request_party" text,
    "request_received" text,
    "scope" text,
    "date_deferral_issued" text,
    "deferral_type" text,
    "date_deferral_checked" text,
    "date_deferral_extended" text,
    "willingness_date" text,
    "willingness_type" text,
    "date_processing_resumed" text
);

CREATE TABLE IF NOT EXISTS "c_discovery" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "district_court_date" text,
    "district_court_court" integer,
    "district_court_citation" text,
    "date_subpoena_issued" text,
    "date_subpoena_answered" text,
    "discovery_initiated" text,
    "party" text,
    "accordance_with" integer,
    "interrogatories" text,
    "court_action" text,
    "court_determination" text
);

CREATE TABLE IF NOT EXISTS "c_dismissal" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "revoked_reason" text,
    "date_issued" text,
    "scope" text,
    "revoked_date" text,
    "adjusted" text
);

CREATE TABLE IF NOT EXISTS "c_enforcement" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "petition_date" text,
    "petition_party" text,
    "petition_court" integer,
    "brief_rcvd_date" text,
    "brief_rcvd_party" text,
    "brief_pleading" text,
    "oral_arg_sch_date" text,
    "oral_arg_date" text,
    "court_deter_date" text,
    "court_action_type" text,
    "court_action_action" integer,
    "case_citation" text,
    "som_date" text,
    "som_determination" text,
    "request_date" text,
    "request_party" text,
    "request_deter_date" text,
    "request_determination" integer,
    "date_received_region" text,
    "som_date_deter" text,
    "eot_date_filed" integer,
    "eot_party" integer,
    "eot_determination_date" integer,
    "eot_determination" integer,
    "date_settlement_approved" text,
    "settlement_type" text
);

CREATE TABLE IF NOT EXISTS "c_hearing" (
    "c_case_number" text,
    "hearing_type" text,
    "action_sequence" integer,
    "recurrence" integer,
    "scheduled_hearing_date" text,
    "hearing_opened" text,
    "hearing_closed" text,
    "record_form" text,
    "date_notice_issued" text,
    "date_rescheduled_issued" text,
    "p_p_rcvd_region" text,
    "p_p_deter_source" text,
    "p_p_determination" text,
    "p_p_party" text,
    "p_p_deter_date" text,
    "hearing_days_on_record" integer,
    "length_of_transcript" integer,
    "hearing_time" text,
    "hearing_city" text,
    "hearing_state" text,
    "hearing_address" text
);

CREATE TABLE IF NOT EXISTS "c_impact_category" (
    "c_case_number" text,
    "history_sequence" integer,
    "determination_due_date" text,
    "disposition_due_date" text,
    "investigation" integer,
    "investigation_date" text,
    "litigation" integer,
    "litigation_date" text,
    "compliance" integer,
    "compliance_date" text
);

CREATE TABLE IF NOT EXISTS "c_injunction_10j" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "advice_submit_board" text,
    "board_determination" text,
    "board_deter_date" text,
    "board_rcvd_region" text,
    "reason_cease" text,
    "cease_action_date" text,
    "pet_10j_court" integer,
    "pet_10j_filed_date" text,
    "pet_10j_court_case_name" text,
    "pet_10j_withdrawn_date" text,
    "date_answer_resp_rcvd" text,
    "brief_10j_party" text,
    "brief_10j_type" text,
    "brief_10j_date" text,
    "brief_10j_rcvd_region" text,
    "motion_filed" text,
    "motion_filing_party" text,
    "motion_type" text,
    "motion_determination" integer,
    "motion_deter_date" text,
    "discovery_request_date" text,
    "discovery_request_party" text,
    "discovery_type" text,
    "discovery_co_date" text,
    "hearing_ordered" text,
    "hearing_scheduled" text,
    "hearing_opened" text,
    "hearing_closed" text,
    "hearing_days" integer,
    "hearing_evidence_type" text,
    "co_judgement_type" text,
    "co_order_type" text,
    "co_judgement_date" text,
    "co_court" integer,
    "final_disposition_10j" text,
    "final_dispostion_filed" text,
    "tro_granted" text,
    "date_charged_party_notified" text
);

CREATE TABLE IF NOT EXISTS "c_injunction_10l" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "brief_10l_type" integer,
    "brief_10l_party" text,
    "brief_10l_date" text,
    "brief_10l_rcvd_region" text,
    "motion_type" integer,
    "motion_filed" text,
    "motion_filing_party" text,
    "motion_determination" integer,
    "motion_deter_date" text,
    "discovery_request_date" integer,
    "discovery_request_party" integer,
    "discovery_type" integer,
    "discovery_co_date" integer,
    "pet_10l_filed_date" text,
    "pet_10l_court" integer,
    "pet_court_case_name" text,
    "pet_10l_withdrawn" text,
    "answer_10l_rcvd_region" text,
    "hearing_10l_ordered" text,
    "hearing_10l_scheduled" text,
    "hearing_10l_opened" text,
    "hearing_10l_closed" text,
    "hearing_days" integer,
    "hearing_evidence_type" text,
    "co_determination_type" text,
    "co_order_type" text,
    "co_deter_date" text,
    "co_court_issuing" integer,
    "appeal_date" text,
    "appeal_party" text,
    "appeal_court" integer,
    "appellate_date" text,
    "appellate_decision" text,
    "appellate_citation" text,
    "final_disposition_10l" text,
    "final_disposition_filed" text,
    "cease_action_date" text,
    "reason_cease" text,
    "tro_granted" text
);

CREATE TABLE IF NOT EXISTS "c_inj_10j_appeal" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "appeal_date" text,
    "appeal_party" text,
    "appeal_court" integer,
    "appellate_date" text,
    "appellate_decision" text,
    "appellage_citation" text
);

CREATE TABLE IF NOT EXISTS "c_motions_affect_cmp" (
    "c_case_number" text,
    "action_sequence" integer,
    "motion_date" text,
    "motion_forum" text,
    "motion_type" integer,
    "title" text,
    "motion_party" text,
    "determination_date" text,
    "motion_determination" text
);

CREATE TABLE IF NOT EXISTS "c_motion_summ_judge" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "rcvd_board_date" text,
    "motion_party" text,
    "motion_basis" text,
    "notice_show_cause_date" text,
    "notice_reply_due_date" text,
    "notice_eot_request_rcvd" text,
    "notice_eot_party" text,
    "notice_eot_date_deter" text,
    "notice_eot_determination" text,
    "notice_reply_recv_board" text,
    "notice_reply_party" text
);

CREATE TABLE IF NOT EXISTS "c_participant" (
    "c_case_number" text,
    "participant_id" integer,
    "participant_group" text,
    "participant_role" text,
    "name_for_correspondence" text,
    "name_prefix" text,
    "first_name" text,
    "mid_name" text,
    "last_name" text,
    "name_suffix" text,
    "street_address_1" text,
    "street_address_2" text,
    "city" text,
    "state" text,
    "zip" text,
    "phone_num" text,
    "phone_ext" text,
    "cell_phone" text,
    "fax_num" text,
    "e_mail_address" text,
    "formal_name" text,
    "parent_name" text,
    "exclusive_service" text,
    "afl_cio" text,
    "incumbent_union" text,
    "labor_org_code" integer,
    "local_dist_id" text,
    "party_scope" text,
    "parti_type" text
);

CREATE TABLE IF NOT EXISTS "c_regional_compliance" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "date_assigned" text
);

CREATE TABLE IF NOT EXISTS "c_regional_deter" (
    "action_sequence" text,
    "recurrence" integer,
    "organizational_campaign" text,
    "strike_in_same_unit" text
);

CREATE TABLE IF NOT EXISTS "c_reopening" (
    "c_case_number" text,
    "action_sequence" integer,
    "reopen_date" text,
    "reopen_reason" text
);

CREATE TABLE IF NOT EXISTS "c_r_block" (
    "c_case_number" text,
    "sequence" integer,
    "r_case_number" text
);

CREATE TABLE IF NOT EXISTS "c_settlement" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "proposal_letter_sent_date" text,
    "proposed_approval__date" text,
    "inf_settle_approved" text,
    "inf_settle_participation" text,
    "inf_settle_scope" text,
    "inf_settle_revoked" text,
    "fs_settlement_sent_ops" text,
    "fs_submitted_to" integer,
    "formal_scope" text,
    "fs_board_determination" text,
    "fs_determination_date" text,
    "determination_rcvd_reg" text,
    "formal_participation" text
);

CREATE TABLE IF NOT EXISTS "c_supreme_court" (
    "c_case_number" text,
    "action_sequence" integer,
    "supct_reinstated_num" integer,
    "supct_prf_hire_num" integer,
    "supct_made_whole_num" integer,
    "supct_total_backpay" real,
    "supct_fees_awarded" real,
    "supct_fines_awarded" integer,
    "supct_cont_awarded" integer,
    "supct_other_awarded" integer,
    "gc_cert_rec_date" text,
    "petition_cert_date" text,
    "petition_cert_party" text,
    "oral_argument_scheduled" text,
    "oral_argument_held" text,
    "decision_date" text,
    "decision" text,
    "citation" text,
    "certiorari_board_date_deter" text,
    "date_received_region" text,
    "date_pet_determination" text,
    "pet_determination" text
);

CREATE TABLE IF NOT EXISTS "c_sup_aljd_cmp" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "brief_due_date" text,
    "eot_request_rcvd_alj" text,
    "eot_brief_party" text,
    "eot_brief_deter_date" text,
    "eot_brief_determination" text,
    "alj_brief_rcvd_region" text,
    "alj_brief_party" text,
    "eot_brief_type" integer,
    "alj_brief_rcvd_alj" text,
    "alj_date_filed" text,
    "aljd_comp_date" text,
    "aljd_comp_determination" integer
);

CREATE TABLE IF NOT EXISTS "c_sup_board_dec_cmp" (
    "c_case_number" text,
    "action_sequence" integer,
    "recurrence" integer,
    "transfer_order_date" text,
    "exception_due" text,
    "exceptions_eot_date_filed" text,
    "exceptions_eot_party_filing" text,
    "exceptions_eot_deter_date" text,
    "exceptions_eot_determination" text,
    "oral_arg_req" text,
    "oral_argument_req_party" text,
    "oral_arg_order_date" text,
    "oral_arg_sch_date" text,
    "oral_arg_date" text,
    "exception_filed" text,
    "exception_party" text,
    "bd_issued" text,
    "determination" text,
    "date_received_region" text,
    "bd_citation" text,
    "bd_reinstated_num" integer,
    "bd_pref_hire_num" integer,
    "bd_made_whole_num" integer,
    "bd_total_backpay" real,
    "bd_fees_awarded" real,
    "bd_fines_awarded" real,
    "bd_contributions_awarded" real,
    "bd_other_awarded" real,
    "request_date" text,
    "request_party" text,
    "request_deter_date" text,
    "request_determination" text,
    "motion_eot_date_filed" integer,
    "motion_eot_party_filing" integer,
    "motion_eot_deter_date" integer,
    "motion_eot_determination" integer
);

CREATE TABLE IF NOT EXISTS "c_transfer_history" (
    "c_case_number" text,
    "history_date" text,
    "sequence" integer,
    "date_data_received" text,
    "request_date" text,
    "reason_transfer" text,
    "transfer_type" text,
    "transfer_order_date" text,
    "new_case_number" text,
    "former_case_number" text,
    "sent_date" text,
    "received_date" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_advice_deter" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_board_deter" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_brief_type" (
    "i_10j_brief_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_discovery_type" (
    "discovery_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_final" (
    "final_disposition_10j" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_judgement" (
    "judgement_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_motion_determ" (
    "determination_motion" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_motion_type" (
    "motion_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_reason_cease" (
    "reason_cease" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10j_reg_determ_code" (
    "regional_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10l_co_determ" (
    "determination_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10l_discovery_type" (
    "discovery_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10l_final" (
    "final_disposition_10l" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10l_motion_determ" (
    "determination_motion" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10l_reason_cease" (
    "reason_cease" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_10l_reg_determ" (
    "regional_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_abeyance_code" (
    "abeyance_reason" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_accordance_with" (
    "accordance" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_advice_determination" (
    "advice_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_advice_type" (
    "advice_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_alj_cmp_deter" (
    "determination" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_alj_determination" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_alj_mot_typ" (
    "motion_type" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_alleg_act_type" (
    "action_type" text,
    "action_result" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_amendment_reason" (
    "amendment_reason" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_amendment_type" (
    "amendment_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_app_brief_pleading" (
    "brief_pleading" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_app_court_act_type" (
    "court_action_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_app_court_action" (
    "court_action_action" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_appeal_action" (
    "appeal_action" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_appeal_deter" (
    "appeal_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_appellate_court" (
    "determination" integer,
    "description" text,
    "certiorari_board_date_deter" integer
);

CREATE TABLE IF NOT EXISTS "l_c_appellate_enf_deter" (
    "enforcement_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_bank_pet_type" (
    "bank_pet_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_bd_contempt" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_bd_deter_certiorari" (
    "certiorari_board_deter" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_board_determination" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_board_motion_deter" (
    "board_motion_deter" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_board_motion_type" (
    "board_motion_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_board_recon_deter" (
    "request_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_case_group_type" (
    "case_group_type" text,
    "prohibit_manual_maint" integer,
    "description" text,
    "case_group_sort_order" text
);

CREATE TABLE IF NOT EXISTS "l_c_case_note_topic" (
    "note_topic" integer,
    "description" text,
    "region" integer
);

CREATE TABLE IF NOT EXISTS "l_c_case_scope" (
    "scope" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_case_type" (
    "case_type" text,
    "description" text,
    "next_docket_number" integer
);

CREATE TABLE IF NOT EXISTS "l_c_close_determination" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_close_method" (
    "close_method" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_close_timing" (
    "close_timing" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_cmp_letter_type" (
    "letter_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_cmp_spec_sw_action" (
    "sw_action" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_cmp_spec_sw_participation" (
    "sw_participation" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_comp_motion_deter" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_comp_motion_forum" (
    "motion_forum" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_comp_motion_type" (
    "motion_type" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_complaint_reason" (
    "reason_for_withdrawal" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_compliance_reason" (
    "compliance_reason" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_contempt_deter" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_contempt_settlement" (
    "settlement_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_deferral_type" (
    "deferral_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_discharge_bank_act" (
    "dis_bank_action" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_discovery_ct_deter" (
    "court_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_dismissal_revoke" (
    "revoked_reason" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_enf_court_act_type" (
    "court_action_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_enf_court_action" (
    "court_action_action" integer,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_enforcement_settlement" (
    "settlement_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_escrow_acc_loc" (
    "escrow_location" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_formal_settle_type" (
    "formal_settlement_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_fs_submitted" (
    "fs_submitted_to" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_gc_recommendation" (
    "gc_cert_recommendation" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_goal_description" (
    "goal" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_goals" (
    "goal" text,
    "first_effective" text,
    "category" integer,
    "number_of_days" integer,
    "last_effective" text,
    "active" integer
);

CREATE TABLE IF NOT EXISTS "l_c_heac_det_p_p" (
    "determination_request_p_p" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_hearing_type" (
    "hearing_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_inj_appellate_dec" (
    "decision" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_inj_court_order_typ" (
    "court_order_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_inj_evidence_type" (
    "evidence_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_inj_rel_type" (
    "injuctive_relief_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_inj_relief_deter" (
    "injunctive_relief_dec" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_inj_relief_recipient" (
    "injunctive_relief_rec" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_method_of_disp" (
    "method_of_disposition" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_motion_summ_judge" (
    "motion_basis" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_overage_decision" (
    "overage_decision" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_overage_reason" (
    "overage_reason" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_p_p_deter_source" (
    "p_p_deter_source" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_part_role_type" (
    "role_code" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_posting_type" (
    "posting_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_proof_claim_cat" (
    "poc_category" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_reason_transfer" (
    "reason_transfer" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_reg_det_agenda_typ" (
    "agenda_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_reg_det_dec_level" (
    "decision_level" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_reg_det_type" (
    "regional_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_reopen_reason" (
    "reopen_reason" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_settle_part" (
    "participation" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_settlement_bd" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_som_determination" (
    "som_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_spielberg_determ" (
    "spielberg_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_status" (
    "status" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_supreme_ct_deter" (
    "determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_supreme_ct_pet_deter" (
    "pet_determination" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_timing_of_disp" (
    "timing_of_disposition" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_transfer_type" (
    "transfer_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_willingness_type" (
    "willingness_type" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_with_disposition" (
    "disposition" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_with_revocation" (
    "revoked_reason" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "l_c_with_scope" (
    "withdrawal_scope" text,
    "description" text
);

CREATE TABLE IF NOT EXISTS "r_case" (
[r_case_number] text PRIMARY KEY,
[case_type] text,
[status] text,
[nlrb_office_id] text,
[docket_num] integer,
[inquiry_id] text,
[case_name] text,
[date_filed] text,
[hearing_target_date] text,
[election_target_date] text,
[employer_on_petition] text,
[union_involved_on_petition] text,
[intervenor_on_petition] text,
[self_certification] text,
[post_elect_self_cert] text,
[naics_code] integer,
[num_employees_requested] integer,
[description_requested] text,
    FOREIGN KEY ([naics_code]) REFERENCES[l_naics_code] ([naics_code]),
    FOREIGN KEY ([nlrb_office_id]) REFERENCES[l_nlrb_office] ([nlrb_office_id]),
    FOREIGN KEY ([case_type]) REFERENCES[l_r_case_type] ([case_type]),
    FOREIGN KEY ([status]) REFERENCES[l_r_status] ([status])
);

CREATE TABLE IF NOT EXISTS "l_blue_book_division" (
[bb_division] integer PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_blue_book_chapter" (
[bb_chapter] integer PRIMARY KEY,
[bb_division] integer,
[description] text,
    FOREIGN KEY ([bb_division]) REFERENCES[l_blue_book_division] ([bb_division])
);

CREATE TABLE IF NOT EXISTS "l_blue_book_heading" (
[bb_heading] integer,
[bb_chapter] integer,
[bb_division] integer,
[description] text,
    PRIMARY KEY ([bb_heading],[bb_chapter],[bb_division]),
    FOREIGN KEY ([bb_division]) REFERENCES[l_blue_book_division] ([bb_division]),
    FOREIGN KEY ([bb_chapter]) REFERENCES[l_blue_book_chapter] ([bb_chapter])
);

CREATE TABLE IF NOT EXISTS "l_blue_book_section" (
[bb_section] integer,
[bb_heading] integer,
[bb_chapter] integer,
[bb_division] integer,
[description] text,
    PRIMARY KEY ([bb_section],[bb_heading],[bb_chapter],[bb_division]),
    FOREIGN KEY ([bb_division]) REFERENCES[l_blue_book_division] ([bb_division]),
    FOREIGN KEY ([bb_chapter]) REFERENCES[l_blue_book_chapter] ([bb_chapter])
);

CREATE TABLE IF NOT EXISTS "l_blue_book_codes" (
[blue_book_code] text PRIMARY KEY,
[bb_section] integer,
[bb_heading] integer,
[bb_chapter] integer,
[bb_division] integer,
[description] text,
    FOREIGN KEY ([bb_division]) REFERENCES[l_blue_book_division] ([bb_division]),
    FOREIGN KEY ([bb_chapter]) REFERENCES[l_blue_book_chapter] ([bb_chapter])
);

CREATE TABLE IF NOT EXISTS "l_case_party" (
[party] text PRIMARY KEY,
[description] text,
[party_type] text,
    FOREIGN KEY ([party_type]) REFERENCES[l_party_type] ([party_type])
);

CREATE TABLE IF NOT EXISTS "l_county" (
[county_code] integer,
[state] text,
[county_name] text,
    PRIMARY KEY ([county_code],[state]),
    FOREIGN KEY ([state]) REFERENCES[l_state] ([state])
);

CREATE TABLE IF NOT EXISTS "l_state" (
[state] text PRIMARY KEY,
[geographic_division] text,
[geographic_region] text,
[state_name] text,
    FOREIGN KEY ([geographic_division]) REFERENCES[l_geographic_division] ([geographic_division]),
    FOREIGN KEY ([geographic_region]) REFERENCES[l_geographic_region] ([geographic_region])
);

CREATE TABLE IF NOT EXISTS "l_geographic_division" (
[geographic_division] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_geographic_region" (
[geographic_region] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_labor_org_code" (
[labor_org_code] integer PRIMARY KEY,
[labor_org_reference] text,
[labor_org_name] text,
[afl_cio] text
);

CREATE TABLE IF NOT EXISTS "l_naics_sector" (
[naics_sector] integer PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_naics_subsector" (
[naics_subsector] integer,
[naics_sector] integer,
[description] text,
    PRIMARY KEY ([naics_subsector],[naics_sector]),
    FOREIGN KEY ([naics_sector]) REFERENCES[l_naics_sector] ([naics_sector])
);

CREATE TABLE IF NOT EXISTS "l_naics_industry_group" (
[naics_industry_group] integer,
[naics_subsector] integer,
[naics_sector] integer,
[description] text,
    PRIMARY KEY ([naics_industry_group],[naics_subsector],[naics_sector])
);

CREATE TABLE IF NOT EXISTS "l_naics_industry" (
[naics_industry_code] integer,
[naics_industry_group] integer,
[naics_subsector] integer,
[naics_sector] integer,
[description] text,
    PRIMARY KEY ([naics_industry_code],[naics_industry_group],[naics_subsector],[naics_sector])
);

CREATE TABLE IF NOT EXISTS "l_naics_us_industry" (
[naics_us_industry_code] integer,
[naics_industry_code] integer,
[naics_industry_group] integer,
[naics_subsector] integer,
[naics_sector] integer,
[description] text,
    PRIMARY KEY ([naics_us_industry_code],[naics_industry_code],[naics_industry_group],[naics_subsector],[naics_sector])
);

CREATE TABLE IF NOT EXISTS "l_naics_code" (
[naics_code] integer PRIMARY KEY,
[naics_us_industry_code] integer,
[naics_industry_code] integer,
[naics_industry_group] integer,
[naics_subsector] integer,
[naics_sector] integer,
[description] text,
    FOREIGN KEY ([naics_sector]) REFERENCES[l_naics_sector] ([naics_sector])
);

CREATE TABLE IF NOT EXISTS "l_nlrb_branch" (
[branch] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_nlrb_district" (
[district] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_nlrb_division" (
[division] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_nlrb_region" (
[region] text PRIMARY KEY,
[description] text,
[force_xfer_log] text
);

CREATE TABLE IF NOT EXISTS "l_nlrb_office_type" (
[office_type] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_nlrb_office" (
[nlrb_office_id] text PRIMARY KEY,
[region] text,
[branch] text,
[division] text,
[district] text,
[office_name] text,
[description] text,
[supervising_office] text,
[office_mgr_name] text,
[office_type] text,
[street_address_1] text,
[street_address_2] text,
[city] text,
[state] text REFERENCES[l_state] ([state]),
[zip] text,
[main_phone_num] text,
[main_phone_ext] integer,
[main_fax_num] text,
[e_mail_address] text,
[system_time_out] integer,
[io_daily_hours] float,
[trigger_flag] text,
[standard_correspond_path] text,
[standard_reports_path] text,
[office_correspond_path] text,
[office_reports_path] text,
[office_forms_path] text,
[path_legal_research] text,
[path_forms] integer,
[path_summation] text,
[path_crystal] integer,
[message_of_the_day] text,
[date_in_service] text,
[cats_version] integer,
    FOREIGN KEY ([region]) REFERENCES[l_nlrb_region] ([region]),
    FOREIGN KEY ([branch]) REFERENCES[l_nlrb_branch] ([branch]),
    FOREIGN KEY ([division]) REFERENCES[l_nlrb_division] ([division]),
    FOREIGN KEY ([district]) REFERENCES[l_nlrb_district] ([district]),
    FOREIGN KEY ([office_type]) REFERENCES[l_nlrb_office_type] ([office_type])
);

CREATE TABLE IF NOT EXISTS "l_organization" (
[organization_id] integer PRIMARY KEY,
[formal_name] text,
[parent_name] text
);

CREATE TABLE IF NOT EXISTS "l_parti_type" (
[parti_type] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_participant_group" (
[participant_group] text PRIMARY KEY,
[identifier] text,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_party_scope" (
[party_scope] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_party_type" (
[party_type] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_bargain_unit_code" (
[bargaining_unit_code] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_bargain_unit_scope" (
[bargaining_unit_scope] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_block_determination" (
[block_determination] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_board_received_reason" (
[received_reason] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_board_action_src_reason" (
[action_source] text,
[received_reason] text,
    PRIMARY KEY ([action_source],[received_reason]),
    FOREIGN KEY ([received_reason]) REFERENCES[l_r_board_received_reason] ([received_reason])
);

CREATE TABLE IF NOT EXISTS "l_r_board_action_code" (
[action_code] integer PRIMARY KEY,
[action_source] text,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_case_elect_type" (
[election_type] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_case_group_type" (
[case_group_type] text PRIMARY KEY,
[prohibit_manual_maint] integer,
[description] text,
[case_group_sort_order] text
);

CREATE TABLE IF NOT EXISTS "l_r_case_type" (
[case_type] text PRIMARY KEY,
[description] text,
[next_docket_number] integer
);

CREATE TABLE IF NOT EXISTS "l_r_challenge_act_type" (
[challenge_action] integer PRIMARY KEY,
[description] text,
[sort_index] integer,
[pre_investigation] text
);

CREATE TABLE IF NOT EXISTS "l_r_challenge_act_result" (
[challenge_action] integer,
[challenge_result] integer PRIMARY KEY,
[description] text,
    FOREIGN KEY ([challenge_action]) REFERENCES[l_r_challenge_act_type] ([challenge_action])
);

CREATE TABLE IF NOT EXISTS "l_r_challenge_issue" (
[challenge_issue] integer PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_closing_method" (
[closing_method] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_closing_stage" (
[closing_stage] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_elect_agree_type" (
[election_agreement_type] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_elect_mode" (
[election_mode] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_obj_act_type" (
[objection_action] integer PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_obj_act_result" (
[objection_action] integer,
[objection_result] integer PRIMARY KEY,
[description] text,
    FOREIGN KEY ([objection_action]) REFERENCES[l_r_obj_act_type] ([objection_action])
);

CREATE TABLE IF NOT EXISTS "l_r_objection_issue" (
[objection_issue] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_part_role_type" (
[participant_role] text PRIMARY KEY,
[role_name] text
);

CREATE TABLE IF NOT EXISTS "l_r_postelec_det_eot" (
[post_elect_determ_eot] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_postelec_ho_directed" (
[ho_report_directed] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_rd_action_type" (
[rd_action_type] integer PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_rd_action_det" (
[rd_action_determination] integer PRIMARY KEY,
[rd_action_type] integer,
[description] text,
    FOREIGN KEY ([rd_action_type]) REFERENCES[l_r_rd_action_type] ([rd_action_type])
);

CREATE TABLE IF NOT EXISTS "l_r_preelec_det_eot" (
[determination_eot] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_preelec_rd_dec_type" (
[rd_decision_type] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_preelec_rd_recon" (
[rd_reconsider_deter] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_preelec_rd_issue_dec" (
[issue_code] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_reason_transfer" (
[reason_transfer] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_transfer_type" (
[transfer_type] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_reopen_reason" (
[reopen_reason] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_status" (
[status] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_tally_type" (
[tally_type] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_targets" (
[target] text PRIMARY KEY,
[first_effective] text,
[number_of_days] integer,
[last_effective] integer,
[active] integer,
[category] integer
);

CREATE TABLE IF NOT EXISTS "l_r_postelec_det_p_p" (
[post_elect_determ_p_p] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_preelec_hear_det_p_p" (
[determination_request_p_p] text PRIMARY KEY,
[description] text
);

CREATE TABLE IF NOT EXISTS "l_r_action_fields" (
[action_table_code] text,
[action_field_code] text,
[tbl_name] text,
[field_name] text,
[description] text,
[chronology_flag] text,
    PRIMARY KEY ([action_table_code],[action_field_code])
);

