local colors = {
	["#"] = { 255, 255, 255 }, --Wall
	["."] = { 25, 25, 25 }, --FloorTile
	["+"] = { 0, 255, 0 }, --HealthPack
	["%"] = { 150, 150, 150 }, --Potential Trap
	[","] = { 25, 25, 25 }, --Trap
}

--used for storing world info
world = {

}

--used for global functions
map = {
	genRoom = function( dir, x, y, w, h, type )
		local w = w
		if not w then
			repeat
				w = love.math.random(9, 15)
			until w%2 == 1
		end
		local h = h
		if not h then
			repeat
				h = love.math.random(5, 15)
			until h%2 == 1
		end
		local doors = love.math.random(1,2)
		if dir == "closed" then
			world[y-(2+h)] = world[y-(2+h)] or {}
			world[y-2] = world[y-2] or {}
			
			for i = x-math.floor(w/2), x+math.floor(w/2) do
				world[y-2][i] = "#"
				world[y-(2+h)][i] = "#"
			end
			for i = y-3, y-1-h, -1 do
				world[i] = world[i] or {}
				world[i][x-math.floor(w/2)] = "#"
				world[i][x+math.floor(w/2)] = "#"
				for v = x-math.floor((w-2)/2), x+math.floor((w-2)/2) do
					world[i][v] = "."
				end
			end
			
			
			local dirs = {
				[1] = "up",
				[2] = "left",
				[3] = "right",
			}
			for i = 1, doors do
				local num = love.math.random(1,#dirs)
				side = dirs[num]
				table.remove(dirs, num)
				local _x, _y
				if side == "left" then
					_y = love.math.random(y-3, y-1-h)
					world[_y] = world[_y] or {}
					world[_y][x-math.floor(w/2)] = "|"
				elseif side == "right" then
					_y = love.math.random(y-3, y-1-h)
					world[_y] = world[_y] or {}
					world[_y][x+math.floor(w/2)] = "|"
				elseif side == "up" then
					local x = love.math.random(x-math.floor(w/2)+1,x+math.floor(w/2)-1)
					world[y-(2+h)][x] = "-"
				end
			end
		elseif dir == "up" then
			world[y-1] = world[y-1] or {}
			world[y-1][x-1] = "#"
			world[y-1][x] = "."
			world[y-1][x+1] = "#"
			world[y-(2+h)] = world[y-(2+h)] or {}
			world[y-2] = world[y-2] or {}
			local dirs = {
				[1] = "up",
				[2] = "left",
				[3] = "right",
			}
			for i = 1, doors do
				local num = love.math.random(1,#dirs)
				side = dirs[num]
				table.remove(dirs, num)
				local _x, _y
				if side == "left" then
					_y = love.math.random(y-3, y-1-h)
					world[_y] = world[_y] or {}
					world[_y][x-math.floor(w/2)] = "|"
				elseif side == "right" then
					_y = love.math.random(y-3, y-1-h)
					world[_y] = world[_y] or {}
					world[_y][x+math.floor(w/2)] = "|"
				elseif side == "up" then
					local x = love.math.random(x-math.floor(w/2)+1,x+math.floor(w/2)-1)
					world[y-(2+h)][x] = "-"
				end
			end
			for i = x-math.floor(w/2), x+math.floor(w/2) do
				world[y-2][i] = world[y-2][i] or "#"
				world[y-(2+h)][i] = world[y-(2+h)][i] or "#"
			end
			for i = y-3, y-1-h, -1 do
				world[i] = world[i] or {}
				world[i][x-math.floor(w/2)] = world[i][x-math.floor(w/2)] or "#"
				world[i][x+math.floor(w/2)] = world[i][x+math.floor(w/2)] or "#"
				for v = x-math.floor((w-2)/2), x+math.floor((w-2)/2) do
					world[i][v] = world[i][v] or "."
				end
			end
			
			world[y-2][x] = "."
		elseif dir == "left" then
			world[x-1] = world[x-1] or {}
			world[y-1][x-1] = "#"
			world[y][x-1] = "."
			world[y+1][x-1] = "#"
			world[y+(2-h)] = world[y+(2-h)] or {}
			world[y+2] = world[y+2] or {}
			
			world[y-math.floor(h/2)] = world[y-math.floor(h/2)] or {}
			world[y+math.floor(h/2)] = world[y+math.floor(h/2)] or {}
			for i = y-math.floor(h/2), y+math.floor(h/2) do
				world[i] = world[i] or {}
				world[i][x-w-2] = "#"
				world[i][x-2] = "#"
				for v = x-w-1, x-3 do
					world[i][v] = "."
				end
			end
			
			for i = x-2, x-w-2, -1 do
				world[y-math.floor(h/2)][i] = "#"
				world[y+math.floor(h/2)][i] = "#"
			end
			
			world[y][x-2] = "."
			local dirs = {
				[1] = "up",
				[2] = "left",
			}
			for i = 1, doors do
				local num = love.math.random(1,#dirs)
				side = dirs[num]
				table.remove(dirs, num)
				if side == "left" then
					world[love.math.random(y-math.floor(h/2)+1, y+math.floor(h/2)-1)][x-w-2] = "|"
				elseif side == "up" then
					local x = love.math.random(x-3, x-w-2)
					world[y-math.floor(h/2)][x] = "-"
				end
			end
		elseif dir == "right" then
			world[x+1] = world[x+1] or {}
			world[y+1][x+1] = "#"
			world[y][x+1] = "."
			world[y-1][x+1] = "#"
			world[y-(2+h)] = world[y-(2+h)] or {}
			world[y-2] = world[y-2] or {}
			
			world[y+math.floor(h/2)] = world[y+math.floor(h/2)] or {}
			world[y-math.floor(h/2)] = world[y-math.floor(h/2)] or {}
			for i = y-math.floor(h/2), y+math.floor(h/2) do
				world[i] = world[i] or {}
				world[i][x+w+2] = "#"
				world[i][x+2] = "#"
				for v = x+3,x+w+1 do
					world[i][v] = "."
				end
			end
			
			for i = x+2, x+w+2 do
				world[y+math.floor(h/2)][i] = "#"
				world[y-math.floor(h/2)][i] = "#"
			end
			
			world[y][x+2] = "."
		end
	end,
	draw = function()
		for y,v in pairs( world ) do
			for x, char in pairs( v ) do
				love.graphics.setColor(colors[char] or {255, 255, 255})
				if AdvGraphics and (char == "#" or char == ".") then
					love.graphics.rectangle("fill",x*SingleCharW, y*SingleCharH, SingleCharW, SingleCharH)
				else
					love.graphics.print( char, x*SingleCharW, y*SingleCharH )
				end
			end
		end
	end
}