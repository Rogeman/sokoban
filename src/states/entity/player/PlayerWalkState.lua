PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player,room)
    self.entity = player
    self.entity:changeAnimation('walk-down')
    self.room=room
    

end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk-down')
    else
        self.entity:changeState('idle')
    end

    local player_x_tile=math.floor(self.entity.x/TILE_SIZE)+1
    local player_y_tile=math.floor(self.entity.y/TILE_SIZE)+1
    
    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt  
        for i,row in ipairs(self.room.tiles) do
            for j, tile in ipairs(row) do
                if self.entity:collides(tile) and (tile.id==67 or tile.id==19) then
                    if self.entity:collides(tile.leftHitBox) then
                        -- move the character back to the left
                        self.entity.x = self.entity.x - 1
                    end
                    if self.entity:collides(tile.rightHitBox) then
                        -- move the character back to the right
                        self.entity.x = self.entity.x + 1
                    end
                    if self.entity:collides(tile.topHitBox) then
                        -- move the character back up
                        self.entity.y = self.entity.y - 1
                    end
                    if self.entity:collides(tile.bottomHitBox) then
                        -- move the character back down
                        self.entity.y = self.entity.y + 1
                    end
                end

            end
       end
   elseif self.entity.direction == 'right' then
    self.entity.x = self.entity.x + self.entity.walkSpeed * dt  
    for i,row in ipairs(self.room.tiles) do
        for j, tile in ipairs(row) do
            if self.entity:collides(tile) and (tile.id==67 or tile.id==19) then
                if self.entity:collides(tile.leftHitBox) then
                    -- move the character back to the left
                    self.entity.x = self.entity.x - 1
                end
                if self.entity:collides(tile.rightHitBox) then
                    -- move the character back to the right
                    self.entity.x = self.entity.x + 1
                end
                if self.entity:collides(tile.topHitBox) then
                    -- move the character back up
                    self.entity.y = self.entity.y - 1
                end
                if self.entity:collides(tile.bottomHitBox) then
                    -- move the character back down
                    self.entity.y = self.entity.y + 1
                end
            end

        end
   end
    elseif self.entity.direction == 'up' then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt  
        for i,row in ipairs(self.room.tiles) do
            for j, tile in ipairs(row) do
                if self.entity:collides(tile) and (tile.id==67 or tile.id==19) then
                    -- idea if self.entity:collides(tile.hitboxes.bottomHitBox) then
                    if self.entity:collides(tile.leftHitBox) then
                        -- move the character back to the left
                        self.entity.x = self.entity.x - 1
                    end
                    if self.entity:collides(tile.rightHitBox) then
                        -- move the character back to the right
                        self.entity.x = self.entity.x + 1
                    end
                    if self.entity:collides(tile.topHitBox) then
                        -- move the character back up
                        self.entity.y = self.entity.y - 1
                    end
                    if self.entity:collides(tile.bottomHitBox) then
                        -- move the character back down
                        self.entity.y = self.entity.y + 1
                    end
                end

            end
       end
    elseif self.entity.direction == 'down' then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt  
        for i,row in ipairs(self.room.tiles) do
            for j, tile in ipairs(row) do
                if self.entity:collides(tile) and (tile.id==67 or tile.id==19) then
                    -- idea if self.entity:collides(tile.hitboxes.bottomHitBox) then
                    if self.entity:collides(tile.leftHitBox) then
                        -- move the character back to the left
                        self.entity.x = self.entity.x - 1
                    end
                    if self.entity:collides(tile.rightHitBox) then
                        -- move the character back to the right
                        self.entity.x = self.entity.x + 1
                    end
                    if self.entity:collides(tile.topHitBox) then
                        -- move the character back up
                        self.entity.y = self.entity.y - 1
                    end
                    if self.entity:collides(tile.bottomHitBox) then
                        -- move the character back down
                        self.entity.y = self.entity.y + 1
                    end
                end

            end
       end
    end
    -- perform base collision detection against walls
    --EntityWalkState:update(dt)

    
end