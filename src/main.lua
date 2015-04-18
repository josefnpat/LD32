local hump = {
  camera = require "hump.camera",
  gamestate = require "hump.gamestate",
  timer = require "hump.timer",
}
bubbleclass = require "bubble.bubbleclass"
subtitleclass = require "subtitle.subtitleclass"

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

sub = subtitleclass.new()

cut:addThing({
  time=0,
  lifespan=5,
  data = cutscenethingclass.new({
    image = love.graphics.newImage("assets/dinotopia.png"),
    init = function(self)
      hump.timer.tween(5,self, {_sx=1.2,_sy=1.2,_x=-1000/2,_y=-580/2,_r=-0.2},'linear')
      local s1 = love.audio.newSource("assets/sample_1.ogg")
      s1:play()
    end,
    draw = function(self)
      cutscenethingclass._defaultDraw(self)
      sub:draw("Once upon a time in a land called dinotopia ...")
    end,
  })
})

cut:addThing({
  time=5,
  data = cutscenethingclass.new({
    zindex = -1,
    image = love.graphics.newImage("cutscene/bg.png"),
    update = function(self,dt)
      local color = self:getColor()
      color[4] = math.min( (color[4] or 0) + dt*255, 255 )
    end
  })
})

dino = cutscenethingclass.new({
  image = love.graphics.newImage("cutscene/stand.png"),
  x = love.graphics.getWidth(),
  y = 100,
  init = function(self)
    hump.timer.tween(2, self, {_x = 300} , 'out-back')
    local s1 = love.audio.newSource("assets/sample_2.ogg")
    s1:play()
  end,
  draw = function(self)
    love.graphics.draw(self:getImage(),self:getX(),self:getY())
    if self._text then
      local bx = self:getX() + (self:getImage():getWidth() - 300)/2
      b:draw(self._text,bx,self:getY(),300,"right")
    end
    if self._subtitle then
      sub:draw(self._subtitle)
    end
  end
})
dino._subtitle = "There was a dino bro."
cut:addThing({time=2,data=dino})

cut:addThing({
  time=2,
  data = cutscenethingclass.new({
    init = function(self)
      dino._subtitle = nil
      dino._text =  "Hello. I am the dino bro."
      local s1 = love.audio.newSource("assets/sample_3.ogg")
      s1:play()
    end
  })
})

cut:addThing({
  time=3,
  data = cutscenethingclass.new({
    init = function(self)
      dino._subtitle = "But he doesn't like you much."
      dino._text = nil
      local s1 = love.audio.newSource("assets/sample_4.ogg")
      s1:play()
    end
  })
})

cut:addThing({
  time=2,
  data= cutscenethingclass.new({
    init = function(self)
      dino._subtitle = nil
      dino._text =  "Now fuck off."
      local s1 = love.audio.newSource("assets/sample_5.ogg")
      s1:play()
    end,
    update = function(self,dt)
      dino:setX( dino:getX() + math.random(-10,10) )
      dino:setY( dino:getY() + math.random(-10,10) )
    end,
  })
})

cut:addThing({
  time=2,
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
  hump.timer.update(dt)
end
