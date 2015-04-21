local levelselect = {}

function levelselect:init()
  self.levels = {
    require "levels.level1",
    require "levels.level2",
    require "levels.level3",
  }
end

function levelselect:enter()

  if not self.cur then
    self.cur = 0
  end
  self.cur = self.cur + 1
  currentlevel = self.levels[self.cur]
  if self.cur > #self.levels then
    self.cur = 0
    hump.gamestate.switch(gamestates.menu)
  else
    hump.gamestate.switch(gamestates.cutscene)
  end

end

return levelselect
