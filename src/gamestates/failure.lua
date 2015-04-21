local failure = {}

function failure:init()
  self.bg = love.graphics.newImage("assets/failure.png")
end

function failure:draw()
  love.graphics.draw(self.bg)
end

function failure:update(dt)
  if bindings.getTrigger(bindings.select) then
    gamestates.levelselect.cur=0
    hump.gamestate.switch(gamestates.menu)
  end
end

return failure
