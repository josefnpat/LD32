local game = {}

game.anim_fps = 12

function game:init()
  self.bg = love.graphics.newImage("assets/bg.png")
  self.fg = love.graphics.newImage("assets/fg.png")

end

function game:enter()
  self.world = bump.newWorld(50)

  self.entities = {}

  local p = entityclass.new({
    world = self.world,
    direction = 1,
    eClass = "dino",
    health = 100,
    maxHealth = 100,
    ai = game.player_ai,
  })
  table.insert(self.entities,p)
  self.world:add(p,100,400,100,40)


  for i = 1,10 do
    local e = entityclass.new({
      world = self.world,
      direction = -1,
      eClass = "bread",
      health = 2,
      maxHealth = 2,
      ai = game.bread_ai,
    })
    table.insert(self.entities,e)
    self.world:add(e,math.random(600,800),math.random(400,600),100,40)
  end

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

  table.sort(self.entities,function(a,b)
    local ax,ay,aw,ah = a:getWorld():getRect(a)
    local bx,by,bw,bh = b:getWorld():getRect(b)
    if ay == by then
      return ax < bx
    end
    return ay < by
  end)

  for _,e in pairs(self.entities) do
    e:draw()
  end

end

function game:update(dt)

  for _,e in pairs(self.entities) do
    e:update(dt)
  end

end

function game.player_ai(self)

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

  return v,bindings.getTrigger(bindings.jump),bindings.getTrigger(bindings.attack)

end

function game.bread_ai(self)
  return {x=0,y=0},nil,nil
end

return game
