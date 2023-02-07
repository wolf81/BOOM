--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Block = Class { __includes = EntityBase }

function Block:init(def)
	EntityBase.init(self, def)

	self.category_flags = CategoryFlags.FIXED_BLOCK
end

function Block:setBlockId(block_id)
	for key, animation in pairs(self.animations) do
		for idx, frame in ipairs(animation.frames) do
			self.animations[key].frames[idx] = frame + block_id
		end
	end
end
