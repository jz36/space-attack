local M = {}

function M.init()

	M.coinSheet = graphics.newImageSheet( 'img/spin_coin_big_upscale_strip6.png', { width=18, height=20, numFrames=6 } )

	M.tempY = 0

	M.coins = {}
	M.collecttedCoins = 0

	M.countCollectedCoins = display.newGroup()

	M.coin = display.newSprite( M.countCollectedCoins, M.coinSheet, { name="collectedCoin", start=1} )
	M.countCollectedCoins.x = centerX - _W/2.3
	M.countCollectedCoins.y = 0
	M.textX = display.newText( M.countCollectedCoins, 'x', centerX - _W/2.3, 0, 'font/SadMachine.ttf', 48 )
	M.textCoin = display.newText( M.countCollectedCoins, M.collecttedCoins, centerX - _W/4, 0, _W/4, _H/12	, 'font/SadMachine.ttf', 48, "left")

end

function M.createOneRowCoins( numberOfLenRow, row )
	M.tempY = (_H/6)*numberOfLenRow
	for i=1,numberOfLenRow do

		M.coins[i] = display.newSprite( M.coinSheet, { name="coin", start=1, count=6, time=500 } )
		M.coins[i].x = centerX + row
		M.coins[i].y = -32 - M.tempY
		M.coins[i]:play()
		M.tempY = M.tempY - (_H/6)
	end
	M.tempY = 0
	M.coins.len = numberOfLenRow
end

function M.createTwoRowCoins( numberOfLenRow, row1, row2 )
	M.tempY = (_H/6)*numberOfLenRow
	for i=1, numberOfLenRow*2 do
		if i % 2 == 0 then
			M.coins[i] = display.newSprite( M.coinSheet, { name="coin", start=1, count=6, time=500 } )
			M.coins[i].x = centerX + row1
			M.coins[i].y = -32 - M.tempY
			M.coins[i]:play()
			M.tempY = M.tempY - (_H/6)
		else
			M.coins[i] = display.newSprite( M.coinSheet, { name="coin", start=1, count=6, time=500 } )
			M.coins[i].x = centerX + row2
			M.coins[i].y = -32 - M.tempY
			M.coins[i]:play()
		end
	end
	M.coins.len = numberOfLenRow*2
	M.tempY = 0
end

function M.createThreeRowCoins( numberOfLenRow )
	M.tempY = (_H/6)*numberOfLenRow
	for i=1,numberOfLenRow*3 do
		if i % 3 == 0 then
			M.coins[i] = display.newSprite( M.coinSheet, { name="coin", start=1, count=6, time=500 } )
			M.coins[i].x = centerX - _W/3
			M.coins[i].y = -32 - M.tempY
			M.coins[i]:play()
			M.tempY = M.tempY - (_H/6)
		elseif i % 3 == 1 then
			M.coins[i] = display.newSprite( M.coinSheet, { name="coin", start=1, count=6, time=500 } )
			M.coins[i].x = centerX 
			M.coins[i].y = -32 - M.tempY
			M.coins[i]:play()
		else
			M.coins[i] = display.newSprite( M.coinSheet, { name="coin", start=1, count=6, time=500 } )
			M.coins[i].x = centerX + _W/3
			M.coins[i].y = -32 - M.tempY
			M.coins[i]:play()
			
		end
	end
	M.coins.len = numberOfLenRow*3
	M.tempY = 0
end

function M.createRandomRowCoins( )
	math.randomseed( os.time() )
	local fateCoins = math.random(7)
	local lenRow = math.random(10,25)
	local iStart = 0
	M.coins = {}
	M.coins.destroy = 0
	if fateCoins == 1 then
		M.createOneRowCoins( lenRow, 0 )
	elseif fateCoins == 2 then
		M.createOneRowCoins( lenRow, _W/3 )
	elseif fateCoins == 3 then
		M.createOneRowCoins( lenRow, -_W/3 )
	elseif fateCoins == 4 then
		M.createTwoRowCoins( lenRow, 0, -_W/3 )
	elseif fateCoins == 5 then
		M.createTwoRowCoins( lenRow, 0, _W/3 )
	elseif fateCoins == 6 then
		M.createTwoRowCoins( lenRow, _W/3, -_W/3 )
	elseif fateCoins == 7 then
		M.createThreeRowCoins( lenRow )
	end
end

function M.moveCoins( event )
	local tDelta = event.time - tPrevious
	tPrevious = event.time
	M.coinsSpeed = GameSpeed
	if M.coins.destroy == M.coins.len then
		
	else
		for i=1,#M.coins do
			M.coins[i].y = M.coins[i].y + M.coinsSpeed
			if M.coins[i].y < _H +60 then
				if M.coins[i].y > _H + 40 then
					M.coins[i].y = _H + 60
					M.coins.destroy = M.coins.destroy + 1
				end
			end
			if ( math.round( spritePlayerShip.x ) == math.round( M.coins[i].x ) ) and ( ( spritePlayerShip.y + 40 > M.coins[i].y ) and ( spritePlayerShip.y - 40 < M.coins[i].y ) ) then
				M.coins[i].y = _H + 200
				M.coins.destroy = M.coins.destroy + 1
				M.collecttedCoins = M.collecttedCoins + 1
				display.remove(M.textCoin)
				M.textCoin = display.newText( M.countCollectedCoins, M.collecttedCoins, centerX - _W/4, 0, _W/4, _H/12	, 'font/SadMachine.ttf', 48, "left")
			end
		end 
	end
end

function M.addEventListenerForCoins()
	Runtime:addEventListener( 'enterFrame', M.moveCoins )
end

return M