local game = {}

game.anim_fps = 12

function game:init()
  self.bg = love.graphics.newImage("assets/bg.png")
  self.fg = love.graphics.newImage("assets/fg.png")
  self.end_level_time = 4

  if love.filesystem.isFile("assets/hearts.png") then
    self.hearts = {}
    self.hearts.img = love.graphics.newImage("assets/hearts.png")
    local json_raw = love.filesystem.read("assets/hearts.json")
    local json_data =json.decode(json_raw)
    self.hearts.info = {}
    for i = 1,14 do
      local v = json_data.sprites['./'..i..'.png']
      table.insert(self.hearts.info,{
        quad = love.graphics.newQuad( v.x, v.y, v.width, v.height, json_data.width, json_data.height ),
        data = v,
      })
    end
  end

end

function game:enter()

  self.beat = 0

  self.end_level = nil

  self.entities = {}
  self.world = bump.newWorld(50)
  currentlevel.game(game)

  local p = entityclass.new({
    world = self.world,
    direction = 1,
    eClass = "dino",
    health = 5,
    maxHealth = 5,
    ai = game.player_ai,
    speed = 200,
    hitHeight = 200,
  })
  table.insert(self.entities,p)
  self.world:add(p,
    love.graphics.getWidth()/4-100/2,
    (650+350)/2,
    100,40)

  self.player = p

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

  local bread_alive = 0
  for _,e in pairs(self.entities) do
    if e:getHealth() > 0 and e:getEClass() == "bread" then
      bread_alive = bread_alive + 1
    end
    e:draw()
  end

  for i = 1,self.player:getHealth() do
    local frame = math.floor(self.beat*4 % 3) + 1
    love.graphics.draw(self.hearts.img,self.hearts.info[frame].quad,
    80*(i-1)+16,16)
  end

  if self.end_level then
    love.graphics.setColor(0,0,0,(1-self.end_level/self.end_level_time)*255)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(255,255,255)
  end

  local text
  if bread_alive > 0 then
    text = "Bread Alive: "..bread_alive
  else
    if not self.end_level then
      self.end_level = self.end_level_time
      sfx:play("success")
    end
    text = "GOOD JOB BRO! TIME FOR THE NEXT LEVEL!"
  end
  love.graphics.printf(text,0,love.graphics.getHeight()/8,love.graphics.getWidth(),"center")

end

function game:update(dt)

  self.beat = self.beat + dt

  if self.end_level then
    self.end_level = math.max(0,self.end_level - dt)
    if self.end_level == 0 then
      hump.gamestate.switch(gamestates.levelselect)
      self.end_level = nil
    end
  end

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

function game.bread_ai(self,dt)
  local x,y,w,h = self:getWorld():getRect(self)
  local px,py,pw,ph = self:getWorld():getRect(gamestates.game.player)
  local dy = py - y
  local dx = px - x
  local angle = math.atan2(dy,dx)
  local v = {
    x = math.cos(angle),
    y = math.sin(angle)
  }
  return v,nil,nil
end

function game.dumb_bread_ai(self,dt)
  return {x=0,y=0},nil,nil
end


return game
