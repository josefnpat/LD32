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
  if self.data.done then
    hump.gamestate.switch(gamestates.game)
  end
  if bindings.getTrigger(bindings.select) then
    for i,v in pairs(self.data.audio) do
      v:stop()
    end
    self.data.cutscene_audio = {}
    hump.gamestate.switch(gamestates.game)
  end
end

return cutscene
