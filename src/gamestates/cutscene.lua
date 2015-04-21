local cutscene = {}

function cutscene:enter()
  self.data = currentlevel.cutscene
end

function cutscene:draw()
  if self.data then
    self.data:draw()
  end
end

function cutscene:update(dt)
  if love.keyboard.isDown("tab") then
    dt = dt * 8
  end
  if self.data then
    self.data:update(dt)
    hump.timer.update(dt)
    if self.data.done then
      hump.gamestate.switch(gamestates.game)
    end
    if bindings.getTrigger(bindings.select) then
      if self.data and self.data.audio then
        for i,v in pairs(self.data.audio) do
          v:stop()
        end
        self.data.cutscene_audio = {}
      end
      hump.gamestate.switch(gamestates.game)
    end
  else
    hump.gamestate.switch(gamestates.game)
  end
end

return cutscene
