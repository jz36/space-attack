local M = {}

local tPrevious = system.getTimer()
local math = require('math')

function M.init()
	M.starsGroup = display.newGroup( )

	M.starsArrayOne = {}

	for i=1,45 do
		M.starsArrayOne[i] = display.newImage( M.starsGroup, 'img/stars/'..math.random(3)..math.random(6)..'.png', math.random( _W  ), math.random( _H ) )
		M.starsArrayOne[i].speed = math.random(6)
		M.starsArrayOne[i].alpha = math.random(30, 80)*0.01
		M.starsArrayOne[i].rotation = math.random(90)
	end

	function M.moveStars( event )
		local tDelta = event.time - system.getTimer()
		tPrevious = event.time
		for i=1,45 do 
			M.starsArrayOne[i].y = M.starsArrayOne[i].y + M.starsArrayOne[i].speed 
			if M.starsArrayOne[i].y > _H + 64 then
				M.starsArrayOne[i].x = math.random( _W )
				M.starsArrayOne[i].y = -math.random( 32, 64 )
				M.starsArrayOne[i].speed = math.random(10)
				M.starsArrayOne[i].alpha = math.random(30, 80)*0.01
				M.starsArrayOne[i].rotation = math.random(90)
			end
		end
	end

	Runtime:addEventListener( 'enterFrame', M.moveStars )

end

return M