LevelEditor = Class{__includes = BaseState}


function LevelEditor:enter(def)
    self.player = def.character
    self.level = def.level
    self.room = Room(self.player,self.level)
    self.selectedLevel = self.level
    self.tileSelectedXCoord = 0
    self.tileSelectedYCoord = 0
    self.maxYTiles = 12
    self.maxXTiles = 23
end

function LevelEditor:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('down') then
        self.tileSelectedYCoord = self.tileSelectedYCoord + 1
        if self.tileSelectedYCoord > self.maxYTiles then
            self.tileSelectedYCoord = 0
        end
    end
    if love.keyboard.wasPressed('up') then
        self.tileSelectedYCoord = self.tileSelectedYCoord - 1
        if self.tileSelectedYCoord < 1 then
            self.tileSelectedYCoord = self.maxYTiles
        end
    end
    if love.keyboard.wasPressed('right') then
        self.tileSelectedXCoord = self.tileSelectedXCoord + 1
        if self.tileSelectedXCoord > self.maxXTiles then
            self.tileSelectedXCoord = 0
        end
    end
    if love.keyboard.wasPressed('left') then
        self.tileSelectedXCoord = self.tileSelectedXCoord - 1
        if self.tileSelectedXCoord < 1 then
            self.tileSelectedXCoord = self.maxXTiles
        end
    end
    if love.keyboard.wasPressed('q') then
        -- insert a blank
        self.room.tiles[self.tileSelectedYCoord+1][self.tileSelectedXCoord+1]={
            id=19,
            x=(self.tileSelectedXCoord+1)*TILE_SIZE,
            y=(self.tileSelectedYCoord+1)*TILE_SIZE,
            height=TILE_SIZE,
            width=TILE_SIZE,
            character="b"
        }
    end
    if love.keyboard.wasPressed('w') then
        --insert a wall
        self.room.tiles[self.tileSelectedYCoord+1][self.tileSelectedXCoord+1]={
            id=67,
            x=(self.tileSelectedXCoord-1)*TILE_SIZE,
            y=(self.tileSelectedYCoord-1)*TILE_SIZE,
            height=TILE_SIZE,
            width=TILE_SIZE,
            character="#",
            leftHitBox=Hitbox("left",(self.tileSelectedXCoord-1)*TILE_SIZE,(self.tileSelectedYCoord-1)*TILE_SIZE,TILE_SIZE/3,TILE_SIZE),
            rightHitBox=Hitbox("right",(self.tileSelectedXCoord-1)*TILE_SIZE+TILE_SIZE*2/3,(self.tileSelectedYCoord-1)*TILE_SIZE,TILE_SIZE/3,TILE_SIZE),
            bottomHitBox=Hitbox("bottom",(self.tileSelectedXCoord-1)*TILE_SIZE,(self.tileSelectedYCoord-1)*TILE_SIZE+TILE_SIZE*2/3,TILE_SIZE,TILE_SIZE/3),
            topHitBox=Hitbox("top",(self.tileSelectedXCoord-1)*TILE_SIZE,(self.tileSelectedYCoord-1)*TILE_SIZE,TILE_SIZE,TILE_SIZE/3)
        }
    end
    if love.keyboard.wasPressed('e') then
        --insert a floor
        self.room.tiles[self.tileSelectedYCoord+1][self.tileSelectedXCoord+1]={
            id=7,
            x=(self.tileSelectedXCoord-1)*TILE_SIZE,
            y=(self.tileSelectedYCoord-1)*TILE_SIZE,
            height=TILE_SIZE,
            width=TILE_SIZE,
            character=" "}
    end
    if love.keyboard.wasPressed('r') then
        --insert a goal
        self.room.tiles[self.tileSelectedYCoord+1][self.tileSelectedXCoord+1]={
            id=47,
            x=(self.tileSelectedXCoord-1)*TILE_SIZE,
            y=(self.tileSelectedYCoord-1)*TILE_SIZE,
            height=TILE_SIZE,
            width=TILE_SIZE,
            character="."
        }

    end
    if love.keyboard.wasPressed('t') then
        --insert a box on a floor tile
        if self.room.tiles[self.tileSelectedYCoord+1][self.tileSelectedXCoord+1].character == "$" then 
            -- this was already set as box, so delete the box
            for i, box in ipairs(self.room.objects) do
                if box.x==(self.tileSelectedXCoord)*TILE_SIZE and box.y==(self.tileSelectedYCoord)*TILE_SIZE then
                    table.remove(self.room.objects,i)
                end
            end
            self.room.tiles[self.tileSelectedYCoord+1][self.tileSelectedXCoord+1].character = " "
        else
            self.room.tiles[self.tileSelectedYCoord+1][self.tileSelectedXCoord+1]={
                id=7,
                x=(self.tileSelectedXCoord-1)*TILE_SIZE,
                y=(self.tileSelectedYCoord-1)*TILE_SIZE,
                height=TILE_SIZE,
                width=TILE_SIZE,
                character="$"
            }
            local box = GameObject(GAME_OBJECT_DEFS['box'],self.tileSelectedXCoord*TILE_SIZE,(self.tileSelectedYCoord)*TILE_SIZE)
            box.hitboxes={}
            box.hitboxes.leftHitBox=Hitbox("left",box.x+3,box.y+box.height/3,box.width/3,box.height/3)
            table.insert(self.room.objects,box)
        end
    end
    if love.keyboard.wasPressed('y') then
        --remove player from everywhere else
        for i,row in ipairs(self.room.tiles) do
            for j, tile in ipairs(row) do
                if tile.character=="@" then
                    tile.character=" "
                end
            end
        end
        --place player
        self.player.x=self.tileSelectedXCoord*TILE_SIZE
        self.player.y=self.tileSelectedYCoord*TILE_SIZE
        --write a floor tile with the @ character to represent the player
        self.room.tiles[self.tileSelectedYCoord+1][self.tileSelectedXCoord+1]={
            id=7,
            x=(self.tileSelectedXCoord-1)*TILE_SIZE,
            y=(self.tileSelectedYCoord-1)*TILE_SIZE,
            height=TILE_SIZE,
            width=TILE_SIZE,
            character="@"
        }


    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self:saveLevelToFile("levels\\levels.txt")
        gStateMachine:change('play',{character=self.player,level=self.selectedLevel})
    end

end
function LevelEditor:tilesToString(tiles)
    local levelString="level"..self.selectedLevel..":"
    for i,row in ipairs(self.room.tiles) do
        for j, tile in ipairs(row) do
            levelString = levelString..tile.character
        end
        levelString = levelString.."|"
    end
    levelString = levelString:sub(1,#levelString-1)
    return levelString
end

function LevelEditor:saveLevelToFile(fileWithPath)
    local levelsString=""
    local lineNumber = 0
    local open = io.open
    local file = open(fileWithPath, "rb") -- r read mode and b binary mode
    if not file then return nil end
    for line in file:lines() do
        lineNumber = lineNumber + 1
        if lineNumber == self.selectedLevel then
            levelsString = levelsString..self:tilesToString(self.room.tiles)
          
        else
            levelsString = levelsString..line
        end
        levelsString = levelsString.."\r\n"
    end
    levelsString = levelsString:gsub("\r","")
    
    file:close()

    file = open(fileWithPath, "w")
    file:write(levelsString)
    file:close()
end
function LevelEditor:render()
    
    love.graphics.push()
    self.room:render()
    love.graphics.pop()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['sokoban-small'])
    love.graphics.printf('Level Editor', TILE_SIZE*4, 1, 100000, 'left')

    love.graphics.rectangle("line",self.tileSelectedXCoord*TILE_SIZE,self.tileSelectedYCoord*TILE_SIZE,TILE_SIZE,TILE_SIZE)

 
end