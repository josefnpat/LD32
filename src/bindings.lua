local bindings = {}

bindings.select = function(key)
  if key == " " or key == "return" then
    return true
  end
end

return bindings
