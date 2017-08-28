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
 


 local background = display.newImageRect("background.png", 1280, 720)
 background.x = display.contentCenterX
 background.y = display.contentCenterY

 local plataforma = display.newImageRect("plataforma.png", 1280, 20)
 plataforma.x = display.contentCenterX
 plataforma.y = display.contentHeight-10
 plataforma.objType = "ground"

 local p1 = display.newImageRect("p1.png", 70, 170)
 p1.x = display.contentWidth-450
 p1.y = display.contentHeight-90
 p1.objType = "ground"

 local p2 = display.newImageRect("p2.png", 70, 190)
 p2.x = display.contentWidth-340
 p2.y = display.contentHeight-115
 p2.objType = "ground"

 local p3 = display.newImageRect("p3.png", 50, 140)
 p3.x = display.contentWidth-240
 p3.y = display.contentHeight-90
 p3.objType = "ground"

 local p4 = display.newImageRect("p4.png", 30, 170)
 p4.x = display.contentWidth-170
 p4.y = display.contentHeight-105
 p4.objType = "ground"

 local player = display.newImageRect("player.png", 10, 10)
 player.x = display.contentWidth-470
 player.y = display.contentHeight-200
 player.myName = "player"


 local physics = require("physics")
 physics.start()
 physics.setDrawMode( "hybrid" )

 physics.addBody(plataforma, "static", {bounce=0})
 physics.addBody(p1, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p2, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p3, "static", {bounce=0.0, friction=0.3})
 physics.addBody(p4, "static", {bounce=0.0, friction=0.3})
 physics.addBody( player, "dynamic", {density=0.030, radius=5, bounce=0.0}, { box={ halfWidth=3, halfHeight=10, x=0, y=2}, isSensor=true })

 player.isFixedRotation = true
 player.sensorOverlaps = 0

-- Add left joystick button
local left = display.newRect(0,0,50,50)
left.x = 20
left.y = 280

-- Add right joystick button
local right = display.newRect(0,0,50,50)
right.x = 90 
right.y = 280

-- When left arrow is touched, move character left
function left:touch(event)
  motionx = -speed
end

left:addEventListener("touch",left)

-- When right arrow is touched, move character right
function right:touch()
  motionx = speed
end

right:addEventListener("touch",right)

 -- Move character
 local function movePlayer (event)
  player.x = player.x + motionx;
end

Runtime:addEventListener("enterFrame", movePlayer)

 -- Stop character movement when no arrow is pushed
 local function stop (event)
   if event.phase =="ended" then
   motionx = 0;
 end
end
Runtime:addEventListener("touch", stop )

local jump = display.newRect(0,0,50,50)
jump.x = w - 50
jump.y = 280


local function touchAction( event )

  if ( event.phase == "began" and player.sensorOverlaps > 0 ) then
        -- Jump procedure here
        local vx, vy = player:getLinearVelocity()
        player:setLinearVelocity( vx, 0 )
        player:applyLinearImpulse( nil, -0.04, player.x, player.y )
      end
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

--local function playerJump()
--  player:applyLinearImpulse(0, -0.0015, player.x, player.y)
--end

--jump:addEventListener("touch", playerJump)



