local asteroid = require( 'asteroid' )
local M = {}

M.count = {}

function M.createOneAsteroid( row, height )
	local currentAsteroid = asteroid.create( row, height )
	table.insert( M.count, currentAsteroid )
end

function M.createTwoAsteroids( row1, row2, height )
	local currentAsteroids = {}
	currentAsteroids[1] = asteroid.create( row1, height )
	currentAsteroids[2] = asteroid.create( row2, height )
	table.insert( M.count, currentAsteroids[1] )
	table.insert( M.count, currentAsteroids[2] )
end

return M