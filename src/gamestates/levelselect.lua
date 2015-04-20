local levelselect = {}

function levelselect:init()
  self.levels = {
    sample = require "levels.sample",
    main  = require "levels.main",
  }
end

function levelselect:enter()

  local getnext = false
  for _,v in pairs(self.levels) do
    if getnext then
      currentlevel = v
    end
    if currentlevel == v then
      getnext = true
    end
    if not currentlevel then
      currentlevel = v
      break
    end
  end

  hump.gamestate.switch(gamestates.cutscene)
end

return levelselect
