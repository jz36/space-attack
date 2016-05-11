local math = require('math')

local M = {}

M.mainTable = {}

function M.init()
	M.sheet = graphics.newImageSheet( "img/asteroid.png", { width=80, height=80, numFrames=4 } )
	Runtime:addEventListener( 'enterFrame', M.move )
end

function M.createAsteroid( row, height )
	sprite = display.newSprite( M.sheet, {name='asteroid', start=1, count=4, time=500, loopCount = 1 } )
	sprite.x = centerX + row
	sprite.y = -64 - height
	sprite.countShoots = 0
	sprite.laserId = 0
	sprite.rotation = math.random(90)
	sprite.destroyed = false
	table.insert( M.mainTable, sprite)
end

local function createLeftAsteroid( height )
	M.createAsteroid( -_W/3, height )
end

local function createCenterAsteroid( height )
	M.createAsteroid( 0, height )
end

local function createRightAsteroid( height )
	M.createAsteroid( _W/3, height )
end

local function createLeftCenterAsteroid(  )
	createLeftAsteroid( 0 )
	createCenterAsteroid( 0 )
end

local function createRightCenterAsteroid(  )
	createRightAsteroid( 0 )
	createCenterAsteroid( 0 )
end

local function createLeftRightAsteroid(  )
	createRightAsteroid( 0 )
	createLeftAsteroid( 0 )
end

local function createThreeInRowAsteroid(  )
	createLeftAsteroid( 0 )
	createCenterAsteroid( 0 )
	createRightAsteroid( 0 )
end

local function createUpLeftCenterAsteroid(  )
	createLeftAsteroid( -64 )
	createCenterAsteroid( 0 )
end

local function createUpRightCenterAsteroid(  )
	createRightAsteroid( -64 )
	createCenterAsteroid( 0 )
end

local function createUpCenterLeftAsteroid(  )
	createCenterAsteroid( -64 )
	createLeftAsteroid( 0 )
end

local function createUpCenterRightAsteroid(  )
	createCenterAsteroid( -64 )
	createRightAsteroid( 0 )
end

local function createUpLeftRightAsteroid( )
	createLeftAsteroid( -64 )
	createRightAsteroid( 0 )
end

local function createUpRightLeftAsteroid(  )
	createLeftAsteroid( 0 )
	createRightAsteroid( -64 )
end

local function createUpLeftCenterRightAsteroid(  )
	createLeftAsteroid( -64 )
	createCenterAsteroid( 0 )
	createRightAsteroid( 0 )
end

local function createUpCenterLeftRightAsteroid(  )
	createLeftAsteroid( 0 )
	createCenterAsteroid( -64 )
	createRightAsteroid( 0 )
end

local function createUpRightLeftCenterAsteroid(  )
	createLeftAsteroid( 0 )
	createCenterAsteroid( 0 )
	createRightAsteroid( -64 )
end

function M.fate(  )
	local fate = math.random( 1, 16 )
	if ( fate == 1 ) then
		createLeftAsteroid( 0 )
	elseif ( fate == 2 ) then
		createRightAsteroid( 0 )
	elseif ( fate == 3 ) then
		createCenterAsteroid( 0 ) 
	elseif ( fate == 4 ) then
		createLeftCenterAsteroid(  )
	elseif ( fate == 5 ) then
		createRightCenterAsteroid(  )
	elseif ( fate == 6 ) then
		createLeftRightAsteroid(  )
	elseif ( fate == 7 ) then
		createThreeInRowAsteroid(  )
	elseif ( fate == 8 ) then
		createUpLeftCenterAsteroid(  )
	elseif ( fate == 9 ) then
		createUpRightCenterAsteroid(  )
	elseif ( fate == 10 ) then
		createUpCenterLeftAsteroid(  )
	elseif ( fate == 11 ) then
		createUpCenterRightAsteroid(  )
	elseif ( fate == 12 ) then
		createUpLeftRightAsteroid(  )
	elseif ( fate == 13 ) then
		createUpRightLeftAsteroid(  )
	elseif ( fate == 14 ) then
		createUpLeftCenterRightAsteroid(  )
	elseif ( fate == 15 ) then
		createUpCenterLeftRightAsteroid(  )
	elseif ( fate == 16 ) then
		createUpRightLeftCenterAsteroid(  )
	end
end 

function M.move( event )
	local tDelta = event.time - tPrevious
	tPrevious = event.time
	for i=1,#M.mainTable do
		if ( M.mainTable[i] ~= nil ) then
			M.mainTable[i].y = M.mainTable[i].y + GameSpeed
			if M.mainTable[i].y > _H + 64 then
				M.destroy(M.mainTable[i])
			end
		end
		if M.mainTable[i] ~= nil and M.mainTable[i].y ~= nil then
			if ((( ( math.round( spritePlayerShip.y ) > math.round( M.mainTable[i].y - 40 ) ) and ( math.round( spritePlayerShip.y ) < math.round( M.mainTable[i].y + 40 ) ) ) and ( ( math.round(spritePlayerShip.x) < ( math.round( M.mainTable[i].x + 30 ) ) and ( math.round(spritePlayerShip.x) > ( math.round( M.mainTable[i].x - 30 ) ) ) ) ) ) and ( M.mainTable[i].destroyed == false) ) then
				print('gameOver')
			end
		end
	end
end

function M.preDestroy( sprite )
	sprite.destroyed = true
	sprite:play()
	sprite.timeDestroy = system.getTimer()
end

function M.destroy( spriteDestroy )
	table.remove( M.mainTable, table.indexOf( M.mainTable, spriteDestroy) )
	spriteDestroy.x = -_W
	spriteDestroy.y = nil
	spriteDestroy = nil
end

return M