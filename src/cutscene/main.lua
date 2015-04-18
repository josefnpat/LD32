
local cutsceneclass = require "cutsceneclass"
local cutscenethingclass = require "cutscenethingclass"

cut = cutsceneclass.new()

bg = cutscenethingclass.new({
  image = love.graphics.newImage("bg.png")
})

cut:addThing({time=0,data=bg})

dino = cutscenethingclass.new({
  zindex = 1,
  alpha = 0,
  image = love.graphics.newImage("stand.png"),
  update = function(self,dt)
    local color = self:getColor()
    color[4] = math.min((color[4] or 0) + dt*255,255)
    self:setColor(color)
  end,
})

cut:addThing({time=1,data=dino})

function love.draw()
  cut:draw()
end

function love.update(dt)
  cut:update(dt)
end
