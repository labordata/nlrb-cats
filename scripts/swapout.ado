* 1.0 John-Paul Ferguson 14jul2011
* swapout: Command to replace one variable with another one.
* Often when converting string variables to more friendly formats,
* I just want to drop the string variable and have the new variable
* appear in the same spot in the dataset, with the same name. This
* does that in one line.
capture program drop swapout
program swapout
	version 11
	quietly {
		move `2' `1'
		drop `1'
		rename `2' `1'
	}
end
