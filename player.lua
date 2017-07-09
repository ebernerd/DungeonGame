player = {
	x = 0,
	y = 0,
	w = SingleCharW,
	h = SingleCharW,
	symbol = "^",
	hp = 50,
}

function player.draw()
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.rectangle("fill",player.x*SingleCharW, player.y*SingleCharH, SingleCharW, SingleCharH)
	love.graphics.setColor( 0, 0, 0 )
	love.graphics.print("@", (player.x*SingleCharW)-2, player.y*SingleCharH)
end

function player.keypressed( key )
	if key == "w" then
		if world[player.y-1] then
			if world[player.y-1][player.x] == "#" then
				return
			elseif world[player.y-1][player.x] == "-" then
				map.genRoom("up", player.x, player.y)
			end
		end
		
		player.y = player.y - 1
		player.symbol = "^"
	elseif key == "s" then
		if world[player.y+1] then
			if world[player.y+1][player.x] == "#" then
				return
			elseif world[player.y+1][player.x] == "|" then
				map.genRoom("down", player.x, player.y )
			end
		end
		
		player.y = player.y + 1
		player.symbol = "v"
	elseif key == "a" then
		if world[player.y] then
			if world[player.y][player.x-1] == "#" then
				return
			elseif world[player.y][player.x-1] == "|" then
				map.genRoom("left", player.x, player.y )
			end
		end
		
		player.x = player.x - 1
		player.symbol = "<"
	elseif key == "d" then
		if world[player.y] then
			if world[player.y][player.x+1] == "#" then
				return
			elseif world[player.y][player.x+1] == "|" then
				map.genRoom("right", player.x, player.y)
			end
		end
		
		player.x = player.x + 1
		player.symbol = ">"
	end
	
	camera.x = player.x*SingleCharW - love.graphics.getWidth()/2
	camera.y = player.y*SingleCharH - love.graphics.getHeight()/2
end