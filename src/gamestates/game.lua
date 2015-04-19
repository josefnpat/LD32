local game = {}

game.anim_fps = 12

function game:init()
  self.bg = love.graphics.newImage("assets/bg.png")
  self.fg = love.graphics.newImage("assets/fg.png")

  self.player = {
    dt = 0,
    direction = 1,
    moving = false,
    health = 10,
    max_health = 10,
    animations = {},
  }
  for _,vanim in pairs({
    {name="stand",count=10},
    {name="walk",count=8},
    {name="jump",count=9},
    {name="attack",count=6},
    {name="death",count=24},
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
  self.world:add(self.player,100,400,100,40)

  local w = { x = 20, y = 350, w = 1280 - 20*2, h = 650 - 350 }

end

function game:getAttackArea()
  local x,y,w,h = self.world:getRect(self.player)
  local size = 1.25
  local centerx = x + w/2
  local aw = w*size
  local ax = centerx - aw/2 + self.player.direction*aw/2

  local ay = y - h/2
  local ah = 2*h
  return ax,ay,aw,ah
end

function game:draw()
  love.graphics.draw(self.bg,-40,-40)

  if not ssloader.success then
    love.graphics.printf("The sprite sheets have not been generated.\n"..
      "Please run `dev/gen.sh`.",
      0,love.graphics.getHeight()/2,love.graphics.getWidth(),"center")
    return
  end

  local x,y,w,h = self.world:getRect(self.player)

  local anim_loop = true
  local anim
  if self.player.health <= 0 then
    anim = self.player.animations.death
    anim_loop = false
  elseif self.player.jumping then
    anim = self.player.animations.jump
    anim_loop = false
  elseif self.player.attacking then
    anim = self.player.animations.attack
    anim_loop = false
  elseif self.player.moving then
    anim = self.player.animations.walk
  else
    anim = self.player.animations.stand
  end

  local frame = math.floor(self.player.dt*game.anim_fps)
  if anim_loop then
    frame = (frame % #anim)+1
  else
    frame = math.min(#anim,frame+1)
  end
  local draw_info = anim[frame]

  local forced_scale = 2

  local scale = w/draw_info.data.real_width*2*forced_scale

  if global_debug then
    love.graphics.rectangle("line",
      x-draw_info.data.real_width/(2*2)*scale,
      y-draw_info.data.real_height*scale+h,
      draw_info.data.real_width*scale,
      draw_info.data.real_height*scale)
  end

  local jump_offset = 0
  if self.player.jumping and self.player.jumping < 0.6 then
    jump_offset = math.sin( self.player.jumping / 0.6 * math.pi ) * 200
  end

  if self.player.direction == -1 then
    love.graphics.draw(draw_info.image,draw_info.quad,
      x-w/2+(draw_info.data.xoffset-draw_info.data.real_width/(2*2))*scale,
      y+h-jump_offset,
      0,scale,scale,
      0,draw_info.data.height)
  else
    love.graphics.draw(draw_info.image,draw_info.quad,
      x+w*1.5-(draw_info.data.xoffset-draw_info.data.real_width/(2*2))*scale,
      y+h-jump_offset,
      0,-scale,scale,
      0,draw_info.data.height)
  end

  love.graphics.draw(self.fg,-40,-40)

  if global_debug then
    love.graphics.rectangle("line",x,y,w,h)
    love.graphics.rectangle("fill",x,y,
      w*self.player.health/self.player.max_health,
      h)
    local ax,ay,aw,ah = game:getAttackArea()
    love.graphics.rectangle("line",ax,ay,aw,ah)
  end

end

function game:update(dt)

  self.player.dt = self.player.dt + dt

  local v = {x=0,y=0}

  -- Control Parsing
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

  if self.player.health > 0 then

    if bindings.getTrigger(bindings.jump) and not self.player.attacking then
      if not self.player.jumping then
        self.player.jumping = 1
        self.player.dt = 0
      end
    end

    if bindings.getTrigger(bindings.attack) and not self.player.jumping then
      if not self.player.attacking then
        self.player.attacking = #self.player.animations.attack/game.anim_fps
        self.player.dt = 0
      end
    end

  else
    v.x = 0
    v.y = 0
  end

  -- Action parsing

  if self.player.jumping then
    if self.player.jumping < 0.6 then
      v.x = self.player.direction*4
      v.y = 0
    else
      v.x = 0
      v.y = 0
    end
    self.player.jumping = self.player.jumping - dt
    if self.player.jumping <= 0 then
      self.player.jumping = nil
    end
  end

  if self.player.attacking then
    self.player.attacking = self.player.attacking - dt
    v.x = 0
    v.y = 0
    if self.player.attacking <= 0 then
      self.player.attacking = nil
    end
  end

  if bindings.debug() then
    local orig_health = self.player.health
    self.player.health = math.max(0,self.player.health - 1)
    if orig_health ~= self.player.health and self.player.health == 0 then
      self.player.dt = 0
    end
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
