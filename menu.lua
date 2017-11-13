
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
    composer.gotoScene( "game" )
end
 



local menuSound
local player
local sheetPlayer
local spritesPlayer
local timerr
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------


-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

    local background = display.newImageRect( sceneGroup, "fundo-menu.png", display.actualContentWidth, display.actualContentHeight )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

     local plataforma = display.newImageRect(sceneGroup, "plataforma.png", 1280, 20)
 	plataforma.x = display.contentCenterX
 	plataforma.y = display.contentHeight-10
 	plataforma.objType = "ground"
    -- local title = display.newImageRect( sceneGroup, "title.png", 300, 50 )
    --title.x = display.contentCenterX
    --title.y = 50

    local playButton = display.newImageRect( sceneGroup, "play.png", 100, 80 )
    playButton.x = display.contentCenterX
    playButton.y = 200
  	

  	

sheetPlayer = {
	frames = {
		{
			x = 0,
			y = 0,
			width = 25,
			height = 30,
		},
		{
			x = 26,
			y = 0,
			width = 25,
			height = 30,
		},
		{
			x = 49,
			y = 0,
			width = 25,
			height = 30,
		},
		{
			x = 90,
			y = 0,
			width = 25,
			height = 30,
		},
			{
			x = 110,
			y = 0,
			width = 25,
			height = 30,
		},
		{
			x = 155,
			y = 0,
			width = 25,
			height = 30,
		},
		{
			x = 178,
			y = 0,
			width = 25,
			height = 30,
		},


	}
}

spritesPlayer = graphics.newImageSheet("spritesheet.png", sheetPlayer )

local sequenceSprite = {
	{ name="running", frames={2, 3, 4, 5}, time=500, loopCount = 0},
	{ name="jumping", frames={6, 4}, time=200, loopCount = 1},
	{ name="droping", frames={7}, time=1000, loopCount = 1},
}


function runAnimation()
	 player:setSequence("running")
 	 player:play()
end

 player = display.newSprite(sceneGroup, spritesPlayer, sequenceSprite)
 player:scale(1, 1)
 player.anchorX = 1;
 player.x = display.contentWidth-500
 player.y = display.contentHeight-31
 player.myName = "player"
 runAnimation()

 function movePlayer()
  	
  	player.x = player.x + 1
  	if(player.x == 600)then
  		print("entrei")
  		player.x = -50
  	end
  	
  end 

--audio menu
    playButton:addEventListener("tap", gotoGame)

    menuSound = audio.loadStream("audio/River_Flow.mp3")
    audio.reserveChannels( 1 )
    audio.play(menuSound, { channel=1, loops=-1 })
    

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
		
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		timerr = timer.performWithDelay(1, movePlayer, 0)

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		audio.stop(1)
		timer.cancel(timerr)
		composer.removeScene("menu")
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
