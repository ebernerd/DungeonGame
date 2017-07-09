GameFont = love.graphics.newFont( "fonts/emulogic.ttf", 30 )
Window = {
	w = love.graphics.getWidth(),
	h = love.graphics.getHeight(),
}

AdvGraphics = false

SingleCharW = GameFont:getWidth(" ")
SingleCharH = GameFont:getHeight()

require "camera"
require "player"
require "objects"
require "map"

function love.load()
	love.keyboard.setKeyRepeat( true )
	love.graphics.setFont( GameFont )
	map.genRoom("closed", 0, 5, nil, nil, "")

	camera.x = player.x*SingleCharW - love.graphics.getWidth()/2
	camera.y = player.y*SingleCharH - love.graphics.getHeight()/2
end

function love.update( dt )

end

function love.draw()
	camera:set()
	
		map.draw()
		player.draw()

	camera:unset()
	love.graphics.setColor( 0, 0, 0 )
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), SingleCharH*2)
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-", -SingleCharW/4, SingleCharH)
	love.graphics.print("HP[          ]")
	love.graphics.setColor( 255, 255, 0 )
	love.graphics.print(string.rep("#",math.floor(player.hp/10)), 3*SingleCharW, 0)
	local fps = love.timer.getFPS()
	love.graphics.printf(fps, 0, 0, love.graphics.getWidth(), "right")
end

function love.keypressed( key )
	if key == "escape" then
		love.event.quit()
	elseif key == "space" then
		AdvGraphics = not AdvGraphics
	end
	player.keypressed( key )
end