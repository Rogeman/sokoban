
StartState = Class{__includes = BaseState}

function StartState:init()
    self.characters={}
    
    for k,v in pairs(ENTITY_DEFS) do
        table.insert(self.characters,Entity{
            animations = v.animations,
            walkSpeed = v.walkSpeed or 20,
            maxWidth = v.maxWidth,
            height = v.height,
            width = v.width,
            character = v.character,
            x=VIRTUAL_WIDTH/2,
            y=VIRTUAL_HEIGHT / 2,
            animationTimer=0
            
        })

 
    end

    for i,v in ipairs(self.characters) do
        v.stateMachine = StateMachine {
            --['walk'] = function() return PlayerWalkAnimationState(self.characters[characterCounter]) end,
            ['idle'] = function() return PlayerIdleAnimationState(v) end,
            ['animate'] = function() return PlayerAnimationState(v) end
        }
        v:changeState('idle')
    end

    self.selectedCharacter=math.floor(#self.characters/2)
end

function StartState:update(dt)

    
    self.characters[self.selectedCharacter]:changeState('animate')
    self.characters[self.selectedCharacter]:update(dt)

    local number_of_characters = #self.characters
    local distanceFromMiddle = 0
    local separationBetweenCharacters=5
    for k, character in pairs (self.characters) do
        if k < math.floor(number_of_characters/2) then
            distanceFromMiddle = distanceFromMiddle +character.maxWidth+separationBetweenCharacters
        end
    end
    for k, character in pairs (self.characters) do
        character.x=((VIRTUAL_WIDTH/2)-distanceFromMiddle+(k-1)*character.maxWidth+(k-1)*separationBetweenCharacters)
        character.y=VIRTUAL_HEIGHT / 2
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    
    if love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
        --self.characters[self.selectedCharacter]:changeState('idle')
        self.selectedCharacter=self.selectedCharacter+1
        if self.selectedCharacter>number_of_characters then
            self.selectedCharacter = 1
        end
        
    end
    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
        --self.characters[self.selectedCharacter]:changeState('idle')
        self.selectedCharacter=self.selectedCharacter-1
        if self.selectedCharacter<1 then
            self.selectedCharacter = number_of_characters
        end
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play',{character=self.characters[self.selectedCharacter],level=1})
    end
    if love.keyboard.wasPressed('e') then
        gStateMachine:change('levelSelect',{character=self.characters[self.selectedCharacter],level=1})
    end
end

function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0, VIRTUAL_WIDTH / gTextures['background']:getWidth(),VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    love.graphics.setFont(gFonts['sokoban'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('Sokoban', 2, 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Sokoban', 0, 31 , VIRTUAL_WIDTH, 'center')

    local number_of_characters = #self.characters
    local distanceFromMiddle = 0
    local separationBetweenCharacters=5
    --love.graphics.setColor(255/255, 255/255, 255/255, 1)
    love.graphics.setColor(255/255, 255/255, 255/255, 125/255)
    love.graphics.rectangle("fill",0,VIRTUAL_HEIGHT/2 - 15, VIRTUAL_WIDTH, 64)
    for k, character in pairs (self.characters) do
        if k < math.floor(number_of_characters/2) then
            distanceFromMiddle = distanceFromMiddle +character.maxWidth+separationBetweenCharacters
        end
    end
    for k, character in pairs (self.characters) do
        --character:render((VIRTUAL_WIDTH/2)-distanceFromMiddle+(k-1)*character.maxWidth+(k-1)*separationBetweenCharacters,VIRTUAL_HEIGHT / 2)
        character:render()
    end
    love.graphics.setColor(255/255, 255/255, 255/255, 1)
    
    for k, character in pairs (self.characters) do
        if k==self.selectedCharacter then
            --character:render((VIRTUAL_WIDTH/2)-distanceFromMiddle+(k-1)*character.maxWidth+(k-1)*separationBetweenCharacters,VIRTUAL_HEIGHT / 2)
            love.graphics.rectangle("line",character.x,character.y,character.maxWidth,character.height)
            character:render()
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['sokoban-small'])
    love.graphics.printf('Select Character', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end