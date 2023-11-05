
EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, room)
    self.entity = entity
    self.entity:changeAnimation('walk-down')

    self.room = room

end

function EntityWalkState:update(dt)
    local player_x_tile=(self.entity.x/TILE_SIZE)+1
    local player_y_tile=(self.entity.y/TILE_SIZE)+1
    -- boundary checking on all sides, allowing us to avoid collision detection on tiles
    if self.entity.direction == 'left' and ((self.room.tiles[player_y_tile][player_x_tile - 1]==7)or(self.room.tiles[player_y_tile][player_x_tile - 1]==47)) then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

    elseif self.entity.direction == 'right' and ((self.room.tiles[player_y_tile][player_x_tile + 1]==7)or(self.room.tiles[player_y_tile][player_x_tile + 1]==47)) then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

    elseif self.entity.direction == 'up' and ((self.room.tiles[player_y_tile - 1][player_x_tile]==7)or(self.room.tiles[player_y_tile - 1][player_x_tile]==47)) then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt

    elseif self.entity.direction == 'down' and ((self.room.tiles[player_y_tile + 1][player_x_tile]==7)or(self.room.tiles[player_y_tile + 1][player_x_tile]==47)) then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    end
end


function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))

end