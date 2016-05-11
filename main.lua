-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--Global Reference

centerX = display.contentCenterX
centerY = display.contentCenterY
_W = display.contentWidth
_H = display.contentHeight
GameSpeed = 6


tPrevious = system.getTimer()

local math = require('math')
local os = require('os')
local table = require( 'table' )
local stars = require('stars')
local coins = require( 'coins' )
local enemy = require( 'enemy' )
local laser = require( 'laser' )
local asteroid = require( 'asteroid' )
local barrierMaster = require ( 'barrierMaster' )

--Create backround

local background = display.newRect( centerX, centerY, _W, _H )
background:setFillColor( 0 )

--Create stars + function for stars moving

--[[stars.init()

coins.init()

coins.createRandomRowCoins()

asteroid.init()

enemy.init()

laser.init()--]]

--Creating coins

--Creating player group, include player, engine, guns

local lifeBar = display.newGroup()

lifeBar.y = _H

local hearts = {}

hearts.range = centerX - _W / 10

for i=1,3 do
	hearts[i] = display.newImage( lifeBar, 'img/heart_2.gif' )
	hearts[i].x = hearts.range
	hearts.range = hearts.range + _W / 10
end

local playerGroup = display.newGroup()

local sheet3 = graphics.newImageSheet( "PlayerShip2.png", { width=47, height=110, numFrames=3 } )

spritePlayerShip = display.newSprite( sheet3, {name="space", start=1, count=3, time=500 } )
spritePlayerShip.x = display.contentWidth * 0.5
spritePlayerShip.y = _H * 0.85

spritePlayerShip:play()

--Function for players move

local beganX, endedX

function moveShipLeft( event )
	local deltaX
	if( event.phase == 'began' ) then
		beganX = event.x
	end
	if ( event.phase == 'ended' ) then
		endedX = event.x
		deltaX = beganX - endedX
		if ( deltaX > 0 ) then
			if math.round(spritePlayerShip.x) == math.round(centerX) then
				transition.moveTo( spritePlayerShip, { time=100, x=centerX-(_W/3) } )
			elseif math.round(spritePlayerShip.x) == math.round(centerX + ( _W/3 ) ) then
				transition.moveTo( spritePlayerShip, { time=100, x=centerX } )
			end
		elseif deltaX < 0 then
			if ( math.round(spritePlayerShip.x) == math.round(centerX) ) then
				transition.moveTo( spritePlayerShip, { time=100, x=centerX+(_W/3) } )
			elseif ( math.round(spritePlayerShip.x) == math.round(centerX - ( _W/3 ) ) ) then
				transition.moveTo( spritePlayerShip, { time=100, x=centerX } )
			end
		end
	end 
	
end

local function createHorde(  )
	local hordeCoord = {}
	--local horde = display.newLine(100,0,99.984769515639,1.7452406437284)
	table.insert( hordeCoord, 0 )
	table.insert( hordeCoord, 0 )
	for i=-245, 45 do
		local degInRad = (i * math.pi) / 180
		table.insert( hordeCoord, math.cos(degInRad) * _H/10 )
		table.insert( hordeCoord, math.sin(degInRad) * _H/10 )
		--horde:append( math.cos(degInRad) * 100, math.sin(degInRad) * 100 )
	end 
	local horde = display.newPolygon( centerX, centerY, hordeCoord )
	horde:setStrokeColor( 1, 0, 0, 1 )
	horde:setFillColor( 1, 1, 1, 0 )
	horde.strokeWidth = 2
	for i=1,20 do
		print(hordeCoord[i])
	end
end

createHorde()


--[[function fate( event )
	if ((coins.coins.destroy == coins.coins.len) and (enemy.enemy == nil) and (#asteroid.mainTable == 0)) then
		local fate = math.random(100)
		if fate < 33 then
			coins.createRandomRowCoins( )
		elseif( (fate >= 33) and (fate <= 67) ) then
			asteroid.fate(  )
		else
			enemy.createEnemy()
		end
	end
	
end

function gameSpeed( event )
	if (system.getTimer() * 0.00001 < 6) then
		GameSpeed = 6
	elseif (system.getTimer() * 0.00001 > 20) then
		GameSpeed = 20
	else 
		GameSpeed = system.getTimer() * 0.00001
	end
end

background:addEventListener("touch", moveShipLeft)
coins.addEventListenerForCoins()
Runtime:addEventListener( "enterFrame", enemy.openEnemy )
Runtime:addEventListener( "enterFrame", gameSpeed )
background:addEventListener( 'tap', laser.shoot )
Runtime:addEventListener( 'enterFrame', fate )--]]
