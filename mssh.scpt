#mkdir -p ~/Library/Application\ Support/iTerm/Scripts/
#place this script at ~/Library/Application\ Support/iTerm/Scripts/mssh.scpt
#restart iTerm
#prepare files with different server sets, e.g. my-production-servers.txt
#in iTerm select Scripts->mssh.scpt and choose my-production-servers.txt
#enjoy

set theFile to choose file with prompt "Please select a file with server list to open:"

set theFile to theFile as string
set fileContent to read file theFile
set serversList to every paragraph of fileContent
set serversSize to count of serversList
set rowsNum to serversSize^(1/2) as integer
set colsNum to serversSize^(1/2) as integer

tell application "iTerm"
	tell current window
    	create tab with default profile
	
		set currentCount to 1
		set prevSess to current session	
			
		
		repeat with rIx from 1 to rowsNum
			select prevSess
			tell current session
				if currentCount <= serversSize then
					set nextSess to split horizontally with same profile
				end if
			end tell

			repeat with cIx from 1 to colsNum
			    
			    if currentCount <= serversSize then
			        set serv to item currentCount of serversList
			        tell current session
						split vertically with same profile command "ssh " & serv
					end tell
					set currentCount to currentCount + 1
				end if
			
			end repeat

			close prevSess
			select nextSess
			set prevSess to nextSess
		
		end repeat

		close current session
	end tell
end tell
