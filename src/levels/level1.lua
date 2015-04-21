local level = {}

level.game = function(self)
  -- KING
  local e = entityclass.new({
    world = self.world,
    direction = -1,
    eClass = "bread",
    health = 100,
    maxHealth = 100,
    ai = self.king_bread_ai,
    speed = 100,
    hat = entityclass.hats.special.crown,
  })
  table.insert(self.entities,e)
  self.world:add(e,love.graphics.getWidth()*1/2,500,300,40)
end

level.cutscene = cutsceneclass.new()
local sub = subtitleclass.new()

level.cutscene.audio = {}

level.cutscene:addThing({
  time=0,
  lifespan=5,
  data = cutscenethingclass.new({
    zindex=-10,
    image = love.graphics.newImage("assets/dinotopia.png"),
    init = function(self)
      hump.timer.tween(5,self, {_sx=1.2,_sy=1.2,_x=-1000/2,_y=-580/2,_r=-0.2},'linear')
    end,
  })
})

level.cutscene:addThing({
  time = 0,
  lifespan = 5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_1.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("A Long time ago there was a planet called dinotopia...")
    end,
  })
})

level.cutscene:addThing({
  time = 5,
  data = cutscenethingclass.new({
    zindex = -10,
    image = love.graphics.newImage("cutscene/bg.png"),
    update = function(self,dt)
      local color = self:getColor()
      color[4] = math.min( (color[4] or 0) + dt*255, 255 )
    end
  })
})

level.cutscene:addThing({
  time = 1,
  lifespan = 3,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_2.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("And on this planet, there was a dinosaur.")
    end
  })
})

local dino_bro = cutscenethingclass.new({
  image = love.graphics.newImage("cutscene/stand.png"),
  x = love.graphics.getWidth(),
  y = 100,
  zindex=-5,
  init = function(self)
    hump.timer.tween(2, self, {_x = 300} , 'out-back')
  end,
})
level.cutscene:addThing({time=1,data=dino_bro})

level.cutscene:addThing({
  time=3,
  lifespan=2,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_3.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("The Dino Bro.")
    end
  })
})

level.cutscene:addThing({
  time=3,
  lifespan=2,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_4.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Dino Bro: Where all the dino-hos at?")
    end
  })
})

level.cutscene:addThing({
  time=3,
  lifespan=4,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_5.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("He lived a life one would expect of a dinosaur.")
    end
  })
})

level.cutscene:addThing({
  time=4,
  lifespan=3.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_6.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Dino Bro: Bro everyday, bro! I'm six deep!")
    end
  })
})

level.cutscene:addThing({
  time=4,
  lifespan=11.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_7.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("One day, as Dino Bro was swaggering through the prehistoric forest thinking about all the hot bangin' dino-ladies, he came upon a sandwich.")
    end
  })
})

level.cutscene:addThing({
  time = 10,
  lifespan = 0,
  data = cutscenethingclass.new({
    init = function(self)
      dino_bro:setImage( love.graphics.newImage("cutscene/eating.png") )
    end
  })
})

level.cutscene:addThing({
  time=3,
  lifespan=4.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_8.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Dino Bro: It's Bro-Tien time! *Manf Manf Manf*")
    end
  })
})

level.cutscene:addThing({
  time = 0,
  lifespan = 0,
  data = cutscenethingclass.new({
    init = function(self)
      hump.timer.tween(2, dino_bro, {_x = -1200} , 'out-back')
    end
  })
})

level.cutscene:addThing({
  time = 5,
  lifespan = 7,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_9.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("The Dino Bro was not a fan of crusts, so he threw them to the ground for the birds.")
    end,
  })
})

local king = cutscenethingclass.new({
  time = 2,
  image = love.graphics.newImage("cutscene/king_sad.png"),
  x = love.graphics.getWidth(),
  y = 100,
  zindex=-5,
  init = function(self)
    hump.timer.tween(2, self, {_x = 300} , 'out-back')
  end,
})
level.cutscene:addThing({time=4,data=king})

level.cutscene:addThing({
  time = 3,
  lifespan = 7,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_10.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("The Bread King happened upon the remains of the sandwich which was the princess, his daughter.")
    end,
  })
})

level.cutscene:addThing({
  time = 7,
  lifespan = 7,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_11.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("He vowed revenge on the Dino Bro, as no other dinosaur would leave just the crusts.")
    end,
  })
})

level.cutscene:addThing({
  time = 7,
  lifespan = 3.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level1_12.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Bread King: I shall exact my vengance on you, Dino Bro!")
    end,
  })
})

level.cutscene:addThing({
  time = 4.5,
  lifespan = 3,
  data = cutscenethingclass.new({
    init = function(self)
      level.cutscene.done = true
    end,
  })
})

return level
