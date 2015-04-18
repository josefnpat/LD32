local subtitle = {}

function subtitle:draw(text)
  local font = love.graphics.getFont()
  local tw,lines = font:getWrap(text,love.graphics.getWidth())
  local w = love.graphics.getWidth()
  local h = font:getHeight()*lines
  local padding = 16
  local x,y = 0,love.graphics.getHeight()*3/4
  local oldcolor = {love.graphics.getColor()}
  love.graphics.setColor(0,0,0,127)
  love.graphics.rectangle("fill",x,y-padding,w,h+padding*2)
  love.graphics.setColor(255,255,255)
  love.graphics.printf(text,x+padding,y,w,"center")
  love.graphics.setColor(oldcolor)
end

function subtitle:update(dt)
  -- TODO (subtitleclass.update.lcg.lua)
end

-- LuaClassGen pregenerated functions

function subtitle.new(init)
  init = init or {}
  local self={}
  self.draw=subtitle.draw
  self.update=subtitle.update
  self._text=init.text
  self.getText=subtitle.getText
  self.setText=subtitle.setText
  return self
end

function subtitle:getText()
  return self._text
end

function subtitle:setText(val)
  self._text=val
end

return subtitle
