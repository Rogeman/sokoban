--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Entity'
require 'src/entity_defs'
require 'src/GameObject'
require 'src/game_objects'
require 'src/Player'
require 'src/StateMachine'
require 'src/Util'
require 'src/Hitbox'

require 'src/world/Room'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'

require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/WinState'
require 'src/states/game/LevelSelector'
require 'src/states/game/LevelEditor'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerAnimationState'
require 'src/states/entity/player/PlayerIdleAnimationState'
require 'src/states/entity/player/PlayerWalkAnimationState'



gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['background'] = love.graphics.newImage('graphics/red_brick_wall.jpg'),
    ['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['box'] = love.graphics.newImage('graphics/tilesheet.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16),
    ['box'] = GenerateQuads(gTextures['box'], 16, 16)

}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
    ['zelda'] = love.graphics.newFont('fonts/zelda.otf', 64),
    ['zelda-small'] = love.graphics.newFont('fonts/zelda.otf', 32),
    ['sokoban'] = love.graphics.newFont('fonts/onesize/ONESIZE_.ttf', 32),
    ['sokoban-small'] = love.graphics.newFont('fonts/onesize/ONESIZE_.ttf', 16),
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
    ['sword'] = love.audio.newSource('sounds/sword.wav', 'static'),
    ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav', 'static'),
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav', 'static'),
    ['door'] = love.audio.newSource('sounds/door.wav', 'static')
}