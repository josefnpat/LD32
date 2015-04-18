hump = {
  camera = require "hump.camera",
  gamestate = require "hump.gamestate",
  timer = require "hump.timer",
}
bubbleclass = require "bubble.bubbleclass"
subtitleclass = require "subtitle.subtitleclass"

splashclass = require "splashclass"

bump = require "bump"

fonts = {
  speechbubble = love.graphics.newFont("assets/Schoolbell.ttf",32)
}

bindings = require "bindings"

love.graphics.setFont(fonts.speechbubble)

dir = "bubble/good/"
bubble = bubbleclass.new({
  imgTop = love.graphics.newImage(dir.."top.png"),
  imgTopRight = love.graphics.newImage(dir.."top_right.png"),
  imgRight = love.graphics.newImage(dir.."right.png"),
  imgBottomRight = love.graphics.newImage(dir.."bottom_right.png"),
  imgBottom = love.graphics.newImage(dir.."bottom.png"),
  imgBottomLeft = love.graphics.newImage(dir.."bottom_left.png"),
  imgLeft = love.graphics.newImage(dir.."left.png"),
  imgTopLeft = love.graphics.newImage(dir.."top_left.png"),
  imgInside = love.graphics.newImage(dir.."inside.png"),
  imgTail = love.graphics.newImage(dir.."tail.png"),
  fontColor={0,0,0}
})

cutsceneclass = require "cutscene.cutsceneclass"
cutscenethingclass = require "cutscene.cutscenethingclass"

gamestates = {
  splash = require "gamestates.splash",
  cutscene = require "gamestates.cutscene",
  game = require "gamestates.game",
}

levels = {
  require "levels.sample"
}

currentlevel = levels[1]

function love.load()
  hump.gamestate.registerEvents()
  hump.gamestate.switch(gamestates.splash)
end

