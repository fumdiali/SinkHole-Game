-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- remove status bar
display.setStatusBar(display.HiddenStatusBar)

--label
local sinkHole = display.newEmbossedText( "SinkHole", 160, 0, native.systemFont, 40 )
sinkHole:setFillColor( 0.72, 0.9, 0.16, 0.78 )


--get physics engine
local physics = require("physics")
physics.start()

local widget = require( "widget" )

--background music
local bgMusic = audio.loadStream("music.mp3");
--audio.play(bgMusic)

--create balls
local yellowBall = display.newCircle(210,10,10)
yellowBall:setFillColor(1,1,0)
physics.addBody( yellowBall, "dynamic",{density=1.5, friction=1, bounce=1.0,radius=9})
physics.setGravity(0,25)

local redBall = display.newCircle(100,70,15)
redBall:setFillColor(1,0,0)
physics.addBody( redBall, "dynamic",{density=0.4, friction=0, bounce=0.95,radius=12})
physics.setGravity(0,20)

local greenBall = display.newCircle(165,20,16)
--ball.x = 160
--ball.y = 30
greenBall:setFillColor(0,1,0)
physics.addBody( greenBall, "dynamic",{ density=0.5, friction=0, bounce=0.75, radius=10 } )
physics.setGravity(0,30)

--create walls
local leftWall = display.newRect(5,450,1,1050)
physics.addBody(leftWall,"static")

local rightWall = display.newRect(315,450,1,1050)
physics.addBody(rightWall,"static")

--create rudders
local leftRudder = display.newRoundedRect( 70, 350, 90, 20, 12 )
leftRudder.strokeWidth = 3
leftRudder:setFillColor( 0.5 )
leftRudder:setStrokeColor( 1, 0, 0 )
physics.addBody( leftRudder, "static", {density=1.0, friction=0.3 } )

local rightRudder = display.newRoundedRect( 260, 450, 90, 20, 12 )
rightRudder.strokeWidth = 3
rightRudder:setFillColor( 0.5 )
rightRudder:setStrokeColor( 1, 0, 0 )
physics.addBody( rightRudder, "static", {density=1.0, friction=0.3 } )

local topLeftRudder = display.newRoundedRect( 100, 150, 90, 20, 12 )
topLeftRudder.strokeWidth = 3
topLeftRudder:setFillColor( 0.5 )
topLeftRudder:setStrokeColor( 1, 0, 0 )
physics.addBody( topLeftRudder, "static", {density=1.0, friction=0.3 } )

local topRightRudder = display.newRoundedRect( 199, 250, 90, 20, 12 )
topRightRudder.strokeWidth = 3
topRightRudder:setFillColor( 0.5 )
topRightRudder:setStrokeColor( 1, 0, 0 )
physics.addBody( topRightRudder, "static", {density=1.0, friction=0.3 } )



local function flipLeftRudderEvent()
    topLeftRudder:rotate(5)
    leftRudder:rotate(5)
    end

local function flipRightRudderEvent()
    
    rightRudder:rotate(-10)
    
    topRightRudder:rotate(-10)
    end 

--create sliding floors
--local w,h = display.contentWidth, display.contentWidth
local floorLeft = display.newRect(5,480,160,10) 
floorLeft:setFillColor(0,1,1)
transition.to( floorLeft, { x=110,y=480, iterations=0, time=5000 })

physics.addBody(floorLeft,"static") 

local floorRight = display.newRect(310,480,160,10) 
floorRight:setFillColor(0,1,1)
transition.to( floorRight, {x=210,y=480, iterations=0, time=5000})

physics.addBody(floorRight,"static")    

--create buttons
local leftButton = widget.newButton {
    left = 10,
    top = 2,
    width = 50,
    height = 50,
   font = "Helvetica",
   fontSize = 24,
    label = "Left",
    onEvent = flipLeftRudderEvent
}

local rightButton = widget.newButton {
    left = 240,
    top = 2,
    width = 50,
    height = 50,
   font = "Helvetica",
   fontSize = 24,
    label = "Right",
    onEvent = flipRightRudderEvent
}



--[[image re-fitting
local function fitImage( displayObject, fitWidth, fitHeight, enlarge )
	--
	-- first determine which edge is out of bounds
	--
	local scaleFactor = fitHeight / displayObject.height 
	local newWidth = displayObject.width * scaleFactor
	if newWidth > fitWidth then
		scaleFactor = fitWidth / displayObject.width 
	end
	if not enlarge and scaleFactor > 1 then
		return
	end
	displayObject:scale( scaleFactor, scaleFactor )
end

--create sinkhole
local bucket = display.newImage( "images.jpeg" )
bucket.x = 160
bucket.y = 490
 
fitImage( bucket, 70, 80, false )
physics.addBody(bucket,"static")--]]


