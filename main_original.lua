-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--Hide status bar from the beginning
display.setStatusBar( display.HiddenStatusBar )
system.activate( "multitouch" )

local w = display.contentWidth
local h = display.contentHeight
 motionx = 0 -- Variable used to move character along x axis
 speed = 2 -- Set Walking Speed
 


 local background = display.newImageRect("background2.png", 1920, 1280)
background.x = display.contentCenterX
background.y = display.contentCenterY
 local jump = display.newImageRect("fundo_transparente.png", 1280, 720)
 



 local p1 = display.newImageRect("predio1.png", 70, 170)
 p1.x = display.contentWidth-420
 p1.y = display.contentHeight-90
 p1.objType = "ground"

 local p2 = display.newImageRect("predio2.png", 70, 190)
 p2.x = display.contentWidth-310
 p2.y = display.contentHeight-115
 p2.objType = "ground"

 local p3 = display.newImageRect("predio4.png", 50, 140)
 p3.x = display.contentWidth-210
 p3.y = display.contentHeight-90
 p3.objType = "ground"

 local p4 = display.newImageRect("predio3.png", 30, 170)
 p4.x = display.contentWidth-140
 p4.y = display.contentHeight-105
 p4.objType = "ground"

 local p5 = display.newImageRect("predio2.png", 30, 170)
 p5.x = display.contentWidth-100
 p5.y = display.contentHeight-115
 p5.objType = "ground"

 local p6 = display.newImageRect("predio4.png", 60, 170)
 p6.x = display.contentWidth-50
 p6.y = display.contentHeight-90
 p6.objType = "ground"

 local p7 = display.newImageRect("predio1.png", 10, 170)
 p7.x = display.contentWidth-0
 p7.y = display.contentHeight-90
 p7.objType = "ground"

 local plataforma = display.newImageRect("plataforma.png", 1280, 20)
 plataforma.x = display.contentCenterX
 plataforma.y = display.contentHeight-10
 plataforma.objType = "ground"

 local player = display.newImageRect("player.png", 10, 10)
 player.x = display.contentWidth-470
 player.y = display.contentHeight-200
 player.myName = "player"


 local physics = require("physics")
 physics.start()
 
 

 physics.addBody(plataforma, "static", {bounce=0})
 physics.addBody(p1, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p2, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p3, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p4, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p5, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p6, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p7, "static", {bounce=0.0, friction=0.3})
 physics.addBody( player, "dynamic", {density=0.030, radius=5, bounce=0.0}, { box={ halfWidth=3, halfHeight=10, x=0, y=2}, isSensor=true })

 player.isFixedRotation = true
 player.sensorOverlaps = 0


local holding = false

local function enterFrameListener()
    if holding then
        local vx, vy = player:getLinearVelocity()
        player:setLinearVelocity( vx, 0 )
        player:applyLinearImpulse( 0.00003, -0.020, player.x, player.y )
    else
        
    end
end


local function touchAction( event )

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
    
         
    jump:addEventListener( "touch", touchAction )

    local function sensorCollide( self, event )

    -- Confirm that the colliding elements are the foot sensor and a ground object
    if ( event.selfElement == 2 and event.other.objType == "ground" ) then

        -- Foot sensor has entered (overlapped) a ground object
        if ( event.phase == "began" ) then
          self.sensorOverlaps = self.sensorOverlaps + 1
        -- Foot sensor has exited a ground object
        elseif ( event.phase == "ended" ) then
        self.sensorOverlaps = self.sensorOverlaps - 1
      end
    end
  end


-- Associate collision handler function with character
player.collision = sensorCollide
player:addEventListener( "collision" )

local rand
local obstacleNumber

local function update( event )

--updateBackgrounds will call a function made specifically to handle the background movement
    updateBackgrounds()
end

function updateBackgrounds()

    rand = math.random
    obstacleNumber = rand(4)

    if(obstacleNumber == 1) then
        print (obstacleNumber)
    elseif(obstacleNumber == 2) then
        print(obstacleNumber)
    elseif( obstacleNumber == 3) then
        print (obstacleNumber)
    elseif( obstacleNumber == 4) then
        print (obstacleNumber)
    end


    --background movement
    
    p1.x = p1.x - (1)
    p2.x = p2.x - (1)
    p3.x = p3.x - (1)
    p4.x = p4.x - (1)
    p5.x = p5.x - (1)
    p6.x = p6.x - (1)
    p7.x = p7.x - (1)




    --if the sprite has moved off the screen move it back to the
    --other side so it will move back on
   

    if(p1.x < -239) then
        p1.x = 400
    end

    if(p2.x < -239) then
        p2.x = 400
    end

    if(p3.x < -239) then
        p3.x = 400
    end

    if(p4.x < -239) then
        p4.x = 400
    end

    if(p5.x < -239) then
        p5.x = 400
    end

    if(p6.x < -239) then
        p6.x = 400
    end

    if(p7.x < -239) then
        p7.x = 400
    end
end

timer.performWithDelay(1, update, -1)


  