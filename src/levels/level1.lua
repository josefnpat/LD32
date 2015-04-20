local level = {}

level.game = function(self)
  for i = 1,1 do
    local e = entityclass.new({
      world = self.world,
      direction = -1,
      eClass = "bread",
      health = 200,
      maxHealth = 200,
      ai = self.dumb_bread_ai,
      speed = 100,
      hat = entityclass.hats.special.crown,
    })
    table.insert(self.entities,e)
    self.world:add(e,love.graphics.getWidth()+math.random(0,100),math.random(400,600),math.random(300),40)
  end
end

level.cutscene = cutsceneclass.new()
local sub = subtitleclass.new()

level.cutscene.audio = {}

level.cutscene:addThing({
  time=0,
  lifespan=5,
  data = cutscenethingclass.new({
    image = love.graphics.newImage("assets/dinotopia.png"),
    init = function(self)
      hump.timer.tween(5,self, {_sx=1.2,_sy=1.2,_x=-1000/2,_y=-580/2,_r=-0.2},'linear')
      local s1 = love.audio.newSource("assets/sample_1.ogg")
      s1:play()
      table.insert(level.cutscene.audio,s1)
    end,
    draw = function(self)
      cutscenethingclass._defaultDraw(self)
      sub:draw("Once upon a time in a land called dinotopia ...")
    end,
  })
})

level.cutscene:addThing({
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
    table.insert(level.cutscene.audio,s1)
  end,
  draw = function(self)
    love.graphics.draw(self:getImage(),self:getX(),self:getY())
    if self._text then
      local bx = self:getX() + (self:getImage():getWidth() - 300)/2
      bubble:draw(self._text,bx,self:getY(),300,"right")
    end
    if self._subtitle then
      sub:draw(self._subtitle)
    end
  end
})
dino._subtitle = "There was a dino bro."
level.cutscene:addThing({time=2,data=dino})

level.cutscene:addThing({
  time=2,
  data = cutscenethingclass.new({
    init = function(self)
      dino._subtitle = nil
      dino._text =  "Hello. I am the dino bro."
      local s1 = love.audio.newSource("assets/sample_3.ogg")
      s1:play()
      table.insert(level.cutscene.audio,s1)
    end
  })
})

level.cutscene:addThing({
  time=3,
  data = cutscenethingclass.new({
    init = function(self)
      dino._subtitle = "But he doesn't like you much."
      dino._text = nil
      local s1 = love.audio.newSource("assets/sample_4.ogg")
      s1:play()
      table.insert(level.cutscene.audio,s1)
    end
  })
})

level.cutscene:addThing({
  time=2,
  data= cutscenethingclass.new({
    init = function(self)
      dino._subtitle = nil
      dino._text =  "Now fuck off."
      local s1 = love.audio.newSource("assets/sample_5.ogg")
      s1:play()
      table.insert(level.cutscene.audio,s1)
    end,
    update = function(self,dt)
      dino:setX( dino:getX() + math.random(-10,10) )
      dino:setY( dino:getY() + math.random(-10,10) )
    end,
  })
})

level.cutscene:addThing({
  time=2,
  data=cutscenethingclass.new({
    init = function(self)
      level.cutscene.done = true
    end,
  }),
})

return level
