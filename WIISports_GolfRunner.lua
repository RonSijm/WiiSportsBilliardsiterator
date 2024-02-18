-- You can change these values depending on what you want to emulate
local logfile = "C:\\Users\\ronsi\\Downloads\\Dolphin\\logfile.csv"
local iteration = 1
local speed = 1
local increment = 0.001

-- Internal state, don't change this
local scriptRunning = false

function onScriptStart()
	MsgBox("Script Started.")
    
    if not (file_exists(logfile)) then
        local logFile = io.open(logfile, "a")
        logFile:write("speed;ball1;ball2;ball3;ball4;ball5;ball6;ball7;ball8;ball9;ballScore\n")
        logFile:close()
    end
    
end

function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end


function onScriptCancel()
	MsgBox("Script Ended.")
end
function onScriptUpdate()
    -- Fucking weird ass LUA needs kinda stuff
    -- To return control to the game to have it run for a while
    -- Since LUA seems to be blocking

   	if(iteration ~= 2000) then
        iteration = iteration + 1
    else
        iteration = 1
    
        local ball1 = ReadValue8(0x91B4CF7B)
        local ball2 = ReadValue8(0x91B4D6AB)
        local ball3 = ReadValue8(0x91B4DDDB)
        local ball4 = ReadValue8(0x91B4E50B)
        local ball5 = ReadValue8(0x91B4EC3B)
        local ball6 = ReadValue8(0x91B4F36B)
        local ball7 = ReadValue8(0x91B4FA9B)
        local ball8 = ReadValue8(0x91B501CB)
        local ball9 = ReadValue8(0x91B508FB)
        
        local ballScore = ball1 + ball2 + ball3 + ball4 + ball5 + ball6 + ball7 + ball8 + ball9
    
        -- LUA needs to close the file to flush?
        local logFile = io.open(logfile, "a")
        logFile:write("" .. speed - increment .. ";" .. ball1 .. ";".. ball2 .. ";".. ball3 .. ";".. ball4 .. ";".. ball5 .. ";".. ball6 .. ";".. ball7 .. ";".. ball8 .. ";".. ball9 .. ";".. ballScore .. "\n")
        logFile:close()
        
    	if(scriptRunning == false) then
	        scriptRunning = true
		    doScript()
	    end
    
    end
    
end

function onStateLoaded()
        MsgBox("Setting speed to: " .. speed)
        WriteValueFloat(0x91B4C8C8, speed)
        speed = speed + increment
        scriptRunning = false     
end

function onStateSaved()

end

function doScript()
        LoadState(true, 1)
end