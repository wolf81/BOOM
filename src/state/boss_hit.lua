--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

BossHit = Class { __includes = Hit }

function BossHit:enter()
	Hit.enter(self)

	self.entity:setShader(love.graphics.newShader[[
		vec4 effect(vec4 color, Image texture, vec2 textureCoords, vec2 screenCoords){
			return vec4(1, 1, 1, Texel(texture, textureCoords).a) * color;
		}
	]])
end

function BossHit:exit()
	Hit.exit(self)

	self.entity:setShader(nil)
end
