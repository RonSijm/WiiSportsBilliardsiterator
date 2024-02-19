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

    local debugText = "Speed:" .. speed .. "\n" .. "ball1:" .. ball1 .. "\n" .. "ball2:" .. ball2 .. "\n" .. "ball3:" .. ball3 .. "\n" .. "ball4:" .. ball4 .. "\n" .. "ball5:" .. ball5 .. "\n" .. "ball6:" .. ball6 .. "\n" .. "ball7:" .. ball7 .. "\n" .. "ball8:" .. ball8 .. "\n" .. "ball9:" .. ball9.. "\n\n" .. "ball score:" .. ballScore

    SetScreenText(debugText)

    -- Weird stuff LUA needs to return control to the game
    -- Since otherwise LUA seems to be blocking
   	if(iteration ~= 2500) then
        iteration = iteration + 1
    else
        
        iteration = 1
              
    	if(scriptRunning == false) then
	        scriptRunning = true
                       
            local logFile = io.open(logfile, "a")
            logFile:write("" .. speed .. ";" .. ball1 .. ";".. ball2 .. ";".. ball3 .. ";".. ball4 .. ";".. ball5 .. ";".. ball6 .. ";".. ball7 .. ";".. ball8 .. ";".. ball9 .. ";".. ballScore .. "\n")
            
            -- LUA needs to close the file to flush the write
            -- That's why it might seem weird I'm not just keeping the file handle open...
            logFile:close()
                       
            speed = speed + increment
            
		    LoadState(true, 1)
	    end
    
    end
    
end

function onStateLoaded()
        MsgBox("Setting speed to: " .. speed)
        WriteValueFloat(0x91B4C8C8, speed)
        scriptRunning = false   
end

function onStateSaved()

end

-- It seems that it's completely undeterministic
-- If you change the speed even with just a little bit,
-- The ball doesn't go in the same direction at a fast speed, it also goes in a slightly different direction.
-- So after the first bounce, the game-state is completely re-random if the speed changes
function Unused()

           if(ballScore == 0) then increment = 0.1
           elseif(ballScore == 1) then increment = 0.1
           elseif(ballScore == 2) then increment = 0.05
           elseif(ballScore == 3) then increment = 0.001
           elseif(ballScore == 4) then increment = 0.001
           elseif(ballScore == 5) then increment = 0.001
           elseif(ballScore == 6) then increment = 0.0001
           elseif(ballScore == 7) then increment = 0.00001
           elseif(ballScore == 8) then increment = 0.000001
           elseif(ballScore == 9) then increment = 0.000000
           end

end