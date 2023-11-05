LevelSelector = Class{__includes = BaseState}


function LevelSelector:enter(def)
    self.player = def.character
    self.level = def.level
    self.room = Room(self.player,self.level)
    self.selectedLevel = self.level
end

function LevelSelector:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        self.selectedLevel = self.selectedLevel + 1
        if self.selectedLevel > self.room.numberOfLevelsInGame then
            self.selectedLevel = 1
        end
        self.room = Room(self.player,self.selectedLevel)
    end
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        self.selectedLevel = self.selectedLevel - 1
        if self.selectedLevel < 1 then
            self.selectedLevel = self.room.numberOfLevelsInGame
        end
        self.room = Room(self.player,self.selectedLevel)
    end
    if love.keyboard.wasPressed('n') then
        local newLevelNumber = self.selectedLevel+1
        self:addNewLevel(self.room.levelsFilePath,newLevelNumber)
        gStateMachine:change('levelEditor',{character=self.player,level=newLevelNumber})
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('levelEditor',{character=self.player,level=self.selectedLevel})
    end

end
function LevelSelector:addNewLevel(fileWithPath,level)
   -- self.levelsFilePath="levels\\levels.txt"
   -- self.numberOfLevelsInGame
   local levelsString=""
    local lineNumber = 0
    local open = io.open
    local file = open(fileWithPath, "rb") -- r read mode and b binary mode
    if not file then return nil end
    for line in file:lines() do
        lineNumber = lineNumber + 1
        if lineNumber == self.selectedLevel then
            levelsString = levelsString..line
            levelsString = levelsString.."\r\nleveln:########################|########################|########################|########################|########################|#######@ $.#############|########################|########################|########################|########################|########################|########################|########################"
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
function LevelSelector:render()
    
    love.graphics.push()
    self.room:render()
    love.graphics.pop()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['sokoban-small'])
    love.graphics.printf('Level Editor', TILE_SIZE*4, 1, 100000, 'left')


 
end