dir = "good/"

b = bubbleclass.new({
  imgTop = love.graphics.newImage(dir.."top.png"),
  imgTopRight = love.graphics.newImage(dir.."top_right.png"),
  imgRight = love.graphics.newImage(dir.."right.png"),
  imgBottomRight = love.graphics.newImage(dir.."bottom_right.png"),
  imgBottom = love.graphics.newImage(dir.."bottom.png"),
  imgBottomLeft = love.graphics.newImage(dir.."bottom_left.png"),
  imgLeft = love.graphics.newImage(dir.."left.png"),
  imgTopLeft = love.graphics.newImage(dir.."top_left.png"),
  imgInside = love.graphics.newImage(dir.."inside.png"),
  imgTail = love.graphics.newImage(dir.."tail.png"),
})

b:setFontColor({0,0,0})
