subtitleclass = require "subtitleclass"

s = subtitleclass.new()

function love.update(dt)
  s:update(dt)
end

function love.draw()
  love.graphics.setColor(126,126,12)
  love.graphics.rectangle("fill",0,0,10000,10000)
  love.graphics.setColor(255,255,255)
  s:draw("And so the story goes ....")
end
