
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
speed = 1 -- Set Walking Speed


local pontuacao = 0
local score
local scoreText
local backGroup
local mainGroup
local uiGroup
local jump
local player
local sheetPlayer
local rand
local buildingNumber
local holding
local sheetOptions
local objectSheet
local buildingtable = {}
local building
local buildingCounter = 0
local width
local height
local timerOfCreateBulding
local timerOfDestroyBulding
local timerr
local character
local options
local gameMusic
local scoreName
local jumpSound
local dropSound
local runningSound
local playerImpulse = 0.00000
local olofote
local rand2
local cameraNumber
local cameraTable = {}
local cameraCounter = 0
local camera
local timerCreateCamera
local timerMoveCamera
local timerDestroyCamera
local flash


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

    flash = display.newImageRect( uiGroup, "flashBang.png", display.actualContentWidth, display.actualContentHeight )
    flash.x = display.contentCenterX
    flash.y = display.contentCenterY
    flash.alpha = 0

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
	
function jumpAnimation()
	 player:setSequence("jumping")
 	 player:play()
end

function runAnimation()
	 player:setSequence("running")
 	 player:play()
end

function dropAnimation()
	 player:setSequence("droping")
 	 player:play()
end
			
--[[local pnew = display.newImageRect("predio6.png", 150,170)
pnew.x = display.contentWidth-300
pnew.y = display.contentHeight-90
pnew.objType = "ground"
]]

local p1 = display.newImageRect(mainGroup, objectSheet, 1, 70, 170)
p1.x = display.contentWidth-430
p1.y = display.contentHeight-90
p1.objType = "ground"
table.insert(buildingtable, p1 )
buildingCounter = buildingCounter + 1

 local p2 = display.newImageRect(mainGroup, objectSheet, 2, 70, 190)
 p2.x = display.contentWidth-310
 p2.y = display.contentHeight-115
 p2.objType = "ground"
 table.insert(buildingtable, p2 )
 buildingCounter = buildingCounter + 1

 local p3 = display.newImageRect(mainGroup, objectSheet, 1, 70, 140)
 p3.x = display.contentWidth-210
 p3.y = display.contentHeight-90
 p3.objType = "ground"
 table.insert(buildingtable, p3 )
 buildingCounter = buildingCounter + 1

 local p4 = display.newImageRect(mainGroup, objectSheet, 3, 30, 170)
 p4.x = display.contentWidth-140
 p4.y = display.contentHeight-105
 p4.objType = "ground"
 table.insert(buildingtable, p4 )
 buildingCounter = buildingCounter + 1

 local p5 = display.newImageRect(mainGroup, objectSheet, 4, 30, 170)
 p5.x = display.contentWidth-100
 p5.y = display.contentHeight-90
 p5.objType = "ground"
 table.insert(buildingtable, p5 )
 buildingCounter = buildingCounter + 1

 local p6 = display.newImageRect(mainGroup, objectSheet, 1, 60, 120)
 p6.x = display.contentWidth-50
 p6.y = display.contentHeight-80
 p6.objType = "ground"
 table.insert(buildingtable, p6 )
 buildingCounter = buildingCounter + 1

 local p7 = display.newImageRect(mainGroup, objectSheet, 4, 55, 110)
 p7.x = display.contentWidth+20
 p7.y = display.contentHeight-70
 p7.objType = "ground"
 table.insert(buildingtable, p7 )
 buildingCounter = buildingCounter + 1
 local p8 = display.newImageRect(mainGroup, objectSheet, 1, 40, 170)
 p8.x = display.contentWidth+85
 p8.y = display.contentHeight-90
 p8.objType = "ground"
 table.insert(buildingtable, p8 )
 buildingCounter = buildingCounter + 1

    
 
 local plataforma = display.newImageRect(mainGroup, "plataforma.png", 1280, 20)
 plataforma.x = display.contentCenterX
 plataforma.y = display.contentHeight-10
 plataforma.objType = "ground"

--local plataforma2 = display.newImageRect(mainGroup, "plataforma.png", 1280, 20)
 --plataforma2.x = display.contentCenterX
 --plataforma2.y = display.contentHeight-310
 --plataforma2.objType = "ground"
 --plataforma2.alpha = 0

 



 scoreName = display.newText("Score: ", display.contentWidth-433, 20, 'zrnic', 25 )
 uiGroup:insert(scoreName)
 scoreText = display.newText(score, display.contentWidth-388, 20, 'zrnic', 25 )
 uiGroup:insert(scoreText)

 --	player = display.newImageRect(uiGroup, spritesPlayer, 7, 15, 15)
 player = display.newSprite(uiGroup, spritesPlayer, sequenceSprite)
 player:scale(0.7, 0.7)
 player.anchorX = 1;
 player.x = display.contentWidth-430
 player.y = display.contentHeight-200
 player.myName = "player"
 mainGroup:insert( player )
 runAnimation()


 olofote = display.newImageRect(backGroup, "yelowLight.png", 50, 2000 )
 olofote.y = player.y
  olofote.x = player.x
  olofote.alpha = 0.1

 

 physics.addBody(plataforma, "static", {bounce=0})
 --physics.addBody(plataforma2, "static", {bounce=0})
 
 physics.addBody(p1, "dynamic", {bounce=0.0, friction=0})
 physics.addBody(p2, "dynamic", {bounce=0.0, friction=0})
 physics.addBody(p3, "static", {bounce=0.0, friction=0})
 physics.addBody(p4, "static", {bounce=0.0, friction=0})
 physics.addBody(p5, "static", {bounce=0.0, friction=0})
 physics.addBody(p6, "dynamic", {bounce=0.0, friction=0})
 physics.addBody(p7, "dynamic", {bounce=0.0, friction=0})
 physics.addBody(p8, "static", {bounce=0.0, friction=0})
 --physics.addBody(p9, "static", {bounce=0.0, friction=0.3})

 physics.addBody( player, "dynamic", {density=0.030, radius=8, bounce=0.0}, { box={ halfWidth=3, halfHeight=8, x=-10, y=1}, isSensor=false})
 player.ghost=true
 player.isFixedRotation = true
 player.sensorOverlaps = 0
 player.collType = "passthru"
 player.preCollision = onPreCollision
 player:addEventListener("preCollision", player)

--physics.setDrawMode("hybrid")
--player:player()

holding = false

local function enterFrameListener()

    if holding then
        local vx, vy = player:getLinearVelocity()
        player:setLinearVelocity( vx, 0 )
        player:applyLinearImpulse( playerImpulse, -0.030, player.x, player.y )
        print(player.y)
        
    else

        
    end

end

function touchAction( event )

  if ( event.phase == "began" and player.sensorOverlaps > 0 ) then
        -- Jump procedure here
----------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>> 


      display.getCurrentStage():setFocus( event.target)
      event.target.isFocus = true;
      holding = true;
      Runtime:addEventListener("enterFrame", enterFrameListener )
      jumpAnimation()
      audio.play(jumpSound, { channel=3 })
      
         
  elseif ( event.target.isFocus ) then

      if (event.phase == "moved") then
      elseif(event.phase == "ended") then
            holding = false
            Runtime:removeEventListener( "enterFrame", enterFrameListener )
            display.getCurrentStage():setFocus( nil )
            event.target.isFocus = false
           	dropAnimation()
           	audio.stop(3)
      end
    end
    return true
end 
    
    function sensorCollide( self, event )

    -- Confirm that the colliding elements are the foot sensor and a ground object
    if ( event.selfElement == 2 and event.other.objType == "ground" ) then
    		--audio.play(runningSound, {channel=5})
        -- Foot sensor has entered (overlapped) a ground object
        if ( event.phase == "began" ) then
          self.sensorOverlaps = self.sensorOverlaps + 1
          showScore()
          
          audio.play(runningSound, {channel=5})
          audio.play(dropSound, { channel=4 })
          runAnimation()
        -- Foot sensor has exited a ground object
        elseif ( event.phase == "ended" ) then
        self.sensorOverlaps = self.sensorOverlaps - 1
        --dropAnimation()

 		audio.stop(4)
 		audio.stop(5)
      end

    end
  end



function createBuilding()
	rand = math.random
  	buildingNumber = rand(7)

    if(buildingNumber == 1) then
	
		width = 70
		height = 170
    elseif(buildingNumber == 2) then
        
        width = 40
		height = 120
    elseif( buildingNumber == 3) then
        
        width = 20
		height = 140
    elseif( buildingNumber == 4) then
    
        width = 55
		height = 110
	elseif( buildingNumber == 5) then
        buildingNumber = 4
        width = 55
		height = 90
	elseif( buildingNumber == 6) then
        buildingNumber = 4
        width = 37
		height = 130
	elseif( buildingNumber == 7) then
        buildingNumber = 1
        width = 48
		height = 145
    end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

    building = display.newImageRect( mainGroup, objectSheet, buildingNumber, width, height)
    building.x = display.contentWidth+80
	building.y = display.contentHeight-90
    table.insert(buildingtable, building )
    physics.addBody(building, "dynamic", {bounce=0.0, friction=0} )
    building.myName = "building"
    building.objType = "ground"
    buildingCounter = buildingCounter + 1
  --  moveBuilding(building)
  --  print(buildingCounter)
    
    return building
end

--Remove buldiings from table
function destroyBuilding()
	

	 for i = #buildingtable,1,-1 do
	 	
	 	if(buildingtable[i].x < -50) then
	 	

	 		display.remove(buildingtable[i])
	 		table.remove(buildingtable, i)
	 		buildingCounter = buildingCounter - 1

	 	end
	 end
	
	
end

function destroyCamera( )
	for i = #cameraTable,1,-1 do
	 	
	 	if(cameraTable[i].x < -50) then
	 	

	 		display.remove(cameraTable[i])
	 		table.remove(cameraTable, i)
	 		cameraCounter = cameraCounter - 1

	 	end
	 end
end
	



function endGame()
	if(player.y <= 70)then
  	holding = false
  	end
	if(player.y >= 250 or player.x < -50) then
	composer.setVariable( "lastScore", score )	
  	composer.gotoScene( "game-over", options )
  	--	composer.showOverlay( "game-over", options )
 
  
	end
end

function showScore()
	score = score + 1
	scoreText.text = score
end



function createCity( event )
--updateBackgrounds will call a function made specifically to handle the background movement
    moveBuilding()
    moveOlofote()
end

function moveBuilding()

	for i = 1,#buildingtable,1 do
	 	local predio = buildingtable[i]
	 	if(score < 15)then
	 	predio.x = predio.x - 1
	 	playerImpulse = 0.000001
	 end
	 	if(score >= 15)then
	 	predio.x = predio.x - 1.1
	 	playerImpulse = 0.000001
	 end
	 	if(score >= 40)then
	 	predio.x = predio.x - 0.2
	 	playerImpulse = 0.000002
	 end
	 if(score >= 70)then
	 	predio.x = predio.x - 0.3
	 	playerImpulse = 0.000002
	 end
	 end
       
end

function moveCamera( )
	for i = 1,#cameraTable, 1 do
		local cam = cameraTable[i]
		transition.to( cam, { time=6000, x=-100} )
	end
end


function createCamera( )
	rand2 = math.random
  	cameraNumber = rand(3)


  	if(cameraNumber==1)then
  		camera = display.newImageRect(uiGroup, "camera.png", 20, 20)
 		camera.x = display.actualContentWidth
 		camera.y = display.contentHeight-225
 		camera.myName = "camera"
 		 table.insert(cameraTable, camera )
 		 physics.addBody(camera, "static", {bounce=0.0, isSensor = true })
 		 camera.ghost=true
 		 player.collType = "passthru"
 		 camera.preCollision = onPreCollision
 		 camera:addEventListener("preCollision", camera)
 		 
 	elseif(cameraNumber==2)then
 		camera = display.newImageRect(uiGroup, "camera.png", 20, 20)
 		camera.x = display.actualContentWidth
 		camera.y = display.contentHeight-200
 		camera.myName = "camera"
 		table.insert(cameraTable, camera )
 		physics.addBody(camera, "static", {bounce=0.0, isSensor = true })
 		camera.ghost=true
 		player.collType = "passthru"
 		camera.preCollision = onPreCollision
 		 camera:addEventListener("preCollision", camera)
 	elseif(cameraNumber==3)then
 		camera = display.newImageRect(uiGroup, "camera.png", 20, 20)
 		camera.x = display.actualContentWidth
 		camera.y = display.contentHeight-250
 		camera.myName = "camera"
 		table.insert(cameraTable, camera )
 		physics.addBody(camera, "static", {bounce=0.0, isSensor = true })
 		camera.ghost=true
 		player.collType = "passthru"
 		camera.preCollision = onPreCollision
 		camera:addEventListener("preCollision", camera)
 	end
 		cameraCounter = cameraCounter + 1

 		return camera

end



local function preCollision(self, event )
	local collideObject = event.other

	if (collideObject.collType == "passthru") then 
    event.contact.isEnabled=false
  end
end
 
function collisionCam( event )
	if(event.phase == "began")then
		local obj1 = event.object1
		local obj2 = event.object2
		if((obj1.myName == "player" and obj2.myName == "camera") or (obj1.myName == "camera" and obj2.myName == "player"))then
			
			flash.alpha = 1

		end
	else
		flash.alpha = 0
	end

end



   gameMusic = audio.loadStream("audio/Locked_Out.mp3")  
   audio.reserveChannels( 2 )
   audio.setVolume(0.03, {channel=2})
   audio.play(gameMusic, { channel=2, loops=-1 })


    
    	jumpSound = audio.loadStream("audio/audio_pulando.wav")
    	audio.reserveChannels(3)
    	--audio.play(jumpSound, { channel=3 })

    	dropSound = audio.loadStream("audio/audio_caindo.wav")
    	audio.reserveChannels(4)

    	runningSound = audio.loadStream("audio/audio_correndo.wav")
    	audio.reserveChannels(5)


    function moveOlofote( )
    	olofote.x = player.x - 7
    	olofote.y = -200
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
		--timerr = timer.performWithDelay(1, createCity, 0)
		timerr = timer.performWithDelay(1, createCity, -1)
		timerOfCreateBulding = timer.performWithDelay(1500, createBuilding, 0)
		timerOfDestroyBulding = timer.performWithDelay(4000, destroyBuilding, 0)
		Runtime:addEventListener("enterFrame", endGame)
		timerCreateCamera = timer.performWithDelay(6000, createCamera, 0)
		timerMoveCamera = timer.performWithDelay(7000, moveCamera, 0)
		timerDestroyCamera = timer.performWithDelay(1000, destroyCamera, 0)
		Runtime:addEventListener("collision", collisionCam)

			
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
	
	display.remove(backGroup)
    display.remove(mainGroup)
    display.remove(uiGroup)
    timer.cancel( timerOfCreateBulding )
    timer.cancel( timerOfDestroyBulding )
    timer.cancel( timerr )
    timer.cancel(timerCreateCamera)
    timer.cancel(timerMoveCamera)
    timer.cancel(timerDestroyCamera)

		

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		audio.stop(2)
		audio.stop(5)
		jump:removeEventListener( "touch", touchAction )
		player:removeEventListener( "collision" )
		Runtime:removeEventListener("enterFrame", endGame)
		physics.pause()
		composer.removeScene("game")

		
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
