local menu = {}

function menu:init()
  self.bg = love.graphics.newImage("assets/menu.png")
  self.music = love.audio.newSource("assets/menu.ogg","stream")
  self.music:setLooping(true)
end

function menu:enter()
  self.music:play()
end

function menu:leave()
  self.music:stop()
end

function menu:draw()
  love.graphics.draw(self.bg)
end

function menu:update(dt)
  if bindings.getTrigger(bindings.select) then
    hump.gamestate.switch(gamestates.levelselect)
  end
end


return menu
