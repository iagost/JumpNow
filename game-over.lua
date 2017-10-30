
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoMenu()
    composer.gotoScene( "menu" )
end
 
local function gotoGame()
    composer.gotoScene( "game" )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------




-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

    local background = display.newImageRect( sceneGroup, "backgroundmenu.png", 300, 300 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

   -- local title = display.newImageRect( sceneGroup, "title.png", 300, 50 )
    --title.x = display.contentCenterX
    --title.y = 50

    local playButton = display.newImageRect( sceneGroup, "botao_start.png", 130, 70 )
    playButton.x = display.contentCenterX
    playButton.y = 200
   -- playButton:setFillColor( 0.82, 0.86, 1 )
 
    --local highScoresButton = display.newText( sceneGroup, "High Scores", display.contentCenterX, 200, native.systemFont, 44 )
    --highScoresButton:setFillColor( 0.75, 0.78, 1 )

    playButton:addEventListener("tap", gotoGame)

    

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
