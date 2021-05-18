* 1.0 John-Paul Ferguson 15sep2016
* nlrbdate: Move string dates to Stata date format, conditional on the 
* format of the string. This is a classic janky command that should be
* made more general-purpose. Many dates in the NLRB files have the format
* "10jan2010T00:00:00", where the time component is ignorable and it would
* be useful to have the string in a date format Stata understands. This
* command creates a %td-formatted variable with the calendar day in it, and
* swaps it out for the string variable. It does so over every variable in
* varlist.
capture program drop nlrbdate
program nlrbdate
	version 11
	syntax varlist
	foreach var of varlist `varlist' {
		quietly {
			generate _d_`var' = dofc(clock(subinstr(`var',"T"," ",.),"YMDhms"))
			format _d_`var' %td
			swapout `var' _d_`var'
		}
	}
end
