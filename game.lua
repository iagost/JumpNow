
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require("physics")
physics.start()

display.setStatusBar( display.HiddenStatusBar )
system.activate( "multitouch" )

local w = display.contentWidth
local h = display.contentHeight
motionx = 0 -- Variable used to move character along x axis
speed = 2 -- Set Walking Speed



local score
local scoreText
local backGroup
local mainGroup
local uiGroup
local jump
local player
local rand
local obstacleNumber
local holding
local sheetOptions
local objectSheet
local buildingtable = {}
local newObstacle
local width
local height

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	 physics.pause()

	  -- Set up display groups
    backGroup = display.newGroup()  -- Display group for the background image
    sceneGroup:insert( backGroup )  -- Insert into the scene's view group
 
    mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
    sceneGroup:insert( mainGroup )  -- Insert into the scene's view group
 
    uiGroup = display.newGroup()    -- Display group for UI objects like the score
    sceneGroup:insert( uiGroup )    -- Insert into the scene's view group
 
    -- Load the background
    local background = display.newImageRect( backGroup, "background2.png", display.actualContentWidth, display.actualContentHeight )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    jump = display.newImageRect( mainGroup, "fundo_transparente.png", 1920, 1080 )

    score = 0

    sheetOptions = {

    frames = {
    		--predio 1
    	{	
    		x = 0,
    		y = 0,
    		width = 1304,
    		height = 1030,
    	},
    	{	
    		x = 0,
    		y = 1030,
    		width = 1304,
    		height = 1030,
    	},
    	{	
    		x = 0,
    		y = 2060,
    		width = 1304,
    		height = 1030,
    	},
    	{	
    		x = 0,
    		y = 3100,
    		width = 1200,
    		height = 963,
    	}
	}
}

objectSheet = graphics.newImageSheet( "imagesheet.png", sheetOptions )


			

local p1 = display.newImageRect(mainGroup, objectSheet, 1, 70, 170)
p1.x = display.contentWidth-420
p1.y = display.contentHeight-90
p1.objType = "ground"

 local p2 = display.newImageRect(mainGroup, objectSheet, 2, 70, 190)
 p2.x = display.contentWidth-310
 p2.y = display.contentHeight-115
 p2.objType = "ground"

 local p3 = display.newImageRect(mainGroup, objectSheet, 1, 50, 140)
 p3.x = display.contentWidth-210
 p3.y = display.contentHeight-90
 p3.objType = "ground"

 local p4 = display.newImageRect(mainGroup, objectSheet, 3, 30, 170)
 p4.x = display.contentWidth-140
 p4.y = display.contentHeight-105
 p4.objType = "ground"

 local p5 = display.newImageRect(mainGroup, objectSheet, 4, 30, 170)
 p5.x = display.contentWidth-100
 p5.y = display.contentHeight-90
 p5.objType = "ground"

 local p6 = display.newImageRect(mainGroup, objectSheet, 1, 60, 120)
 p6.x = display.contentWidth-50
 p6.y = display.contentHeight-80
 p6.objType = "ground"

 local p7 = display.newImageRect(mainGroup, objectSheet, 4, 20, 170)
 p7.x = display.contentWidth-0
 p7.y = display.contentHeight-90
 p7.objType = "ground"

 local p8 = display.newImageRect(mainGroup, objectSheet, 1, 20, 170)
 p8.x = display.contentWidth+50
 p8.y = display.contentHeight-90
 p8.objType = "ground"

 local p9 = display.newImageRect(mainGroup, objectSheet, 4, 20, 170)
 p9.x = display.contentWidth+100
 p9.y = display.contentHeight-90
 p9.objType = "ground"

 local plataforma = display.newImageRect("plataforma.png", 1280, 20)
 plataforma.x = display.contentCenterX
 plataforma.y = display.contentHeight-10
 plataforma.objType = "ground"

 scoreText = display.newText( score, display.contentCenterX, 20, native.systemFont, 40 )

 player = display.newImageRect("player.png", 10, 10)
 player.x = display.contentWidth-470
 player.y = display.contentHeight-200
 player.myName = "player"
 mainGroup:insert( player )

 physics.addBody(plataforma, "static", {bounce=0})
 physics.addBody(p1, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p2, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p3, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p4, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p5, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p6, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p7, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p8, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p9, "static", {bounce=0.0, friction=0.3})
 physics.addBody( player, "dynamic", {density=0.030, radius=5, bounce=0.0}, { box={ halfWidth=3, halfHeight=10, x=0, y=2}, isSensor=true })

 player.isFixedRotation = true
 player.sensorOverlaps = 0


holding = false

local function enterFrameListener()
    if holding then
        local vx, vy = player:getLinearVelocity()
        player:setLinearVelocity( vx, 0 )
        player:applyLinearImpulse( 0.00001, -0.020, player.x, player.y )
    else
        
    end
end

function touchAction( event )

  if ( event.phase == "began" and player.sensorOverlaps > 0 ) then
        -- Jump procedure here
      display.getCurrentStage():setFocus( event.target)
      event.target.isFocus = true;
      holding = true
      Runtime:addEventListener("enterFrame", enterFrameListener )
      

  elseif ( event.target.isFocus ) then

      if (event.phase == "moved") then
      elseif(event.phase == "ended") then
            holding = false
            Runtime:removeEventListener( "enterFrame", enterFrameListener )
            display.getCurrentStage():setFocus( nil )
            event.target.isFocus = false
      end
    end
    return true
end 
    
    function sensorCollide( self, event )

    -- Confirm that the colliding elements are the foot sensor and a ground object
    if ( event.selfElement == 2 and event.other.objType == "ground" ) then

        -- Foot sensor has entered (overlapped) a ground object
        if ( event.phase == "began" ) then
          self.sensorOverlaps = self.sensorOverlaps + 1
          showScore()
        -- Foot sensor has exited a ground object
        elseif ( event.phase == "ended" ) then
        self.sensorOverlaps = self.sensorOverlaps - 1
      end
    end
  end

-- Associate collision handler function with character

--function  createObstacle( )
--	rand = math.random
  --  obstacleNumber = rand(4)

    --if(obstacleNumber == 1) then
	--	print (obstacleNumber)
	--	width = 70
	--	height = 170
    --elseif(obstacleNumber == 2) then
      --  print(obstacleNumber)
        --width = 70
		--height = 170
    --elseif( obstacleNumber == 3) then
      --  print (obstacleNumber)
        --width = 70
		--height = 170
    --elseif( obstacleNumber == 4) then
     --   print (obstacleNumber)
       -- width = 70
		--height = 170
    --end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

    --newObstacle = display.newImageRect( mainGroup, objectSheet, obstacleNumber, width, height)
    --newObstacle.x = display.contentWidth+100
	--newObstacle.y = display.contentHeight-90
    --table.insert(buildingtable, newObstacle )
    --physics.addBody(newObstacle, "dynamic", {bounce=0.0, friction=0.3} )
    --newObstacle.myName = "building"

    --return newObstacle
--end



function gotoMenu()
	print(player.y)
	if(player.y >= 250) then
    composer.gotoScene( "menu" )
	end
end

function showScore()
	score = score + 1
	scoreText.text = score

end


function update( event )

--updateBackgrounds will call a function made specifically to handle the background movement
    updateobstacles()
end

function updateobstacles()

    

    --background movement

    p1.x = p1.x - (1)
    p2.x = p2.x - (1)
    p3.x = p3.x - (1)
    p4.x = p4.x - (1)
    p5.x = p5.x - (1)
    p6.x = p6.x - (1)
    p7.x = p7.x - (1)
    p8.x = p8.x - (1)
    p9.x = p9.x - (1)

    --if the sprite has moved off the screen move it back to the
    --other side so it will move back on
   

    if(p1.x < -50) then
    	p1.x = display.actualContentWidth
    end

    if(p2.x < -50) then
        p2.x = display.actualContentWidth
    end

    if(p3.x < -50) then
        p3.x = display.actualContentWidth
    end

    if(p4.x < -50) then
        p4.x = display.actualContentWidth
    end

    if(p5.x < -50) then
        p5.x = display.actualContentWidth
    end

    if(p6.x < -50) then
        p6.x = display.actualContentWidth
    end

    if(p7.x < -50) then
        p7.x = display.actualContentWidth
    end

    if(p8.x < -50) then
        p8.x = display.actualContentWidth
    end

    if(p9.x < -50) then
        p9.x = display.actualContentWidth
    end
end

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		physics.start()
		jump:addEventListener( "touch", touchAction )
		player.collision = sensorCollide
		player:addEventListener( "collision" )
		--Runtime:addEventListener("enterFrame", showScore)
		--timer.performWithDelay(20000, createObstacle, -1)
		Runtime:addEventListener("enterFrame", gotoMenu)
		timer.performWithDelay(1, update, -1)

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
		jump:removeEventListener( "touch", touchAction )
		player:removeEventListener( "collision" )
		Runtime:removeEventListener("enterFrame", gotoMenu)
		physics.pause()
		--composer.removeScene("game")
		

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
