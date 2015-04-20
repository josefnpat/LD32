local cutscene = {}

function cutscene:draw()
  for _,v in pairs(self._things) do
    if v.data then
      if self._curtime >= v.time then
        love.graphics.setColor(v.data:getColor())
        v.data:getDraw()(v.data)
      end
    end
  end
end

function cutscene:update(dt)
  self._curtime = self._curtime + dt

  table.sort(self._things,function(a,b)
    return a.data:getZindex() < b.data:getZindex()
  end)

  for _,v in pairs(self._things) do
    if v.lifespan then
      v.lifespan = v.lifespan - dt
      if v.lifespan <= 0 then
        self:removeThing(v)
      end
    end
    if self._curtime >= v.time then
      if not v.init then
        v.init = true
        if v.data then
          v.data:getInit()(v.data)
        end
      end
      if v.data then
        v.data:getUpdate()(v.data,dt)
      end
    end
  end
  self:removeThing() -- cleanup
end

-- LuaClassGen pregenerated functions

function cutscene.new(init)
  init = init or {}
  local self={}
  self.draw=cutscene.draw
  self.update=cutscene.update
  self._width=init.width or love.graphics.getWidth()
  self.getWidth=cutscene.getWidth
  self.setWidth=cutscene.setWidth
  self._height=init.height or love.graphics.getHeight()
  self.getHeight=cutscene.getHeight
  self.setHeight=cutscene.setHeight
  self._audio=init.audio
  self.getAudio=cutscene.getAudio
  self.setAudio=cutscene.setAudio
  self._things={}
  self.addThing=cutscene.addThing
  self.removeThing=cutscene.removeThing
  self.getThings=cutscene.getThings

  self._curtime = 0
  self._addtime = 0

  return self
end

function cutscene:getWidth()
  return self._width
end

function cutscene:setWidth(val)
  self._width=val
end

function cutscene:getHeight()
  return self._height
end

function cutscene:setHeight(val)
  self._height=val
end

function cutscene:getAudio()
  return self._audio
end

function cutscene:setAudio(val)
  self._audio=val
end

function cutscene:addThing(val)
  assert(type(val)=="table","Error: collection `self._things` can only add `table`")
  self._addtime = self._addtime + val.time
  val.time = self._addtime
  table.insert(self._things,val)
end

function cutscene:removeThing(val)
  if val == nil then
    for i,v in pairs(self._things) do
      if v._remove then
        table.remove(self._things,i)
      end
    end
    self._things_dirty=nil
  else
    local found = false
    for i,v in pairs(self._things) do
      if v == val then
        found = true
        break
      end
    end
    assert(found,"Error: collection `self._things` does not contain `val`")
    val._remove=true
    self._things_dirty=true
  end
end

function cutscene:getThings()
  assert(not self._things_dirty,"Error: collection `self._things` is dirty.")
  return self._things
end

return cutscene
