bubbleclass = require "bubble.bubbleclass"

fonts = {
  speechbubble = love.graphics.newFont("assets/Schoolbell.ttf",32)
}

love.graphics.setFont(fonts.speechbubble)

dir = "bubble/good/"

b = bubbleclass.new({
  imgTop = love.graphics.newImage(dir.."top.png"),
  imgTopRight = love.graphics.newImage(dir.."top_right.png"),
  imgRight = love.graphics.newImage(dir.."right.png"),
  imgBottomRight = love.graphics.newImage(dir.."bottom_right.png"),
  imgBottom = love.graphics.newImage(dir.."bottom.png"),
  imgBottomLeft = love.graphics.newImage(dir.."bottom_left.png"),
  imgLeft = love.graphics.newImage(dir.."left.png"),
  imgTopLeft = love.graphics.newImage(dir.."top_left.png"),
  imgInside = love.graphics.newImage(dir.."inside.png"),
  imgTail = love.graphics.newImage(dir.."tail.png"),
})

b:setFontColor({0,0,0})

local cutsceneclass = require "cutscene.cutsceneclass"
local cutscenethingclass = require "cutscene.cutscenethingclass"

cut = cutsceneclass.new()

bg = cutscenethingclass.new({
  zindex = -1,
  image = love.graphics.newImage("cutscene/bg.png"),
  update = function(self,dt)
    local color = self:getColor()
    color[4] = math.min( (color[4] or 0) + dt*255, 255 )
  end
})
cut:addThing({time=1,data=bg})

dino = cutscenethingclass.new({
  image = love.graphics.newImage("cutscene/stand.png"),
  x = 300,
  y = 100,
  draw = function(self)
    love.graphics.draw(self:getImage(),self:getX(),self:getY())
    if self._text then
      local bx = self:getX() + (self:getImage():getWidth() - 300)/2
      b:draw(self._text,bx,self:getY(),300,"right")
    end
  end
})
cut:addThing({time=1,data=dino})

hello = cutscenethingclass.new({
  init = function(self)
    dino._text =  "Hello. I am the dino bro."
  end
})
cut:addThing({time=1,data=hello})

cut:addThing({
  time=3,
  data= cutscenethingclass.new({
    init = function(self)
      dino._text =  "Now fuck off."
    end,
    update = function(self,dt)
      dino:setX( dino:getX() + math.random(-10,10) )
      dino:setY( dino:getY() + math.random(-10,10) )
    end,
  })
})

cut:addThing({
  time=0.5,
  data=cutscenethingclass.new({
    init = function(self)
      love.event.quit()
    end,
  }),
})

function love.draw()
  cut:draw()
end

function love.update(dt)
  cut:update(dt)
end
