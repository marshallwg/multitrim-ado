*ADO TO TRIM MULTIPLE STRING VARIABLES SIMULTANEOUSLY
//Created by mwg on 1/29/2020
//version 1.0
discard
capture program drop multitrim
program define multitrim
	version 9.2
	syntax [varlist(default=none)], ///
		[ALL ///
		INNER ///
		]
	*Error checking
	if !mi("`all'") & !mi("`varlist'") {
		di as error "Specify a {bf:varlist} or the option {bf:all}, not both."
		exit 110
	}
	
	*Error checking
	if mi("`all'") & mi("`varlist'") {
		di as error "Specify a {bf:varlist} or the option {bf:all}."
		exit 110
	}	
	
	*Now, programming command
	if !mi("`all'") {
		quietly findname *, type(string)
		foreach var of varlist `r(varlist)' {
			replace `var'=trim(`var')
			if !mi("`inner'") {
				replace `var'=itrim(`var')
			}
		}
	}
	
	if !mi("`varlist'") {
		quietly findname `varlist', type(string)
		foreach var of varlist `r(varlist)' {
			replace `var'=trim(`var')
			if !mi("`inner'") {
				replace `var'=itrim(`var')
			}			
		}
	}	
	
end