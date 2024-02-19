# Wii Sports Billiards Iterator Script

## Context:  
https://www.youtube.com/watch?v=9Zay5lEeMlk

Their discord:  
https://discord.com/invite/zUe9gZ8YMg

## What is this?
This is a script for Wii Sports Billiards that:
 - Loads a newgame state
 - Increments the hit speed
 - Runs the game
 - Logs the result (balls in holes) in a csv file.

This is part of researching the Billiards minigame in Wii Play, with the ultimate goal of determining the game's theoretical limit, and whether or not it's possible to sink all nine balls in one shot.

## Short demo vid of script:
https://www.youtube.com/watch?v=vyIUO3vSlII

## Usage:

Download latest Dolphin-Lua-Core from here: 
https://github.com/SwareJonge/Dolphin-Lua-Core/releases/tag/v3.5.1

- Create a save state of the Billiards game in the beginning of the game
- Change the lua logfile to the correct location
- Set the speed to something you want, and the iteration
- Put the script in Emulator\Sys\Scripts
- Load the script

The script is probably kinda bad if you actually know LUA, but it has a bunch of weird things going on, but it works.

It runs the game, records which balls were in, at which speed, and restarts.

## TODO:

This script current uses a memory write to set the exact speed.
It would be better to use a TAS and actually use the pool cue instead.

If you're ok with LUA and think you can do this, feel more than welcome to send a PR :)