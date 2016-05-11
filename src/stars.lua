local M = {}

function M.moveStars( event )
	local tDelta = event.time - tPrevious
	tPrevious = event.time
	for i=1,45 do 
		starsArrayOne[i].y = starsArrayOne[i].y + starsArrayOne[i].speed 
		if starsArrayOne[i].y > _H + 64 then
			starsArrayOne[i].x = math.random( _W )
			starsArrayOne[i].y = -math.random( 32, 64 )
			starsArrayOne[i].speed = math.random(10)
			starsArrayOne[i].alpha = math.random(100)*0.01
			starsArrayOne[i].rotation = math.random(90)
		end
	end
end

return M
