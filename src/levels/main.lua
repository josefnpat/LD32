local level = {}

level.game = function(self)
  for i = 1,10 do
    local e = entityclass.new({
      world = self.world,
      direction = -1,
      eClass = "bread",
      health = 2,
      maxHealth = 2,
      ai = self.bread_ai,
      speed = 100,
    })
    table.insert(self.entities,e)
    self.world:add(e,love.graphics.getWidth()+math.random(0,100),math.random(400,600),math.random(10,100),40)
  end
end

level.cutscene = cutsceneclass.new()

level.cutscene:addThing({
  time = 0,
  data = cutscenethingclass.new({
    init = function(self)
      level.cutscene.done = true
    end,
  }),
})

return level
