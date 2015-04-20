local entity = {}

entity.sprite_fps = 12

entity.shadow = love.graphics.newImage("assets/shadow.png")

entity.animations = {}

for _,vanim in pairs({
  {class="bread",name="stand",count=8},
  {class="bread",name="walk",count=8},
  {class="bread",name="death",count=22},
  {class="dino",name="stand",count=10},
  {class="dino",name="walk",count=8},
  {class="dino",name="jump",count=9},
  {class="dino",name="attack",count=6},
  {class="dino",name="death",count=24},
}) do
  if not entity.animations[vanim.class] then
    entity.animations[vanim.class] = {}
  end
  entity.animations[vanim.class][vanim.name] = {}
  for i = 1, vanim.count do
    local i,q,d = ssloader.lookup('./'..vanim.class..'/'..vanim.name..'/'..i..'.png')
    if i then
      curi,curq,curd = i,q,d
    end
    table.insert(entity.animations[vanim.class][vanim.name],{
      image = curi,
      quad = curq,
      data = curd,
    })
  end
end

function entity:draw()
  local x,y,w,h = self:getWorld():getRect(self)

  local anim_loop = true
  local anim
  local default_anim = entity.animations[self:getEClass()].walk
  if self:getHealth() <= 0 then
    anim = entity.animations[self:getEClass()].death or default_anim
    anim_loop = false
  elseif self:getJumping() then
    anim = entity.animations[self:getEClass()].jump or default_anim
    anim_loop = false
  elseif self:getAttacking() then
    anim = entity.animations[self:getEClass()].attack or default_anim
    anim_loop = false
  elseif self:getWalking() then
    anim = entity.animations[self:getEClass()].walk or default_anim
  else
    anim = entity.animations[self:getEClass()].stand or default_anim
  end

  local frame = math.floor(self:getDt()*entity.sprite_fps)
  if anim_loop then
    frame = (frame % #anim)+1
  else
    frame = math.min(#anim,frame+1)
  end
  local draw_info = anim[frame]

  local forced_scale = 2
  local scale = w/draw_info.data.real_width*2*forced_scale

  local jump_offset = 0
  if self:getJumping() and self:getJumping() < 0.6 then
    jump_offset = math.sin( self:getJumping() / 0.6 * math.pi ) * 200
  end

  local hit_offset = 0
  if self:getHit() and self:getHit() < 1 then
    hit_offset = math.sin( self:getHit() / 1 * math.pi ) * 500
  end

  local shadow_scale = w/entity.shadow:getWidth()
  love.graphics.draw(entity.shadow,x,y+h/2,0,shadow_scale,shadow_scale)

  if self:getDirection() == -1 then
    love.graphics.draw(draw_info.image,draw_info.quad,
      x-w/2+(draw_info.data.xoffset-draw_info.data.real_width/(2*2))*scale,
      y+h-jump_offset-hit_offset,
      0,scale,scale,
      0,draw_info.data.height)
  else
    love.graphics.draw(draw_info.image,draw_info.quad,
      x+w*1.5-(draw_info.data.xoffset-draw_info.data.real_width/(2*2))*scale,
      y+h-jump_offset-hit_offset,
      0,-scale,scale,
      0,draw_info.data.height)
  end

  if global_debug then
    love.graphics.rectangle("line",x,y,w,h)

    love.graphics.rectangle("line",
      x-draw_info.data.real_width/(2*2)*scale,
      y-draw_info.data.real_height*scale+h,
      draw_info.data.real_width*scale,
      draw_info.data.real_height*scale)

    love.graphics.rectangle("line",x,y,w,h)
    love.graphics.setColor(255,0,0,127)
    love.graphics.rectangle("fill",x,y,
      w*self:getHealth()/self:getMaxHealth(),
      h)
    love.graphics.setColor(255,255,255)
    local ax,ay,aw,ah = self:getAttackArea()
    love.graphics.rectangle("line",ax,ay,aw,ah)
  end


end

function entity:update(dt)
  self:setDt( self:getDt() + dt)
  local v,jump,attack = self:getAi()(self,dt)

  if self:getHit() then
    self:setHit( self:getHit() - dt)
    if self:getHit() <= 0 then
      self:setHit( nil )
    end
    v.x = self:getHitDirection()*2
    v.y = 0
  end

  if self:getHealth() > 0 then

    if jump and not self:getAttacking() then
      if not self:getJumping() then
        self:setJumping(1)
        self:setDt(0)
      end
    end

    if attack and not self:getJumping() then
      if not self:getAttacking() then
        self:setAttacking( #entity.animations.dino.attack/entity.sprite_fps )
        self:setDt( 0 )
        local x,y,w,h = self:getAttackArea()
        local items = self:getWorld():queryRect(x,y,w,h)
        for _,e in pairs(items) do
          if e ~= self then
            e:damage(self,1)
          end
        end
      end
    end

  else
    v.x = 0
    v.y = 0
  end

  -- Action parsing

  if self:getJumping() then
    if self:getJumping() < 0.6 then
      v.x = self:getDirection()*4
      v.y = 0
    else
      v.x = 0
      v.y = 0
    end
    self:setJumping( self:getJumping() - dt )
    if self:getJumping() <= 0 then
      self:setJumping(nil)
    end
  end

  if self:getAttacking() then
    self:setAttacking( self:getAttacking() - dt )
    if self:getAttacking() <= 0 then
      self:setAttacking( nil )
    end
    v.x = v.x/4
    v.y = v.y/4
  end

  if v.x > 0 then
    self:setDirection( 1 )
  elseif v.x < 0 then
    self:setDirection( -1 )
  end

  if self:getHitDirection() then
    self:setDirection( -self:getHitDirection() )
  end

  self:setWalking( v.x ~= 0 or v.y ~= 0 )

  local x,y,w,h = self:getWorld():getRect(self)
  -- clamp player
  local tx = math.max(0,math.min(love.graphics.getWidth() - w,x+v.x*self:getSpeed()*dt))
  local ty = math.max(350,math.min(650,y+v.y*self:getSpeed()/2*dt))

  local actualX, actualY, cols, len = self:getWorld():move(self,tx,ty,function(item,other)
    if item:getJumping() or other:getJumping() or
      item:getHit() or other:getHit() or
      item:getHealth() <= 0 or other:getHealth() <= 0 then
      return nil
    else
      return "cross"
    end
  end)

  for _,v in pairs(cols) do
    local bx,by,bw,bh = v.other:getWorld():getRect(v.other)
    local dy = by - y
    local dx = bx - x
    local angle = math.atan2(dy,dx) + math.pi
    local tx = x + math.cos(angle)*dt*100
    local ty = y + math.sin(angle)*dt*100
    -- clamp bread
    local ctx = math.max(-300,math.min(love.graphics.getWidth() - w+300,tx))
    local cty = math.max(350,math.min(650,ty))
    self:getWorld():move(self,ctx,cty,function() end)
    if v.other == gamestates.game.player then
      gamestates.game.player:damage(self,1)
      self:damage(gamestates.game.player,1)
    end
  end

end

function entity:getAttackArea()
  local x,y,w,h = self:getWorld():getRect(self)
  local size = 1.25
  local centerx = x + w/2
  local aw = w*size
  local ax = centerx - aw/2 + self:getDirection()*aw/2

  local ay = y - h/2
  local ah = 2*h
  return ax,ay,aw,ah
end

function entity:damage(other,dmg)
  if not self:getHit() then
    self:setHit(1)
    self:setHitDirection(other:getDirection())
    local orig_health = self:getHealth()
    self:setHealth( math.max(0,self:getHealth() - dmg) )
    if orig_health ~= self:getHealth() and self:getHealth() == 0 then
      self:setDt( 0 )
    end
  end
end

-- LuaClassGen pregenerated functions

function entity.new(init)
  init = init or {}
  local self={}
  self.draw=entity.draw
  self.update=entity.update
  self.damage=entity.damage
  self.getAttackArea=entity.getAttackArea
  self._ai=init.ai or function() end
  self.getAi=entity.getAi
  self.setAi=entity.setAi
  self._dt=init.dt or 0
  self.getDt=entity.getDt
  self.setDt=entity.setDt
  self._direction=init.direction or 1
  self.getDirection=entity.getDirection
  self.setDirection=entity.setDirection
  self._health=init.health or 2
  self.getHealth=entity.getHealth
  self.setHealth=entity.setHealth
  self._maxHealth=init.maxHealth or 2
  self.getMaxHealth=entity.getMaxHealth
  self.setMaxHealth=entity.setMaxHealth
  self._eClass=init.eClass
  self.getEClass=entity.getEClass
  self.setEClass=entity.setEClass
  self._world=init.world
  self.getWorld=entity.getWorld
  self.setWorld=entity.setWorld
  self._jumping=init.jumping
  self.getJumping=entity.getJumping
  self.setJumping=entity.setJumping
  self._attacking=init.attacking
  self.getAttacking=entity.getAttacking
  self.setAttacking=entity.setAttacking
  self._walking=init.walking
  self.getWalking=entity.getWalking
  self.setWalking=entity.setWalking
  self._hit=init.hit
  self.getHit=entity.getHit
  self.setHit=entity.setHit
  self._hitDirection=init.hitDirection
  self.getHitDirection=entity.getHitDirection
  self.setHitDirection=entity.setHitDirection
  self._speed=init.speed
  self.getSpeed=entity.getSpeed
  self.setSpeed=entity.setSpeed
  return self
end

function entity:getAi()
  return self._ai
end

function entity:setAi(val)
  self._ai=val
end

function entity:getDt()
  return self._dt
end

function entity:setDt(val)
  self._dt=val
end

function entity:getDirection()
  return self._direction
end

function entity:setDirection(val)
  self._direction=val
end

function entity:getHealth()
  return self._health
end

function entity:setHealth(val)
  self._health=val
end

function entity:getMaxHealth()
  return self._maxHealth
end

function entity:setMaxHealth(val)
  self._maxHealth=val
end

function entity:getEClass()
  return self._eClass
end

function entity:setEClass(val)
  self._eClass=val
end

function entity:getWorld()
  return self._world
end

function entity:setWorld(val)
  self._world=val
end

function entity:getJumping()
  return self._jumping
end

function entity:setJumping(val)
  self._jumping=val
end

function entity:getAttacking()
  return self._attacking
end

function entity:setAttacking(val)
  self._attacking=val
end

function entity:getWalking()
  return self._walking
end

function entity:setWalking(val)
  self._walking=val
end

function entity:getHit()
  return self._hit
end

function entity:setHit(val)
  self._hit=val
end

function entity:getHitDirection()
  return self._hitDirection
end

function entity:setHitDirection(val)
  self._hitDirection=val
end

function entity:getSpeed()
  return self._speed
end

function entity:setSpeed(val)
  self._speed=val
end

return entity
