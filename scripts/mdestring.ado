* 1.0 John-Paul Ferguson 15Sep2016
* mdestring: destring multiple numeric variables in one command
* This is just a loop that runs destring across a varlist instead
* of a varname. Useful when you have a lot of files with a lot of
* ought-to-be-numeric variables that were read in mistakenly as 
* strings. Note that you can use the ", force" option to replace
* even when there are non-numeric values in the variables, but that
* force here is an all-or-nothing proposition.
capture program drop mdestring
program mdestring
	version 14
	syntax varlist[, force]
	foreach var of varlist `varlist' {
		destring `var', replace `force'
	}
end
