io.stdout:setvbuf("no")

function love.load()
	
	love.window.setMode(0, 0, {fullscreen=true})
	tailleXecran = love.graphics.getWidth()
	tailleYecran = love.graphics.getHeight()


	tailleBordure = 10
	love.physics.setMeter(64) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

	objects = {} -- table to hold all our physical objects

	love.graphics.setBackgroundColor(1, 1, 1) --set the background color
	love.window.setMode(tailleXecran, tailleYecran) --set the window dimensions

	objects.sol = {}
	objects.sol.body = love.physics.newBody(world, tailleXecran/2, tailleYecran-tailleBordure/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.sol.shape = love.physics.newRectangleShape(tailleXecran, tailleBordure) --make a rectangle with a width of 650 and a height of 50
	objects.sol.fixture = love.physics.newFixture(objects.sol.body, objects.sol.shape); --attach shape to body 
  
	objects.plafond = {}
	objects.plafond.body = love.physics.newBody(world, tailleXecran/2, 0+tailleBordure/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.plafond.shape = love.physics.newRectangleShape(tailleXecran, tailleBordure) --make a rectangle with a width of 650 and a height of 50
	objects.plafond.fixture = love.physics.newFixture(objects.plafond.body, objects.plafond.shape); --attach shape to body 
  
	objects.cotegauche = {}
	objects.cotegauche.body = love.physics.newBody(world, tailleBordure/2, tailleYecran/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.cotegauche.shape = love.physics.newRectangleShape(tailleBordure, tailleYecran-tailleBordure-tailleBordure) --make a rectangle with a width of 650 and a height of 50
	objects.cotegauche.fixture = love.physics.newFixture(objects.cotegauche.body, objects.cotegauche.shape); --attach shape to body   

	objects.cotedroit = {}
	objects.cotedroit.body = love.physics.newBody(world, tailleXecran-tailleBordure/2, tailleYecran/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.cotedroit.shape = love.physics.newRectangleShape(tailleBordure, tailleYecran-tailleBordure-tailleBordure) --make a rectangle with a width of 650 and a height of 50
	objects.cotedroit.fixture = love.physics.newFixture(objects.cotedroit.body, objects.cotedroit.shape); --attach shape to body 
end
 
 
function love.update(dt)

	world:update(dt) 
	
end
 
function love.draw()
	
	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.sol.body:getWorldPoints(objects.sol.shape:getPoints()))
	love.graphics.polygon("fill", objects.plafond.body:getWorldPoints(objects.plafond.shape:getPoints()))
	love.graphics.polygon("fill", objects.cotegauche.body:getWorldPoints(objects.cotegauche.shape:getPoints()))
	love.graphics.polygon("fill", objects.cotedroit.body:getWorldPoints(objects.cotedroit.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinate
  
end