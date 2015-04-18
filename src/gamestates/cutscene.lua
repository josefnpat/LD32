local cutscene = {}

function cutscene:enter()
  self.data = currentlevel.cutscene
end

function cutscene:draw()
  self.data:draw()
end

function cutscene:update(dt)
  self.data:update(dt)
  hump.timer.update(dt)
end

return cutscene
