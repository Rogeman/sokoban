Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not ((self.x + self.width -1) < target.x or self.x > (target.x + target.width -1)or
                (selfY + selfHeight -1)< target.y or selfY > (target.y + target.height-1))
end

function Player:render()
    Entity.render(self)

end