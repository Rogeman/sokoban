Hitbox = Class{}

function Hitbox:init(tag,x, y, width, height)
    self.tag = tag
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Hitbox:render()
    --love.graphics.setColor(242/255, 242/255, 242/255, 1)
    --tlove.graphics.rectangle("line",self.x,self.y,self.width,self.height)
    --love.graphics.setColor(34/255, 34/255, 34/255, 1)

end
