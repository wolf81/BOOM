Grid = Class {}

function Grid:init(width, height)
   self.grid = {}

   for y = 1, height do
           self.grid[y] = {}

           for x = 1, width do
                   self.grid[y][x] = 1
           end
   end
end

function Grid:block(x, y)
   self.grid[y][x] = 0
end

function Grid:isBlocked(x, y)
   return self.grid[y][x] == 1
end

function Grid:__tostring()
   local s = 'Grid {\n'
   for y = 1, #self.grid do
           s = s .. '\t'
           for x = 1, #self.grid[1] do
                   s = s .. (self.grid[y][x] == 1 and '#' or ' ') .. ' '
           end
           s = s .. '\n'
   end
   return s .. '}'
end
