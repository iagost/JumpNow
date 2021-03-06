
local composer = require( "composer" )

local scene = composer.newScene()



-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
    composer.gotoScene( "game" )
end
 
local function gotoMenu()
    composer.gotoScene( "menu" )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -------------------
local params
local lastScore = composer.getVariable( "lastScore")
local buttonRetry
local buttonMenu
local playerGameOver
local gameOverMusic

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen


	gameOverGroup = display.newGroup()    -- Display group for UI objects like the score
    sceneGroup:insert( gameOverGroup )  

    local backgroundOverlay = display.newImageRect(gameOverGroup, "fundo-gameover.png", display.actualContentWidth, display.actualContentHeight )
    backgroundOverlay.x = display.contentCenterX
    backgroundOverlay.y = display.contentCenterY

    local gameOver = display.newImageRect( gameOverGroup, "gameOver.png", 500, 100 )
    gameOver.x = display.contentCenterX
    gameOver.y = 60

    local score = display.newText(lastScore, display.contentCenterX, 40, 'zrnic', 50 )
    score.y = 130
    gameOverGroup:insert(score)
   
  	--local stringResult = "Your Score was " .. lastScore .. " points"

   -- local scoreResult = display.newText(stringResult, display.contentCenterX, 20, 'Helvetica', 50 )
 --   scoreResult.y = 30
   -- scoreResult:setFillColor(black)
	--gameOverGroup:insert(scoreResult)

	buttonRetry = display.newImageRect(gameOverGroup, "retry.png", 70, 70)
	buttonRetry.x = display.contentWidth-150
	buttonRetry.y = display.contentHeight-60

	buttonMenu = display.newImageRect(gameOverGroup, "menu.png", 70, 70)
	buttonMenu.x = display.contentWidth-300
	buttonMenu.y = display.contentHeight-60

	playerGameOver = display.newImageRect(gameOverGroup, "player-gameOver.png", 100, 100)
	playerGameOver.x = display.contentCenterX
	playerGameOver.y = display.contentHeight-130


   gameOverMusic = audio.loadStream("audio/Cool_Rock_Take_the_Lead.mp3")  
   audio.reserveChannels( 6 )
   audio.setVolume(0.1, {channel=6})
   audio.play(gameOverMusic, { channel=6, loops=-1 })

	
   
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		buttonRetry:addEventListener("tap", gotoGame)
		buttonMenu:addEventListener("tap", gotoMenu)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase
	local parent = event.parent

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		display.remove(sceneGroup)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		audio.stop(6)
		composer.removeScene("game-over")
		

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
