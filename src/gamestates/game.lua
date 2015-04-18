local game = {}

function game:init()
  self.bg = love.graphics.newImage("assets/bg.png")
  self.fg = love.graphics.newImage("assets/fg.png")
end

function game:draw()
  love.graphics.draw(self.bg,-40,-40)
  love.graphics.draw(self.fg,-40,-40)
end

return game
