PlayState = Class{__includes = BaseState}

function PlayState:init(player,level)
    self.player = player
    self.level = level
    self.debouncer = 0
end
function PlayState:enter(def)
    self.player = def.character
    self.level = def.level

    self.currentRoom = Room(self.player,self.level)
    
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player,self.currentRoom) end,
        ['idle'] = function() return PlayerIdleState(self.player,self.currentRoom) end        
    }
    self.player:changeState('idle')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('e') then
        gStateMachine:change('levelSelect',{character=self.player,level=self.level})
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    self.debouncer = self.debouncer + dt
    if (love.keyboard.isDown('lctrl') or love.keyboard.isDown('rctrl')) then
        if love.keyboard.wasPressed('z') then
            if self.debouncer > 0.2 then
                print("Undo")
                self.debouncer = 0
                if #self.currentRoom.movementStack>0 then
                    local move = self.currentRoom.movementStack[#self.currentRoom.movementStack]
                    self.player.x=move.player_X
                    self.player.y=move.player_Y
                    for i,box in ipairs(self.currentRoom.objects) do
                        if box.id==move.box_ID then
                            box.x=move.box_X
                            box.y=move.box_Y
                            box.hitboxes.leftHitBox=move.leftHitBox
                            box.hitboxes.rightHitBox=move.rightHitBox
                            box.hitboxes.bottomHitBox=move.bottomHitBox
                            box.hitboxes.topHitBox=move.topHitBox
                            table.remove(self.currentRoom.movementStack)
                        end
                    end
                end
            end

        end
        

    end
    self.player:update(dt)
    self.currentRoom:update(dt)

    local numberOfBoxesInGoal = 0
    for i,box in ipairs(self.currentRoom.objects) do
        local box_x_tile=(box.x/TILE_SIZE) + 1
        local box_y_tile=(box.y/TILE_SIZE) + 1
        if self.currentRoom.tiles[box_y_tile][box_x_tile].id==47 then
            numberOfBoxesInGoal = numberOfBoxesInGoal + 1
        end
    end
    if numberOfBoxesInGoal == #self.currentRoom.objects then
        local level = self.level + 1
        if level <= self.currentRoom.numberOfLevelsInGame then
            gStateMachine:change('play',{character=self.player,level=level})
        else
            print("you win")
            gStateMachine:change('win',{character=self.player,level=level})
        end
    end

end

function PlayState:render()
    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()
    self.currentRoom:render()
    love.graphics.pop()

 
end