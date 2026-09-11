Status: completed

# Info:
	- Style: pixel art
	- Color palette: Apollo, https://lospec.com/palette-list/apollo
	- Reference: https://20_games_challenge.gitlab.io/games/vvvvvv/

# GDD
- Player controller: Make two separate scripts: one for moving left and right and second one for changing gravity


# Todo
- Basics
	[x] Make folders
	[x] Make a root scene
	[x] Setup physics layers
	[x] Setup keybinds
	[x] Make a base graphic
	[x] Make a github repo
- Make a player movement controller
	[x] There is a simple player object
	[x] Player can move left and right
	[x] Gravity is applied to the player
	[x] Pressing space will change gravity
	[x] It's possible to change gravity only standing on terrain
- Make a basic tilemap and terrain
	[x] Make a tilemap object
	[x] Make a basic tile
	[x] Player should collide with the tiles
- Make a basic ui
	[x] Make a basic theme
		[x] Select a color palette
		[x] Apply some basic styles for labels, buttons etc
	[x] Make a basic main menu
		[x] Label with game name
		[x] Play button that works
	[x] Do a pause panel
	[x] Do a win panel
- Make objects (such as spikes, checkpoints, moving platforms)
	[x] Checkpoint
		[x] Object with colliders, sprites etc
		[x] Code-behind
	[x] Enemy component (used in spikes and moving enemies)
	[x] Spike trap
	[x] Moving component (used in moving platforms and enemies)
	[x] Moving platform
	[x] Moving enemy
- Make camera controller (room based camera movement)
	[x] Make a camera
	[x] Make it moving smoothly to a new position
	[x] Make the movement automatic
- Make a level (that contains multiple rooms and win condition)
	[x] Concept - prosty poziom pokazujący mechaniki dostępne w grze
	[x]	Sketch
	[x] Goals
		[x] Make a win flag btw
	[x] Scenario and background
		[x] Spike graphics
		[x] Some background - minimalistyczna jaskinia
	[x] Decorations
		[x] Make base tiles
		[x] Player graphic
		[x] Player animation
		[x] Animation switching
		[x] Enemy graphic
		[x] Some decor stones maybe (they dont fit the game, skipping)
		[x] Moving platform
		[x] Checkpoint graphic
		[x] Checkpoint lighting up when collided with
- Try to make a custom music and sound effects
	[x] Main menu theme
	[x] Game theme
	[x] Change gravity sound
	[x] Death sound
	[x] Checkpoint sound
	[x] Win sound
- Manage sound and music
	[x] Sound and music manager
- Make some art
	[x] Win flag
- Polish the game a bit
	[x] Playtest the level
	[N] Make a falling animation


# Bugs
[x] Game over panel sometimes overlaps win panel
[x] Pause, to menu and play sequence causes starting with paused game
[N] Player moves with moving platform only if on top of it


# Publishing
[x] Make a game page on itch.io
[x] Style the page
[x] Make a banner
[N] Optional: make some screenshots
[x] Insert playable build into the page
[x] Ensure everything works on exported version
[x] Make sure all bugs are fixed
