## Sokoban

This is a version of the classic game: Sokoban.
The goal is to push boxes into their goals, boxes can't be pushed into a wall or into another box. Boxes can only be pushed, you can't pull a box.

### How to Play
__Character Select:__
    Select the character you would like to play with. All characters have the same attributes and only their appearance is different. Once you have chosen your character using the arrow keys, select it and start the game pressing Enter.

__Sokoban game:__
    You can push boxes by moving into them using the arrow keys. Boxes can't be pushed into other boxes or into walls.
    If you make a wrong move, you can undo it by using "Ctrl + Z"
    Your objective is to push all boxes into their goal tiles. Once you do this you will move to the next level.

__Level Editor:__
    You can press "e" to enter into the Level Selector mode.
    You can select the different levels by using the arrow keys. Once you see the level you would like to edit press "enter" to enter the Level Editor mode. If you would like to addd a new level press "n"
    Tiles can be selected using the arrow keys. Once you have selected the tile you want to change you can use the following keys:
        * Arrows (Up, down, left, right) to move the tile selector
        * "q" to substitute the selected tile with a blank tile
        * "w" to substitute the selected tile with a wall tile
        * "e" to substitute the selected tile with a floor tile
        * "r" to substitute the selected tile with a goal tile
        * "t" to toggle a box into the selected tile
        * "y" to move the character start tile to the selected tile
        * "Enter" to exit Level Editor mode and play the level

__Winning the game:__
    You win the game once you beat the last level. 

### Technical Challenges

My initial target was to generate levels automatically, but I realsied this may be overly ambitious. I see some PHd thesys on this topic [here](https://ianparberry.com/pubs/GAMEON-NA_METH_03.pdf) and [here](https://digital.library.unt.edu/ark:/67531/metadc801887/m2/1/high_res_d/dissertation.pdf) which, after trying for a couple days made me believe I should tame my ambition for now.

The technical challenges I was able to tackle for my sokoban game are:
* __Choose from several characters:__ Characters are taken from the entity_defs.lua configuration file and entities.png spritesheet. New characters can be added by editing these files and will be selectable for playing.
* __Characters can move around the room__ using the movement arrows.
* __Characters can be blocked by walls.__ When a character collides with a wall, I needed to know from which direction the player was colliding so I could move the player back in the correct direction. I created four hitboxes per wall tile. For example, if the player hit the bottom hitbox of a wall I could know I had to push him down, whereas if he hit the right hitbox I would push him right.
* __Characters can move boxes:__ I created four hitboxes per box so I could know from which direction the player was colliding with the box. I took the design decision to only allow boxes to be centered in tiles when moving them, this avoids weird positions for boxes which blocks other boxes or movements and increases playability of the game. I had to check that boxes are not moved into walls, blank tiles, or other boxes.
* __Movements can be undone:__ For playability I added an "undo" function which is triggered by clicking Ctrl-Z and undoes the last box movement. To implement this I created a stack where every time I moved the box I stored the coordinates of the box and the player before moving the box. When the player clicks "Ctrl - z" I pop the last coordinates from the stack and apply them to the box and the player. One difficulty I found here is that in Lua you can copy variables but when you copy tables you create a pointer to the table instead of creating an independent copy of the table, so when the table is modified it's modified for all "copies".
* __Read levels from a file__
    * File levels/levels.txt contains one line per level
    * I am basing the level definition notation from [Jsoko](https://www.sokoban-online.de/sokoban/levell-format/)
        * Wall #
        * Player @
        * Player on goal +
        * Box $
        * Box on goal *
        * Goal .
        * Floor (space)
        * Row separator for having the whole level in one line |
* __Create a level-editor which saves levels to a file__
    * Levels in file levels/levels.txt can be edited and new levels added.
    * [check out this comparaive](http://sokobano.de/wiki/index.php?title=Feature_list_:_Level_Editor)
    * The level-editor is able to:
        * Draw objects: wall, box, goal, player
        * Select existing levels for editing
        * Add a new level for editing 

        
        




