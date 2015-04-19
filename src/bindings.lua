local bindings = {}


bindings._triggers = {}

function bindings.getTrigger(bind)
  local player = "player_1"
  local index = tostring(player).."_"..tostring(bind)
  if bind() then -- no player relation as of yet
    if bindings._triggers[index] then
      bindings._triggers[index] = nil
      return true
    end
  else
    bindings._triggers[index] = true
    return
  end
end

bindings.select = function()
  return love.keyboard.isDown(" ","return")
end

bindings.up = function()
  return love.keyboard.isDown("up","w")
end

bindings.down = function()
  return love.keyboard.isDown("down","s")
end

bindings.left = function()
  return love.keyboard.isDown("left","a")
end

bindings.right = function()
  return love.keyboard.isDown("right","d")
end

bindings.attack = function()
  return love.keyboard.isDown("z",".")
end

bindings.jump = function()
  return love.keyboard.isDown("x","/")
end

bindings.debug = function()
  return love.keyboard.isDown("`")
end

return bindings
