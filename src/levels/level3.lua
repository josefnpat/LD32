local level = {}

level.game = function(self)
end

level.cutscene = cutsceneclass.new()
local sub = subtitleclass.new()

level.cutscene.audio = {}

level.cutscene:addThing({
  time = 0,
  data = cutscenethingclass.new({
    zindex = -10,
    image = love.graphics.newImage("cutscene/bros.png"),
    update = function(self,dt)
      local color = self:getColor()
      color[4] = math.min( (color[4] or 0) + dt*255, 255 )
    end
  })
})

level.cutscene:addThing({
  time = 1,
  lifespan = 7,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level3_1.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("With the Bread King and his bread army defeated, Dino Bro returns to his normal daily life.")
    end
  })
})

local dino = cutscenethingclass.new({
  time = 1,
  image = love.graphics.newImage("cutscene/stand.png"),
  x = love.graphics.getWidth(),
  y = 100,
  zindex=-5,
  lifespan = 5,
  time=1,
  init = function(self)
    hump.timer.tween(2, self, {_x = 50} , 'out-back')
  end,
})
level.cutscene:addThing({time=0,data=dino})

level.cutscene:addThing({
  time = 8,
  lifespan = 1.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level3_2.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Dino Bro: Bro")
    end
  })
})

level.cutscene:addThing({
  time = 2,
  lifespan = 1.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level3_3.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Bro of Dino Bro: Bro")
    end
  })
})

level.cutscene:addThing({
  time = 2,
  lifespan = 1.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level3_4.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Bro of Bro of Dino Bro: Bro")
    end
  })
})

level.cutscene:addThing({
  time = 2,
  lifespan = 1.5,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level3_5.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("Dino Bro: Bro")
    end
  })
})


level.cutscene:addThing({
  time = 2,
  lifespan = 7,
  data = cutscenethingclass.new({
    init = function(self)
      local s = love.audio.newSource("cutscene/level3_6.ogg")
      s:play()
      table.insert(level.cutscene.audio,s)
    end,
    draw = function(self)
      sub:draw("And he lived happily every after, eating tasty sandwiches every day for the rest of his life.")
    end
  })
})

level.cutscene:addThing({
  time = 9,
  lifespan = 3,
  data = cutscenethingclass.new({
    init = function(self)
      hump.gamestate.switch(gamestates.menu)
    end,
  })
})

return level
