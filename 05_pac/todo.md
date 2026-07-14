
# Todo
[x] Make a grid-based movement controller
[x] Implement position warping
[x] Make ghost controller script
	[x] Function to determine ghost target 
	[x] Function to pathfind to that target
	[x] Add option to configure ghost types (Blinky, Pinky, Inky, Clyde)
	[x] Add ghost phase: Chase
	[x] Add ghost phase: Scatter
	[x] Add ghost phase: Frightened
[x] Add delayed start
	[x] Ghosts start at the pen
	[x] Ghosts start moving after a delay
	[x] Pen is closed for pacman and he doesn't stop while crossing it
[x] Objects
	[x] Global values for points, health and pacman state
	[x] Dot (eating will increase the score)
	[x] Power pellet (eating will temporarily trigger frightened mode for ghosts)
[x] Object placement system
	[x] First, there are power pellets (can be placed manually)
	[x] Second, dots are spawning on remaining tiles
	[x] Also, add dead state to ghosts
[x] Game UI (main menu, lose panel, gui)
	[x] Hp is displayed
	[x] Points are displayed (eaten/left)
	[x] Main menu with play option
	[x] Game over panel
	[x] Win panel
[x] Win and lose condition
	[x] Game over panel shows if hp is 0
	[x] UI is styled
	[x] Win panel shows if all dots are eaten
	[x] Losing hp causes some restart in scene
[ ] Optionally: the juice
	[x] Make some graphics
	[x] Add a font
	[ ] When frightened state is ending - add a blinking to ghosts


## Publishing
[x] All bugs are fixed
[x] UI is scaling properly
[x] Game page is made
[/] Everything works in the exported version
[x] # Project is completed


## Bugs
[x] Player position not wrapping when exiting maze
[x] There are too many crossroads at the center
[x] Player collects dots in radius, bound checkers are collecting them
[x] Frightened state for ghosts in too short and there is no visual indicator its ending
[x] When retrying after game over, the points and total points get doubled
[x] There is so much lag
[x] Game freezes randomly
[x] After losing a hp and the delay, the future dir is remembered
[/] When calculating a path when player is not on crossroad, random way gets selected
[/] Frightened state is bugged (let's say its fixed now)
[x] ## When restarting the game, hp is still 0 on exported version only (propably reload_current_scene issue)
