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

bindings.select = function(key)
  return love.keyboard.isDown(" ","return")
end

return bindings
