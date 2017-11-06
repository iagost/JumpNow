
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

 --[[local p9 = display.newImageRect(mainGroup, objectSheet, 4, 20, 170)
 p9.x = display.contentWidth+100
 p9.y = display.contentHeight-90
 p9.objType = "ground"
]]
 local plataforma = display.newImageRect(mainGroup, "plataforma.png", 1280, 20)
 plataforma.x = display.contentCenterX
 plataforma.y = display.contentHeight-10
 plataforma.objType = "ground"

 scoreName = display.newText("Score: ", display.contentWidth-435, 20, 'Helvetica', 25 )
 uiGroup:insert(scoreName)
 scoreText = display.newText(score, display.contentWidth-390, 20, 'Helvetica', 25 )
 uiGroup:insert(scoreText)

 --	player = display.newImageRect(uiGroup, spritesPlayer, 7, 15, 15)
 player = display.newSprite(uiGroup, spritesPlayer, sequenceSprite)
 player:scale(0.7, 0.7)
 player.anchorX = 1;
 player.x = display.contentWidth-450
 player.y = display.contentHeight-200
 player.myName = "player"
 mainGroup:insert( player )
 runAnimation()

 physics.addBody(plataforma, "static", {bounce=0})
 
 physics.addBody(p1, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p2, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p3, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p4, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p5, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p6, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p7, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p8, "static", {bounce=0.0, friction=100})
 --physics.addBody(p9, "static", {bounce=0.0, friction=0.3})

 physics.addBody( player, "dynamic", {density=0.030, radius=8, bounce=0.0}, { box={ halfWidth=3, halfHeight=10, x=0, y=2}, isSensor=true })

 player.isFixedRotation = true
 player.sensorOverlaps = 0


--player:player()

holding = false

local function enterFrameListener()
    if holding then
        local vx, vy = player:getLinearVelocity()
        player:setLinearVelocity( vx, 0 )
        player:applyLinearImpulse( 0.00000, -0.030, player.x, player.y )
        
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
      end
    end
    return true
end 
    
    function sensorCollide( self, event )

    -- Confirm that the colliding elements are the foot sensor and a ground object
    if ( event.selfElement == 2 and event.other.objType == "ground" ) then
    		audio.play(runningSound, {channel=5})
        -- Foot sensor has entered (overlapped) a ground object
        if ( event.phase == "began" ) then
          self.sensorOverlaps = self.sensorOverlaps + 1
          showScore()
          
          audio.play(runningSound, {channel=5})
          audio.play(dropSound, { channel=3 })
         	
          runAnimation()
        -- Foot sensor has exited a ground object
        elseif ( event.phase == "ended" ) then
        self.sensorOverlaps = self.sensorOverlaps - 1
        --dropAnimation()
 		audio.stop(5)
      end

    end
  end

--[[function createCity()
	transition.to( p7, { time=13000, x=(-100) } )
	transition.to( p6, { time=11500, x=(-100) } )
	transition.to( p5, { time=10000, x=(-100) } )
	transition.to( p4, { time=9500, x=(-100) } )
	transition.to( p3, { time=8500, x=(-100) } )
	transition.to( p2, { time=5500, x=(-100) } )
	transition.to( p1, { time=3000, x=(-100) } )

end
]]


function createBuilding()
	rand = math.random
  	buildingNumber = rand(4)

    if(buildingNumber == 1) then
	
		width = 70
		height = 170
    elseif(buildingNumber == 2) then
        
        width = 45
		height = 140
    elseif( buildingNumber == 3) then
        
        width = 25
		height = 140
    elseif( buildingNumber == 4) then
    
        width = 55
		height = 110
    end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

    building = display.newImageRect( mainGroup, objectSheet, buildingNumber, width, height)
    building.x = display.contentWidth+80
	building.y = display.contentHeight-90
    table.insert(buildingtable, building )
    physics.addBody(building, "dynamic", {bounce=0.0, friction=0.3} )
    building.myName = "building"
    building.objType = "ground"
    buildingCounter = buildingCounter + 1
  --  moveBuilding(building)
    print(buildingCounter)
    
    return building
end
--move the buildings
--function moveBuilding(building)

--	transition.to( building, { time=13000, x=(-100) } )
	
--end
--Remove buldiings from table
function destroyBuilding()
	

	 for i = #buildingtable,1,-1 do
	 	
	 	if(buildingtable[i].x < -50) then
	 	

	 		display.remove(buildingtable[i])
	 		table.remove(buildingtable, i)
	 		buildingCounter = buildingCounter - 1

	 	end
	 end
	print(buildingCounter)
	
end


--params for modal
	



function endGame()
	if(player.y >= 250) then
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
end

function moveBuilding()

	for i = 1,#buildingtable,1 do
	 	local predio = buildingtable[i]
	 	predio.x = predio.x - 1 
	 end
    

    --background movement
	--local predio
	--predio = valorDinamico

	--[[if( p1 ~= nil ) then
	p1.x = p1.x - (1)
	end
	if( p2 ~= nil ) then
		p2.x = p2.x - (1)
	end
	if( p3 ~= nil ) then
		p3.x = p3.x - (1)
	end
	if( p4 ~= nil ) then
		p4.x = p4.x - (1)
	end
    if( p5 ~= nil ) then
		p5.x = p5.x - (1)
	end
	if( p6 ~= nil) then
		p6.x = p6.x - (1)
	end
	if( p7 ~= nil) then
		p7.x = p7.x - (1)
	end
]]
    --if the sprite has moved off the screen move it back to the
    --other side so it will move back on
   
end
 	gameMusic = audio.loadStream("audio/Locked_Out.mp3")  
   audio.reserveChannels( 2 )
   audio.setVolume(0.03, {channel=2})
   audio.play(gameMusic, { channel=2, loops=-1 })


    
    	jumpSound = audio.loadSound("audio/audio_pulando.mp3")
    	audio.reserveChannels(3)
    	--audio.play(jumpSound, { channel=3 })

    	dropSound = audio.loadSound("audio/audio_caindo.mp3")
    	audio.reserveChannels(4)

    	runningSound = audio.loadSound("audio/audio_correndo.mp3")
    	audio.reserveChannels(5)

   

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
