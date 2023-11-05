Entity = Class{}

function Entity:init(def)

    self.direction = 'down'
    self.maxWidth = def.maxWidth
    self.character = def.character
    self.animations = self:createAnimations(def.animations)


    -- dimensions
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.animationTimer = def.animationTimer

    self.walkSpeed = def.walkSpeed
    self.wiggleRoom=3
    self.bottomWiggleRoom=9
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Entity:collides(target)
    
    return not ((self.x + self.width -self.wiggleRoom) < target.x or self.x > (target.x + target.width -self.wiggleRoom)or
    (self.y + self.height -self.bottomWiggleRoom)< target.y or self.y > (target.y + target.height-self.wiggleRoom))
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:render()
    --love.graphics.rectangle("line",self.x,self.y,self.width-self.wiggleRoom,self.height-self.wiggleRoom)
    self.stateMachine:render()

end