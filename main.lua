local math_utils = require('math_utils')

function love.load(arg)
  
  --[[if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
  end]]--
  
  
  
  numParticles = 150
  px = {}  -- particle x
  py = {}  -- particle y
  pr = {}  -- particle radius
  pvx = {} -- particle velocity x
  pvy = {} -- particle velocity y

  -- stage propertoes
  screenW = love.graphics.getWidth()
  screenH = love.graphics.getHeight()
  easing = 0.095
  friction = 0.8
  radius = math.random(300, 500)
  spring = 0.0005
  color = {math.random(255), math.random(255), math.random(255)}
  
  centerX = screenW / 2;
  centerY = screenH / 2;
  
  targetX = math.random(screenW);
  targetY = math.random(screenH);
  
  velocityX = 0
  velocityY = 0
  
  for i = 1, numParticles do
    px[i] = math.random(screenW)
    py[i] = math.random(screenH)
    pr[i] = math.random(2, 12)
    
    pvx[i] = 0.0
    pvy[i] = 0.0  
  end
end

function randomize()
  targetX = math.random(screenW)
  targetY = math.random(10, screenH - 10)
  radius = math.random(40, 800)
  
  for i = 1, numParticles do
    pr[i] = math.random(2, 22) 
  end
end

function love.update(dt)
  local ax = (targetX - centerX) * easing;
  local ay = (targetY - centerY) * easing;
  
  if (math.abs(ax) < 1 or math.abs(ay) < 1) then
    randomize()
  else 
    velocityX = ax * easing
    centerX =  centerX + velocityX
    
    velocityY =  ay * easing
    centerY = centerY + velocityY;
  end
  
  for i = 1, numParticles do
    local pax = (centerX - (px[i] + math_utils.random_range(-radius * 2, radius * 2))) * spring
    local pay = (centerY - (py[i] + math_utils.random_range(-radius * 2, radius * 2))) * spring
    
    pvx[i] = pvx[i] + pax
    pvx[i] = pvx[i] * friction
    
    pvy[i] = pvy[i] + pay
    pvy[i] = pvy[i] * friction
    
    px[i] = px[i] + pvx[i]
    py[i] = py[i] + pvy[i]
    
  end
end
 
function love.draw()
  love.graphics.setColor(color[1], color[2], color[3])
  
  for i = 1, numParticles do
    love.graphics.circle('fill', px[i], py[i], pr[i], pr[i], 8)
  end
end

function love.mousepressed(x, y, button)
  color = {math.random(255), math.random(255), math.random(255)}
  targetX = love.mouse.getX()
  targetY = love.mouse.getY()
end

