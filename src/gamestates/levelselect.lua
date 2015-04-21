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
  if self.cur > #self.levels then
    self.cur = 1
  end
  currentlevel = self.levels[self.cur]

  hump.gamestate.switch(gamestates.cutscene)
end

return levelselect
