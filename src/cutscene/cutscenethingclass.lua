local cutscenething = {}

function cutscenething.new(init)
  init = init or {}
  local self={}
  self._x=init.x or 0
  self.getX=cutscenething.getX
  self.setX=cutscenething.setX
  self._y=init.y or 0
  self.getY=cutscenething.getY
  self.setY=cutscenething.setY
  self._sx=init.sx or 1
  self.getSx=cutscenething.getSx
  self.setSx=cutscenething.setSx
  self._sy=init.sy or 1
  self.getSy=cutscenething.getSy
  self.setSy=cutscenething.setSy
  self._r=init.r or 0
  self.getR=cutscenething.getR
  self.setR=cutscenething.setR
  self._color=init.color or {255,255,255}
  self.getColor=cutscenething.getColor
  self.setColor=cutscenething.setColor
  self._zindex=init.zindex or 0
  self.getZindex=cutscenething.getZindex
  self.setZindex=cutscenething.setZindex
  self._image=init.image
  self.getImage=cutscenething.getImage
  self.setImage=cutscenething.setImage
  self._draw=init.draw or function(self)
    if self:getImage() then
      love.graphics.draw(self:getImage(),
        self:getX(),self:getY(),self:getR(),
        self:getSx(),self:getSy())
    end
  end
  self._init=init.init or function(self) end
  self.getInit=cutscenething.getInit
  self.setInit=cutscenething.setInit
  self.getDraw=cutscenething.getDraw
  self.setDraw=cutscenething.setDraw
  self._update=init.update or function(self,dt) end
  self.getUpdate=cutscenething.getUpdate
  self.setUpdate=cutscenething.setUpdate
  return self
end

function cutscenething:getX()
  return self._x
end

function cutscenething:setX(val)
  self._x=val
end

function cutscenething:getY()
  return self._y
end

function cutscenething:setY(val)
  self._y=val
end

function cutscenething:getSx()
  return self._sx
end

function cutscenething:setSx(val)
  self._sx=val
end

function cutscenething:getSy()
  return self._sy
end

function cutscenething:setSy(val)
  self._sy=val
end

function cutscenething:getR()
  return self._r
end

function cutscenething:setR(val)
  self._r=val
end

function cutscenething:getColor()
  return self._color
end

function cutscenething:setColor(val)
  self._color=val
end

function cutscenething:getZindex()
  return self._zindex
end

function cutscenething:setZindex(val)
  self._zindex=val
end

function cutscenething:getImage()
  return self._image
end

function cutscenething:setImage(val)
  self._image=val
end

function cutscenething:getInit()
  return self._init
end

function cutscenething:setInit(val)
  self._init=val
end

function cutscenething:getDraw()
  return self._draw
end

function cutscenething:setDraw(val)
  self._draw=val
end

function cutscenething:getUpdate()
  return self._update
end

function cutscenething:setUpdate(val)
  self._update=val
end

return cutscenething
