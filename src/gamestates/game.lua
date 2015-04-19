local game = {}

function game:init()
  self.bg = love.graphics.newImage("assets/bg.png")
  self.fg = love.graphics.newImage("assets/fg.png")

  self.player = {
    dt = 0,
    direction = 1,
    moving = false,
    animations = {},
  }
  for _,vanim in pairs({
    {name="stand",count=10},
    {name="walk",count=8},
  }) do
    self.player.animations[vanim.name] = {}
    for i = 1, vanim.count do
      local i,q,d = ssloader.lookup('./dino/'..vanim.name..'/'..i..'.png')
      if i then
        curi,curq,curd = i,q,d
      end
      table.insert(self.player.animations[vanim.name],{
        image = curi,
        quad = curq,
        data = curd,
      })
    end

  end

  self.world = bump.newWorld(50)
  self.world:add(self.player,100,400,240,20)

  local w = { x = 20, y = 350, w = 1280 - 20*2, h = 650 - 350 }

end

function game:draw()
  love.graphics.draw(self.bg,-40,-40)
  local x,y,w,h = self.world:getRect(self.player)

  local anim = self.player.moving and self.player.animations.walk or self.player.animations.stand
  local frame = (math.floor(self.player.dt*10) % #anim)+1
  local draw_info = anim[frame]
  local scale = w/draw_info.data.real_width*2

  --[[
  love.graphics.rectangle("line",
    x-draw_info.data.real_width/4*scale,
    y-draw_info.data.real_height*scale+h,
    draw_info.data.real_width*scale,
    draw_info.data.real_height*scale)
  --]]

  if self.player.direction == -1 then
    love.graphics.draw(draw_info.image,draw_info.quad,
      x+(draw_info.data.xoffset-draw_info.data.real_width/4)*scale,
      y+h,
      0,scale,scale,
      0,draw_info.data.height)
  else
    love.graphics.draw(draw_info.image,draw_info.quad,
      x+w-(draw_info.data.xoffset-draw_info.data.real_width/4)*scale,
      y+h,
      0,-scale,scale,
      0,draw_info.data.height)
  end

  love.graphics.draw(self.fg,-40,-40)

  --love.graphics.rectangle("line",x,y,w,h)

end

function game:update(dt)

  self.player.dt = self.player.dt + dt

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

  if v.x > 0 then
    self.player.direction = 1
  elseif v.x < 0 then
    self.player.direction = -1
  end

  self.player.moving = v.x ~= 0 or v.y ~= 0

  local x,y,w,h = self.world:getRect(self.player)
  local tx = math.max(0,math.min(love.graphics.getWidth() - w,x+v.x*200*dt))
  local ty = math.max(350,math.min(650,y+v.y*100*dt))

  self.world:move(self.player,tx,ty)
end

return game
