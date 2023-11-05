PlayerAnimationState = Class{__includes = BaseState}

function PlayerAnimationState:init(player)
    self.entity = player
    
    self.animationInterval = 2
    
end

function PlayerAnimationState:update(dt)
    self.entity:changeAnimation('walk-down')

end
function PlayerAnimationState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
    
end
