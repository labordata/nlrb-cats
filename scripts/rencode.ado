* 1.0 John-Paul Ferguson 15sep2016
* rencode: replace a string variable with an encoded categorical one,
* with the option of specifying value labels. I often find myself encoding
* variables through the tedious process of "encode, gen() label()", then
* moving the new variable to the same spot in the dataset as the string,
* then dropping the string and renaming the new variable with the old name.
* this command does four lines in one line.
capture program drop rencode
program rencode
	version 11
	syntax varlist[, Label(string) NOExtend]
	quietly {
		encode `varlist', generate(`varlist'_e) label(`label') `noextend'
		swapout `varlist' `varlist'_e
	}
end
