$MININT = "C:\MININT"
$SMSTaskSequence = "C:\_SMSTaskSequence"

# Clean up any existing C:\MININT directory
	if (Test-Path -Path $MININT) {
	    Remove-item -LiteralPath $MININT  -Force -Recurse
	} else {
		"MININT doesn't exist"
	}

# Clean up any existing C:\_SMSTaskSequence
	if (Test-Path -Path $SMSTaskSequence) {
	    Remove-item -LiteralPath $SMSTaskSequence  -Force -Recurse
	} else {
		"_SMSTaskSequence doesn't exist"
	}