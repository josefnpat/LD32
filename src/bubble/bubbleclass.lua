local bubble = {}

function bubble:draw(text,x,y,target_w,pos)
  local font = love.graphics.getFont()
  local w,lines = font:getWrap(text,target_w)
  local h = font:getHeight()*lines
  love.graphics.draw(self:getImgTop(),
    x,
    y-self:getImgTop():getHeight(),
    0,w/self:getImgTop():getWidth(),1)
  love.graphics.draw(self:getImgTopRight(),
    x+w,
    y-self:getImgTopRight():getHeight(),
    0,1,1)
  love.graphics.draw(self:getImgRight(),
    x+w,
    y,
    0,1,h/self:getImgRight():getHeight())
  love.graphics.draw(self:getImgBottomRight(),
    x+w,
    y+h,
    0,1,1)
  love.graphics.draw(self:getImgBottom(),
    x,
    y+h,
    0,w/self:getImgBottom():getWidth(),1)
  love.graphics.draw(self:getImgBottomLeft(),
    x-self:getImgBottomLeft():getWidth(),
    y+h,
    0,1,1)
  love.graphics.draw(self:getImgLeft(),
    x-self:getImgLeft():getWidth(),
    y,
    0,1,h/self:getImgLeft():getHeight())
  love.graphics.draw(self:getImgTopLeft(),
    x-self:getImgTopLeft():getWidth(),
    y-self:getImgTopLeft():getHeight(),
    0,1,1)

  love.graphics.draw(self:getImgInside(),
    x,y,0,
    w/self:getImgInside():getWidth(),
    h/self:getImgInside():getHeight())

  local tailx = x + (w - self:getImgTail():getWidth())/2
  if pos == "left" then
    tailx = x
  elseif pos == "right" then
    tailx = x + w - self:getImgTail():getWidth()
  end
  love.graphics.draw(self:getImgTail(),
    tailx,y+h,0,1,1)

  local old = {love.graphics.getColor()}
  love.graphics.setColor(self:getFontColor())
  love.graphics.printf(text,x,y,w,"center")
  love.graphics.setColor(old)
  -- TODO (bubbleclass.draw.lcg.lua)
end

-- LuaClassGen pregenerated functions

function bubble.new(init)
  init = init or {}
  local self={}
  self.draw=bubble.draw
  self._imgTop=init.imgTop
  self.getImgTop=bubble.getImgTop
  self.setImgTop=bubble.setImgTop
  self._imgTopRight=init.imgTopRight
  self.getImgTopRight=bubble.getImgTopRight
  self.setImgTopRight=bubble.setImgTopRight
  self._imgRight=init.imgRight
  self.getImgRight=bubble.getImgRight
  self.setImgRight=bubble.setImgRight
  self._imgBottomRight=init.imgBottomRight
  self.getImgBottomRight=bubble.getImgBottomRight
  self.setImgBottomRight=bubble.setImgBottomRight
  self._imgBottom=init.imgBottom
  self.getImgBottom=bubble.getImgBottom
  self.setImgBottom=bubble.setImgBottom
  self._imgBottomLeft=init.imgBottomLeft
  self.getImgBottomLeft=bubble.getImgBottomLeft
  self.setImgBottomLeft=bubble.setImgBottomLeft
  self._imgLeft=init.imgLeft
  self.getImgLeft=bubble.getImgLeft
  self.setImgLeft=bubble.setImgLeft
  self._imgTopLeft=init.imgTopLeft
  self.getImgTopLeft=bubble.getImgTopLeft
  self.setImgTopLeft=bubble.setImgTopLeft
  self._imgTail=init.imgTail
  self.getImgTail=bubble.getImgTail
  self.setImgTail=bubble.setImgTail
  self._imgInside=init.imgInside
  self.getImgInside=bubble.getImgInside
  self.setImgInside=bubble.setImgInside
  self._fontColor=init.fontColor
  self.getFontColor=bubble.getFontColor
  self.setFontColor=bubble.setFontColor
  return self
end

function bubble:getImgTop()
  return self._imgTop
end

function bubble:setImgTop(val)
  self._imgTop=val
end

function bubble:getImgTopRight()
  return self._imgTopRight
end

function bubble:setImgTopRight(val)
  self._imgTopRight=val
end

function bubble:getImgRight()
  return self._imgRight
end

function bubble:setImgRight(val)
  self._imgRight=val
end

function bubble:getImgBottomRight()
  return self._imgBottomRight
end

function bubble:setImgBottomRight(val)
  self._imgBottomRight=val
end

function bubble:getImgBottom()
  return self._imgBottom
end

function bubble:setImgBottom(val)
  self._imgBottom=val
end

function bubble:getImgBottomLeft()
  return self._imgBottomLeft
end

function bubble:setImgBottomLeft(val)
  self._imgBottomLeft=val
end

function bubble:getImgLeft()
  return self._imgLeft
end

function bubble:setImgLeft(val)
  self._imgLeft=val
end

function bubble:getImgTopLeft()
  return self._imgTopLeft
end

function bubble:setImgTopLeft(val)
  self._imgTopLeft=val
end

function bubble:getImgTail()
  return self._imgTail
end

function bubble:setImgTail(val)
  self._imgTail=val
end

function bubble:getImgInside()
  return self._imgInside
end

function bubble:setImgInside(val)
  self._imgInside=val
end

function bubble:getFontColor()
  return self._fontColor
end

function bubble:setFontColor(val)
  self._fontColor=val
end

return bubble
