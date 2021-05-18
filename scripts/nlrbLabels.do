********************************************************************************
*
* nlrbLabels.do
* This file is called by cleanNLRBcsvs.do. It defines the value labels for
* encoding different variables in the CATS database's various tables.
* The goal is to use a common encoding acros all tables, where the same
* categorical variables are used.
*
********************************************************************************

label define closing_stage    1 "ABD" 2 "AHCBD" 3 "ANBHC" 4 "ARDD" 5 "BfrNH"
label define closing_method   1 "Admin" 2 "AmCrt" 3 "Dismi" 4 "Rep" 5 "Resul" ///
								6 "Trans" 7 "UniCl" 8 "With"
label define barg_unit_code   1 "Indus" 2 "Dept" 3 "Craft" 4 "Truck" 5 "PrCl" ///
								6 "Guard" 7 "Prof" 8 "Cler" 9 "Healt" 99 "Other"
label define determination    1 "Deny" 2 "Grant" 3 "GrntA" 4 "Other" ///
								5 "FullG" 6 "PartG" 7 "Remnd"
label define election_mode    1 "MANL" 2 "MAIL" 3 "MIXED"
label define ho_report        1 "Board" 2 "RD"
label define part_role        1 "AddS1" 2 "AddS2" 3 "AddS3" 4 "AddS4" ///
								5 "AddS5" 6 "AddS6" 7 "LRep1" 8 "LRep2" ///
								9 "LRep3" 10 "Noti1" 11 "Noti2" 12 "Noti3" ///
								13 "Noti4" 14 "Noti5" 15 "Noti6" 99 "Party"
label define part_group       1 "Emp01" 2 "Emp02" 3 "Emp03" 4 "Emp04" 5 "Emp05" ///
								6 "Int01" 7 "Int02" 8 "Int03" 9 "Pet01" ///
								10 "Pet02" 11 "Pet03" 12 "Pet04" 13 "Pet05" ///
								14 "UnIn1" 15 "UnIn2" 16 "UnIn3"
label define party            1 "EMP" 2 "INT" 3 "PET" 4 "UNIN" 5 "NLRB" 6 "REGN"
label define party_scope      1 "Sngle" 2 "Joint" 3 "NotAp" 4 "AltEg" 99 "Other"
label define reason_received  1 "EXCEP" 2 "RRFIL" 3 "MOTRE" 4 "RCON"
label define reason_reopen    1 "TrxRc" 2 "CrtRv" 3 "DisRv" 4 "WdRev" 5 "Other"
label define reason_transfer  1 "NeedA" 2 "Geogr" 3 "Conso" 4 "Other"
label define status           1 "Close" 2 "Initi" 3 "PBBrd" 4 "PCert" ///
								5 "PElec" 6 "PFPRC" 7 "PRDD" 8 "PRREX" ///
								9 "PostE" 10 "RETRD" 11 "RREVG" 12 "Block" ///
								13 "Excep"
label define type_case        1 "AC" 2 "RC" 3 "RD" 4 "RM" 5 "UC" 6 "UD" 7 "WH"
label define type_case_group  1 "Conso"
label define type_elect_agree 1 "Stip" 2 "Cons"
label define type_election    1 "Initi" 2 "Secon" 3 "Third" 4 "Fourt" ///
								5 "Fifth" 98 "Rerun" 99 "Runof"
label define type_participant 1 "U" 2 "E" 3 "I" 99 "B"
label define type_rd_decision 1 "DirEl" 2 "DecOr" 3 "Dismi" 4 "OrdCU" ///
								5 "OrApW" 6 "AmdCe" 7 "Other"
label define type_tally 	  1 "IInit" 2 "ISeco" 3 "IThir" 4 "IFour" ///
								5 "IFift" 98 "IReru" 99 "IRunf" 6 "RInit" ///
								7 "RSeco" 8 "RThir" 88 "RRunf" 89 "RevRe"
label define type_transfer    1 "Perm" 2 "Temp" 3 "Other"
label define unit_id          1 "A" 2 "B" 3 "C" 4 "D" 5 "E" 6 "F" 7 "G" ///
								8 "H" 9 "I" 10 "J"
label define winloss          0 "LOSS" 1 "WIN"
label define yesno            0 "N" 1 "Y" 99 "U"
