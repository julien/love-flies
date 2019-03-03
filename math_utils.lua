require 'math'

local math_utils = {}

function math_utils.random_range(min, max)
  if type(min) ~= 'number' then
    min = 0
  end
  
  if type(max) ~= 'number' then
    max = 1
  end
  
  if (max < min) then
    local temp = max
    max = min
    min = temp
  end
  
  local res = math.random(max - min) + min
  if res == 0 then
    res = math_utils.random_range(min, max)
  end
  
  return res
end

return math_utils

