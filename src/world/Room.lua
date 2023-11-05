Room = Class{}

function Room:init(player,level)
    self.player=player
    self.level=level
    self.tiles={}
    self.objects={}
    self.boxCounter=1
    self.movementStack={}
    self.levelsFilePath="levels\\levels.txt"
    self.height,self.width,self.tiles = self:getRoomFromFile(self.levelsFilePath,self.level)
    self.numberOfLevelsInGame = 0
    for _ in io.lines(self.levelsFilePath) do
        self.numberOfLevelsInGame = self.numberOfLevelsInGame + 1
    end
end

function Room:update(dt)
    
    for i,box in ipairs(self.objects) do
        local box_x_tile=(box.x/TILE_SIZE) + 1
        local box_y_tile=(box.y/TILE_SIZE) + 1
        if self.player:collides(box.hitboxes.leftHitBox) then
            if ((self.tiles[box_y_tile][box_x_tile + 1].id==7) or (self.tiles[box_y_tile][box_x_tile + 1].id==47))  and (not self:isThereABoxInTile(box_y_tile,box_x_tile+1)) then
                table.insert(self.movementStack,{
                    box_X=box.x,
                    box_Y=box.y,
                    player_X=self.player.x - TILE_SIZE/2,
                    player_Y=self.player.y,
                    box_ID = box.id,
                    leftHitBox=Hitbox("left",box.x+3,box.y+TILE_SIZE/3,TILE_SIZE/3,TILE_SIZE/3),
                    rightHitBox=Hitbox("right",box.x-3+TILE_SIZE*2/3,box.y+TILE_SIZE/3,TILE_SIZE/3,TILE_SIZE/3),
                    bottomHitBox=Hitbox("bottom",box.x+(TILE_SIZE/3),box.y-3+TILE_SIZE*2/3,TILE_SIZE/3,TILE_SIZE/3),
                    topHitBox=Hitbox("top",box.x+TILE_SIZE/3,box.y+3,TILE_SIZE/3,TILE_SIZE/3)
                })
                -- player collides with left Hit Box. Push the box right if the tile on the right of the box is a floor or goal tile
                box.x=box.x+TILE_SIZE
                box.hitboxes.leftHitBox.x=box.hitboxes.leftHitBox.x+TILE_SIZE
                box.hitboxes.rightHitBox.x=box.hitboxes.rightHitBox.x+TILE_SIZE
                box.hitboxes.topHitBox.x=box.hitboxes.topHitBox.x+TILE_SIZE
                box.hitboxes.bottomHitBox.x=box.hitboxes.bottomHitBox.x+TILE_SIZE

            else
                self.player.x = self.player.x - 1
            end

        elseif self.player:collides(box.hitboxes.rightHitBox) then
            if ((self.tiles[box_y_tile][box_x_tile - 1].id==7) or (self.tiles[box_y_tile][box_x_tile - 1].id==47))  and (not self:isThereABoxInTile(box_y_tile,box_x_tile-1))then
                table.insert(self.movementStack,{
                    box_X=box.x,
                    box_Y=box.y,
                    player_X=self.player.x + TILE_SIZE/2,
                    player_Y=self.player.y,
                    box_ID = box.id,
                    leftHitBox=Hitbox("left",box.x+3,box.y+TILE_SIZE/3,TILE_SIZE/3,TILE_SIZE/3),
                    rightHitBox=Hitbox("right",box.x-3+TILE_SIZE*2/3,box.y+TILE_SIZE/3,TILE_SIZE/3,TILE_SIZE/3),
                    bottomHitBox=Hitbox("bottom",box.x+(TILE_SIZE/3),box.y-3+TILE_SIZE*2/3,TILE_SIZE/3,TILE_SIZE/3),
                    topHitBox=Hitbox("top",box.x+TILE_SIZE/3,box.y+3,TILE_SIZE/3,TILE_SIZE/3)
                })
                -- player collides with right Hit Box. Push the box left if the tile on the left of the box is a floor or goal tile
                box.x=box.x-TILE_SIZE
                box.hitboxes.leftHitBox.x=box.hitboxes.leftHitBox.x-TILE_SIZE
                box.hitboxes.rightHitBox.x=box.hitboxes.rightHitBox.x-TILE_SIZE
                box.hitboxes.topHitBox.x=box.hitboxes.topHitBox.x-TILE_SIZE
                box.hitboxes.bottomHitBox.x=box.hitboxes.bottomHitBox.x-TILE_SIZE
            else
                self.player.x = self.player.x + 1
            end
        elseif self.player:collides(box.hitboxes.topHitBox) then
            if ((self.tiles[box_y_tile+1][box_x_tile].id==7) or (self.tiles[box_y_tile+1][box_x_tile].id==47)) and (not self:isThereABoxInTile(box_y_tile+1,box_x_tile)) then
                table.insert(self.movementStack,{
                    box_X=box.x, -- x coord in pixels (e.g. 32)
                    box_Y=box.y, -- y coord in pixels (e.g. 144)
                    player_X=self.player.x,-- x coord in pixels (e.g. 29)
                    player_Y=self.player.y - TILE_SIZE/2,-- y coord in pixels (e.g. 134.933)
                    box_ID = box.id, -- box identifier
                    leftHitBox=Hitbox("left",box.x+3,box.y+TILE_SIZE/3,TILE_SIZE/3,TILE_SIZE/3),
                    rightHitBox=Hitbox("right",box.x-3+TILE_SIZE*2/3,box.y+TILE_SIZE/3,TILE_SIZE/3,TILE_SIZE/3),
                    bottomHitBox=Hitbox("bottom",box.x+(TILE_SIZE/3),box.y-3+TILE_SIZE*2/3,TILE_SIZE/3,TILE_SIZE/3),
                    topHitBox=Hitbox("top",box.x+TILE_SIZE/3,box.y+3,TILE_SIZE/3,TILE_SIZE/3)
                })
                -- player collides with top Hit Box. Push the box down if the tile on the bottom of the box is a floor or goal tile
                box.y=box.y+TILE_SIZE
                box.hitboxes.leftHitBox.y=box.hitboxes.leftHitBox.y+TILE_SIZE
                box.hitboxes.rightHitBox.y=box.hitboxes.rightHitBox.y+TILE_SIZE
                box.hitboxes.topHitBox.y=box.hitboxes.topHitBox.y+TILE_SIZE
                box.hitboxes.bottomHitBox.y=box.hitboxes.bottomHitBox.y+TILE_SIZE
            else
                self.player.y = self.player.y - 1
            end
        elseif self.player:collides(box.hitboxes.bottomHitBox) then
            if ((self.tiles[box_y_tile-1][box_x_tile].id==7) or (self.tiles[box_y_tile-1][box_x_tile].id==47)) and (not self:isThereABoxInTile(box_y_tile-1,box_x_tile))then
                table.insert(self.movementStack,{
                    box_X=box.x,
                    box_Y=box.y,
                    player_X=self.player.x,
                    player_Y=self.player.y + TILE_SIZE/2,
                    box_ID = box.id,
                    leftHitBox=Hitbox("left",box.x+3,box.y+TILE_SIZE/3,TILE_SIZE/3,TILE_SIZE/3),
                    rightHitBox=Hitbox("right",box.x-3+TILE_SIZE*2/3,box.y+TILE_SIZE/3,TILE_SIZE/3,TILE_SIZE/3),
                    bottomHitBox=Hitbox("bottom",box.x+(TILE_SIZE/3),box.y-3+TILE_SIZE*2/3,TILE_SIZE/3,TILE_SIZE/3),
                    topHitBox=Hitbox("top",box.x+TILE_SIZE/3,box.y+3,TILE_SIZE/3,TILE_SIZE/3)
                })
                -- player collides with bottom Hit Box. Push the box up if the tile on the top of the box is a floor or goal tile
            box.y=box.y-TILE_SIZE
            box.hitboxes.leftHitBox.y=box.hitboxes.leftHitBox.y-TILE_SIZE
            box.hitboxes.rightHitBox.y=box.hitboxes.rightHitBox.y-TILE_SIZE
            box.hitboxes.topHitBox.y=box.hitboxes.topHitBox.y-TILE_SIZE
            box.hitboxes.bottomHitBox.y=box.hitboxes.bottomHitBox.y-TILE_SIZE
            else
                self.player.y = self.player.y + 1
            end
        end
    end
end

function Room:isThereABoxInTile(tiley,tilex)
    local boxFound = false
    for i,box in ipairs(self.objects) do
        local box_x_tile=(box.x/TILE_SIZE) + 1
        local box_y_tile=(box.y/TILE_SIZE) + 1
        if box_x_tile == tilex  and box_y_tile == tiley then 
            boxFound= true
        end
    end
    return boxFound
end
function Room:render()
    
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id], (x - 1) * TILE_SIZE ,(y - 1) * TILE_SIZE)
            --love.graphics.rectangle("line",(x - 1) * TILE_SIZE,(y - 1) * TILE_SIZE,TILE_SIZE,TILE_SIZE)
            if tile.leftHitBox then
                tile.leftHitBox:render()
                tile.topHitBox:render()
                tile.rightHitBox:render()
                tile.bottomHitBox:render()
            end
        end
    end
    for k, object in pairs(self.objects) do
        object:render()
        for kk, hitbox in pairs(object.hitboxes) do
            hitbox:render()
        end
    end
    self.player:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['sokoban-small'])
    love.graphics.printf('L'..self.level, 1, 1, 100, 'left')

end
function Room:getRoomFromFile(path,level)
    local open = io.open

    local function read_file_line(path,level)
        local file = open(path, "rb") -- r read mode and b binary mode
        local lineLevel
        if not file then return nil end
        for i=1,level do
            lineLevel = file:read "*l" -- *l reads one line
        end       
     
        file:close()
        return lineLevel
    end
    
    local fileLine = read_file_line(path,level)
    local height,width,tiles = self:get_tiles_from_line(fileLine)
    print (fileLine)
    return height,width,tiles


end

function Room:get_tiles_from_line(fileLine)
    local tiles={}
    local height = 0
    local width = 0
    local lineLength = string.len(fileLine)
    local levelStart = 0
    --[[ The string has the format level3:#####|#@$.#|#####
        we start parsing the room tiles from the : character
        variable levelStart will hold the : character number
    ]]
    for i=1,lineLength do
        if string.sub(fileLine,i,i)==":" then
            levelStart = i
            --print(levelStart)
            break
        end
    end

       --[[
        We now see how wide the room is, this will be the number of characters between : and |
    ]]
    for i=levelStart,lineLength do
        if string.sub(fileLine,i,i)=="|" then
            width = i - levelStart - 1
            --print("Width is:",tostring(width))
            break
        end
    end
    --[[
        We now see how high the room is, this will be the number of | plus one
    ]]
    for i=levelStart,lineLength do
        if string.sub(fileLine,i,i)=="|" then
            height = height +1
        end
        
    end 
    height = height + 1
    --print("Height is:",tostring(height))
    --[[ We now add the tiles to the tile map]]
    local tileToAdd = {}
    local x = 0
    local y = 1 
     
    table.insert(tiles, {})
    for i=levelStart+1,lineLength-1 do
        
        local currentTile = string.sub(fileLine,i,i)
        if currentTile=="#" then
            -- add a wall
            x = x+1
            tileToAdd = {
                id=67,
                x=(x-1)*TILE_SIZE,
                y=(y-1)*TILE_SIZE,
                height=TILE_SIZE,
                width=TILE_SIZE,
                character=currentTile,
                leftHitBox=Hitbox("left",(x-1)*TILE_SIZE,(y-1)*TILE_SIZE,TILE_SIZE/3,TILE_SIZE),
                rightHitBox=Hitbox("right",(x-1)*TILE_SIZE+TILE_SIZE*2/3,(y-1)*TILE_SIZE,TILE_SIZE/3,TILE_SIZE),
                bottomHitBox=Hitbox("bottom",(x-1)*TILE_SIZE,(y-1)*TILE_SIZE+TILE_SIZE*2/3,TILE_SIZE,TILE_SIZE/3),
                topHitBox=Hitbox("top",(x-1)*TILE_SIZE,(y-1)*TILE_SIZE,TILE_SIZE,TILE_SIZE/3)
            }
            
           
        elseif currentTile==" " then
            -- add a floor
            x = x+1
            tileToAdd = {
                id=7,
                x=(x-1)*TILE_SIZE,
                y=(y-1)*TILE_SIZE,
                height=TILE_SIZE,
                width=TILE_SIZE,
                character=currentTile}
            
            
        elseif currentTile=="b" then
            -- add a black tile
            x = x+1
            tileToAdd = {
                id=19,
                x=(x-1)*TILE_SIZE,
                y=(y-1)*TILE_SIZE,
                height=TILE_SIZE,
                width=TILE_SIZE,
                character=currentTile,
                leftHitBox=Hitbox("left",(x-1)*TILE_SIZE,(y-1)*TILE_SIZE,TILE_SIZE/3,TILE_SIZE),
                rightHitBox=Hitbox("right",(x-1)*TILE_SIZE+TILE_SIZE*2/3,(y-1)*TILE_SIZE,TILE_SIZE/3,TILE_SIZE),
                bottomHitBox=Hitbox("bottom",(x-1)*TILE_SIZE,(y-1)*TILE_SIZE+TILE_SIZE*2/3,TILE_SIZE,TILE_SIZE/3),
                topHitBox=Hitbox("top",(x-1)*TILE_SIZE,(y-1)*TILE_SIZE,TILE_SIZE,TILE_SIZE/3)
            }
            
            
        elseif currentTile=="@" then
            --update player coordinates to this tile
            self.player.x = x*TILE_SIZE
            self.player.y = (y-1)*TILE_SIZE
            -- this is the player position. Put a floor tile as well
            x = x+1
            tileToAdd = {
                id=7,
                x=(x-1)*TILE_SIZE,
                y=(y-1)*TILE_SIZE,
                height=TILE_SIZE,
                width=TILE_SIZE,
                character=currentTile
            }
            

        elseif currentTile=="$" then
            -- this is a box position. Put a floor tile as well
            local box = GameObject(GAME_OBJECT_DEFS['box'],x*TILE_SIZE,(y-1)*TILE_SIZE)
            box.id=self.boxCounter
            self.boxCounter = self.boxCounter + 1
            box.hitboxes={}
            box.hitboxes.leftHitBox=Hitbox("left",box.x+3,box.y+box.height/3,box.width/3,box.height/3)
            box.hitboxes.rightHitBox=Hitbox("right",box.x-3+box.width*2/3,box.y+box.height/3,box.width/3,box.height/3)
            box.hitboxes.topHitBox=Hitbox("top",box.x+(box.width/3),box.y+3,box.width/3,box.height/3)
            box.hitboxes.bottomHitBox=Hitbox("bottom",box.x+(box.width/3),box.y-3+box.height*2/3,box.width/3,box.height/3)
            box.onCollide = function()
                print("Collision")
  
            end
            table.insert(self.objects,box)
            tileToAdd = {
                id=7,
                x=(x-1)*TILE_SIZE,
                y=(y-1)*TILE_SIZE,
                height=TILE_SIZE,
                width=TILE_SIZE,
                character=currentTile
            }
            x = x+1
        elseif currentTile=="." then
            -- this is a goal position.
            tileToAdd = {
                id=47,
                x=(x-1)*TILE_SIZE,
                y=(y-1)*TILE_SIZE,
                height=TILE_SIZE,
                width=TILE_SIZE,
                character=currentTile
            }
            x = x+1
        elseif currentTile=="*" then
            -- this is a box on goal position.
            local box = GameObject(GAME_OBJECT_DEFS['box'],x*TILE_SIZE,(y-1)*TILE_SIZE)
            box.hitboxes={}
            box.hitboxes.leftHitBox=Hitbox("left",box.x+3,box.y+box.height/3,box.width/3,box.height/3)
            box.hitboxes.rightHitBox=Hitbox("right",box.x-3+box.width*2/3,box.y+box.height/3,box.width/3,box.height/3)
            box.hitboxes.topHitBox=Hitbox("top",box.x+(box.width/3),box.y+3,box.width/3,box.height/3)
            box.hitboxes.bottomHitBox=Hitbox("bottom",box.x+(box.width/3),box.y-3+box.height*2/3,box.width/3,box.height/3)
            box.onCollide = function()
                print("Collision")
  
            end
            table.insert(self.objects,box)
            tileToAdd = {
                id=47,
                x=(x-1)*TILE_SIZE,
                y=(y-1)*TILE_SIZE,
                height=TILE_SIZE,
                width=TILE_SIZE,
                character=currentTile
            }
            x = x+1
        elseif currentTile=="\n" then
            -- this is a new line. Ignore it
            print("new line detected")
        elseif currentTile=="\r" then
            -- this is a carriage return. Ignore it
            print("carriage return detected")
        elseif currentTile=="|" then
            y = y+1
            tiles[y]={}
            x = 0
        else
            print ("error, don't know character(",tostring(i),")",currentTile)
        end
        if x>0 then  --and (not currentTile =="\r")
            table.insert(tiles[y],tileToAdd)
        end
    end
    return height,width,tiles
end

