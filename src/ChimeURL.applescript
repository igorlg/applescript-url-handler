on open location this_URL
	set AppleScript's text item delimiters to "/"
	set callid to text item 4 of this_URL
	
	# Match URL e.g. https://chime.aws/1234567890 with regex. (10 digits)
	set isMatch to "0" = (do shell script "[[ " & quoted form of callid & " =~ ^[[:digit:]]{10} ]]; printf $?")
	
	# If match, it's a Chime meeting, thus open the app.
	# Otherwise, open in the browser
	if isMatch then
		set chime_handle to "chime://meeting?pin=" & callid
	else
		set chime_handle to "x-choosy://chrome.work/" & this_URL
	end if
	
	do shell script "open " & chime_handle
	# display alert chime_handle
end open location

