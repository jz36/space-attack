local M = {}

function M.init()

	M.enemySheet = graphics.newImageSheet( 'img/enemy.png', { width=60, height=65, numFrames=3 } )

end

	function M.createEnemy()
		math.randomseed( os.time() )
		M.enemy = display.newSprite( M.enemySheet, { name="enemy", start=1, count=3, time=500, loopCount = 1 } )
		local enemyFate = math.random( 3 )
		if enemyFate == 1 then
			M.enemy.x = centerX - _W/3
		elseif enemyFate == 2 then
			M.enemy.x = centerX
		else
			M.enemy.x = centerX + _W/3
		end
		M.enemy.y = -_H
		M.enemy.mayKillYou = false
		transition.moveTo(M.enemy, { time=500, y=centerY - _H/2.4 } )
		Runtime:addEventListener( 'enterFrame', M.enemyMove )
	end

	function M.openEnemy( event )
		if M.enemy ~= nil and M.enemy.y ~= nil then
			if (math.round(M.enemy.y) == math.round(centerY - _H/2.4)) and (M.enemy.played ~= 1) then
				M.enemy:play()
				M.enemy.played = 1
				M.enemy.mayKillYou = true
			end
		end
	end

	function M.enemyDefeat( )
		M.enemy.x = -_W
		Runtime:removeEventListener( 'enterFrame', M.enemyMove )
		M.enemy = nil
		M.enemyHorizontalSpeed = nil
	end

	function M.enemyMove( event )
		local tDelta = event.time - tPrevious
		tPrevious = event.time	
		if M.enemyHorizontalSpeed == nil then
			local fateEnemy = math.random( 100 )
			if fateEnemy <= 50 then
				M.enemyHorizontalSpeed = -5
			else
				M.enemyHorizontalSpeed = 5
			end
		end
		if ((M.enemy.x - M.enemyHorizontalSpeed) > centerX - _W/3 ) and ( (M.enemy.x + M.enemyHorizontalSpeed) < centerX - _W/3) then
			M.enemyHorizontalSpeed = M.enemyHorizontalSpeed * -1
		elseif (((M.enemy.x - M.enemyHorizontalSpeed) < centerX + _W/3 ) and ( (M.enemy.x + M.enemyHorizontalSpeed) > centerX + _W/3)) then
			M.enemyHorizontalSpeed = M.enemyHorizontalSpeed * -1
		end
		M.enemy.x = M.enemy.x + M.enemyHorizontalSpeed
	end

return M