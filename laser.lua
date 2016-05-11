local M = {}

local enemy = require( 'enemy' )
local asteroid = require( 'asteroid' )

function M.init()
	M.laser1 = {}
	M.laser1.speed = 3.33*GameSpeed
	M.countLasers1 = 0
	Runtime:addEventListener( 'enterFrame', M.laserMove )

end

function M.shoot( event )
	table.insert( M.laser1, 1, display.newImage( 'img/laser.png', spritePlayerShip.x, spritePlayerShip.y - _H/10) )
	M.countLasers1 = M.countLasers1 + 1
end

function M.laserMove( event )
	local tDelta = event.time - tPrevious
	tPrevious = event.time
	for i=1,#M.laser1 do
		if (M.laser1[i] ~= nil) then
			M.laser1[i].y = M.laser1[i].y - M.laser1.speed
			if M.laser1[i].y < -_H/2 then
				table.remove( M.laser1 )
			end
			if enemy.enemy ~= nil and enemy.enemy.y ~= nil and M.laser1[i] ~= nil and M.laser1[i].y ~= nil then
				if ( ( ( math.round( M.laser1[i].y ) > math.round( enemy.enemy.y - 40 ) ) and ( math.round( M.laser1[i].y ) < math.round( enemy.enemy.y + 40 ) ) ) and ( ( math.round(M.laser1[i].x) < ( math.round( enemy.enemy.x + 30 ) ) and ( math.round(M.laser1[i].x) > ( math.round( enemy.enemy.x - 30 ) ))) ) and enemy.enemy.mayKillYou ) then
					enemy.enemyDefeat()
					M.laser1[i].x = -_W
				end
			end
			for j=1, #asteroid.mainTable do
				if asteroid.mainTable[j] ~= nil and asteroid.mainTable[j].y ~= nil and M.laser1[i] ~= nil and M.laser1[i].y ~= nil then
					if  ( ( math.round( M.laser1[i].y ) > math.round( asteroid.mainTable[j].y - 40 ) ) and ( math.round( M.laser1[i].y ) < math.round( asteroid.mainTable[j].y + 40 ) ) ) and ( ( math.round(M.laser1[i].x) < ( math.round( asteroid.mainTable[j].x + 30 ) ) and ( math.round(M.laser1[i].x) > ( math.round( asteroid.mainTable[j].x - 30 ) ) ) ) ) then
						if ( asteroid.mainTable[j].laserId == 0 or asteroid.mainTable[j].laserId ~= M.laser1[i]) then
							asteroid.mainTable[j].laserId = M.laser1[i]
							asteroid.mainTable[j].countShoots = asteroid.mainTable[j].countShoots + 1
							if asteroid.mainTable[j].destroyed == false then
								M.laser1[i].x = -_W
								M.laser1[i].y = -_H
								table.remove( M.laser1 )
								M.countLasers1 = M.countLasers1 - 1
							end
							if asteroid.mainTable[j].countShoots == 3 then
								asteroid.preDestroy(asteroid.mainTable[j])
							end
						end
					end
					if ( asteroid.mainTable[j].destroyed ) then
						local currentTime = system.getTimer()
						if ( asteroid.mainTable[j].timeDestroy - currentTime < -3000000) then
							asteroid.destroy( asteroid.mainTable[j] )
						end
					end
				end
			end
		end
	end
end

return M