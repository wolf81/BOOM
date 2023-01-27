--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

ImageCache = {}

local images = {}

-- retrieve image data from cache, will load image if not stored already
ImageCache.load = function(path)
	if not images[path] then
		images[path] = love.graphics.newImage(path)
	end	

	return images[path]
end

-- clear all image data from cache
ImageCache.clear = function()
	for _, image in ipairs(images) do image:release() end

	images = {}
end
