insert into nlrb_case select a.* from r_case a inner join r_case b using
(r_case_number) where b.status is null and a.status is not null;

insert into nlrb_case select * from r_case where r_case_number in (select r_case_number from r_case group by r_case_number having count(*) = 1);

insert into case_group            select * from r_case_group            ;
insert into election              select * from r_election;

insert into action                select * from r_action                ;
insert into block                 select * from r_block                 ;
insert into block_cases           select * from r_block_cases           ;
insert into case_case_group       select * from r_case_case_group       ;
insert into challenge_issue       select * from r_challenge_issue       ;
insert into challenge_tabulation  select * from r_challenge_tabulation  ;
insert into closed_case           select * from r_closed_case           ;
insert into dismissal             select * from r_dismissal             ;
insert into elect_agreement       select * from r_elect_agreement       ;
insert into elect_certification   select * from r_elect_certification   ;
insert into elect_scheduled       select * from r_elect_scheduled       ;
/* insert into frequently_requested_fields        select * from cats-frf-r.final        ; */
insert into election_tally        select * from r_election_tally group by election_id, unit_id, tally_id;
insert into elect_votes_for       select * from r_elect_votes_for group by election_id, unit_id, tally_id, sort_order;
insert into impact_category       select * from r_impact_category       ;
insert into objection_issue       select * from r_objection_issue       ;
insert into participant           select * from r_participant group by r_case_number, participant_id          ;
insert into post_elect_board_act  select * from r_post_elect_board_act  ;
insert into post_elect_hearing    select * from r_post_elect_hearing    ;
insert into post_elect_rd_act     select * from r_post_elect_rd_act     ;
insert into pre_elect_board_act   select * from r_pre_elect_board_act   ;
insert into pre_elect_hearing     select * from r_pre_elect_hearing     ;
insert into pre_elect_rd_bb       select * from r_pre_elect_rd_bb       ;
insert into pre_elect_rd_decision select * from  r_pre_elect_rd_decision ;
insert into pre_elect_rd_issues   select * from  r_pre_elect_rd_issues  ;
insert into reopened_case         select * from r_reopened_case         ;
insert into transfer_history      select * from r_transfer_history      ;
insert into withdrawal            select * from r_withdrawal            ;

drop table r_case;
drop table r_election;
drop table r_case_group ;
drop table r_action                ;
drop table r_block                 ;
drop table r_block_cases           ;
drop table r_case_case_group       ;
drop table r_challenge_issue       ;
drop table r_challenge_tabulation  ;
drop table r_closed_case           ;
drop table r_dismissal             ;
drop table r_elect_agreement       ;
drop table r_elect_certification   ;
drop table r_elect_scheduled       ;
drop table r_elect_votes_for       ;
drop table r_election_tally        ;
drop table r_impact_category       ;
drop table r_objection_issue       ;
drop table r_participant           ;
drop table r_post_elect_board_act  ;
drop table r_post_elect_hearing    ;
drop table r_post_elect_rd_act     ;
drop table r_pre_elect_board_act   ;
drop table r_pre_elect_hearing     ;
drop table r_pre_elect_rd_bb       ;
drop table  r_pre_elect_rd_decision ;
drop table  r_pre_elect_rd_issues  ;
drop table r_reopened_case         ;
drop table r_transfer_history      ;
drop table r_withdrawal            ;
