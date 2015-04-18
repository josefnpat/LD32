local game = {}

function game:init()
  self.bg = love.graphics.newImage("assets/bg.png")
  self.fg = love.graphics.newImage("assets/fg.png")

  self.player = {}

  self.world = bump.newWorld(50)
  self.world:add(self.player,100,400,240,20)

  local w = { x = 20, y = 350, w = 1280 - 20*2, h = 650 - 350 }

end

function game:draw()
  love.graphics.draw(self.bg,-40,-40)
  local x,y,w,h = self.world:getRect(self.player)
  love.graphics.rectangle("line",x,y,w,h)
  love.graphics.print("X:"..x.." Y:"..y)
  love.graphics.draw(self.fg,-40,-40)

end

function game:update(dt)
  local v = {x=0,y=0}

  if bindings.right() then
    v.x = 1
  end
  if bindings.left() then
    v.x = -1
  end
  if bindings.up() then
    v.y = -1
  end
  if bindings.down() then
    v.y = 1
  end

  local x,y,w,h = self.world:getRect(self.player)
  local tx = math.max(0,math.min(love.graphics.getWidth() - w,x+v.x*200*dt))
  local ty = math.max(350,math.min(650,y+v.y*100*dt))

  self.world:move(self.player,tx,ty)
end

return game
