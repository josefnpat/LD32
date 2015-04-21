local level = {}

level.game = function(self)
  for i = 1,99 do
    local e = entityclass.new({
      world = self.world,
      direction = -1,
      eClass = "bread",
      health = 1,
      ai = self.bread_ai,
      speed = math.random(90,110),
      delay=math.max(i-5),
    })
    table.insert(self.entities,e)
    self.world:add(e,
      -1500 + math.random(0,1)*(love.graphics.getWidth()+3000),
      math.random(350,650),math.random(80,200),
      40)
  end

  -- KING
  local e = entityclass.new({
    world = self.world,
    direction = -1,
    eClass = "bread",
    health = 10,
    maxHealth = 100,
    ai = self.bread_ai,
    speed = 100,
    delay = 100,
    hat = entityclass.hats.special.crown,
  })
  table.insert(self.entities,e)
  self.world:add(e,love.graphics.getWidth()*3/4,3000,300,40)
end

level.cutscene = cutsceneclass.new()
local sub = subtitleclass.new()

level.cutscene.audio = {}

level.cutscene:addThing({
  time = 0,
  data = cutscenethingclass.new({
    zindex = -10,
    image = love.graphics.newImage("cutscene/bg.png"),
    update = function(self,dt)
      local color = self:getColor()
      color[4] = math.min( (color[4] or 0) + dt*255, 255 )
    end
  })
})

local dino_bro = cutscenethingclass.new({
  image = love.graphics.newImage("cutscene/stand.png"),
  x = love.graphics.getWidth(),
  y = 100,
  zindex=-5,
  lifespan = 5,
  time=1,
  init = function(self)
    hump.timer.tween(2, self, {_x = 550} , 'out-back')
  end,
})
level.cutscene:addThing({time=0,data=dino_bro})

level.cutscene:addThing({
  time = 1,
  lifespan = 5.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level2_1.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Dino Bro was lucky that day, as he had his oversized butter knife.")
    end
  })
})

level.cutscene:addThing({
  time = 6.5,
  lifespan = 2.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level2_2.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Dino Bro: I was using it to open beers!")
    end
  })
})

local king_cs = cutscenethingclass.new({
  image = love.graphics.newImage("cutscene/king_angry.png"),
  x = -400,
  y = 100,
  zindex=-5,
  lifespan = 5,
  time=3,
  init = function(self)
    hump.timer.tween(2, self, {_x = 50} , 'out-back')
  end,
})
level.cutscene:addThing({time=3,data=king_cs})

level.cutscene:addThing({
  time = 3,
  lifespan = 8,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level2_3.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("The Bread King, his ego wounded by his previous encounter with Dino Bro, called his army to defeat him.")
    end
  })
})

level.cutscene:addThing({
  time = 8.5,
  lifespan = 3,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level2_4.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Dino Bro: Time to Bro Down!")
    end
  })
})

level.cutscene:addThing({
  time = 3.5,
  lifespan = 3,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level2_5.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("And Bro Down he did.")
    end
  })
})

level.cutscene:addThing({
  time = 3.5,
  lifespan = 3,
  data = cutscenethingclass.new({
    init = function(self)
      level.cutscene.done = true
    end,
  })
})

return level
