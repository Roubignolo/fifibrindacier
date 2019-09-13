io.stdout:setvbuf("no")

function charge()

pi =    3.14159265359
	pisur2 =1.57079632679

	
	tailleBordure = 1
	love.physics.setMeter(64) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

	

	-- creation des images
	caisseImage = love.graphics.newImage("caisse_100_100.png")
	pipiImage = love.graphics.newImage("pipi.png")
	pipiImage2 = love.graphics.newImage("pipi2.png")
	metalImage = love.graphics.newImage("metal.png")
	fritesImage = love.graphics.newImage("frites.png")
	
	objects = {} -- table to hold all our physical objects
	cacas = {} -- table to hold all our physical objects
	
	fritesVisibles = true
	nbCacas = 0
	energie = 100
	faitcaca =false
	fini = false
	-- creation des bordures physiques du world
	
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
	
	-- creation des objets
	

	objects.caisse = {}
	objects.caisse.body = love.physics.newBody(world, 250, 50, "dynamic")
	objects.caisse.shape = love.physics.newRectangleShape(100, 100)
	objects.caisse.fixture = love.physics.newFixture(objects.caisse.body, objects.caisse.shape, 3)	


	
	objects.caisse2 = {}
	objects.caisse2.body = love.physics.newBody(world, 850, 50, "dynamic")
	objects.caisse2.shape = love.physics.newRectangleShape(100, 100)
	objects.caisse2.fixture = love.physics.newFixture(objects.caisse2.body, objects.caisse2.shape, 3)

	objects.caisse3 = {}
	objects.caisse3.body = love.physics.newBody(world, 450, 250, "dynamic")
	objects.caisse3.shape = love.physics.newRectangleShape(0, 0, 100, 100)
	objects.caisse3.fixture = love.physics.newFixture(objects.caisse3.body, objects.caisse3.shape, 3)

	objects.frites = {}
	objects.frites.body = love.physics.newBody(world, 450, 250, "static")
	objects.frites.shape = love.physics.newRectangleShape(0, 0, 128, 170)
	objects.frites.fixture = love.physics.newFixture(objects.frites.body, objects.frites.shape, 3)
	objects.frites.body:setActive( fritesVisibles )
	
		--let's create a fifi
	objects.fifi = {}
	objects.fifi.body = love.physics.newBody(world, 500, 100, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	objects.fifi.shape = love.physics.newCircleShape( 32 )
	objects.fifi.fixture = love.physics.newFixture(objects.fifi.body, objects.fifi.shape, 3) -- Attach fixture to body and give it a density of 1.
	objects.fifi.fixture:setRestitution(0.2) --let the fifi bounce
	 
	

end

function love.load()
	
		
	love.window.setMode(0, 0, {fullscreen=true})
	tailleXecran = love.graphics.getWidth()
	tailleYecran = love.graphics.getHeight()
	love.graphics.setBackgroundColor(1, 1, 1) --set the background color
	love.window.setMode(tailleXecran, tailleYecran) --set the window dimensions
	
	charge()
	
end


function checkCollision()

    --With locals it's common usage to use underscores instead of camelCasing
    local frites_left = objects.frites.body:getX() - 64 - 5
    local frites_right = objects.frites.body:getX() +64 +5
    local frites_top = objects.frites.body:getY() - 85 -5
    local frites_bottom = objects.frites.body:getY() +85 +5

    local fifi_left = objects.fifi.body:getX()-32
    local fifi_right = objects.fifi.body:getX()+32
    local fifi_top = objects.fifi.body:getY()-32
    local fifi_bottom = objects.fifi.body:getY()+32

    --If Red's right side is further to the right than Blue's left side.
    if fritesVisibles and
	
	frites_right > fifi_left and
    --and Red's left side is further to the left than Blue's right side.
    frites_left < fifi_right and
    --and Red's bottom side is further to the bottom than Blue's top side.
    frites_bottom > fifi_top and
    --and Red's top side is further to the top than Blue's bottom side then..
    frites_top < fifi_bottom then
        --There is collision!
        return true
    else
        --If one of these statements is false, return false.
        return false
    end
end
 
function love.update(dt)

	world:update(dt)
	
	-- if ( math.sqrt((objects.fifi.body:getY() - objects.frites.body:getY())*(objects.fifi.body:getY() - objects.frites.body:getY()) + (objects.fifi.body:getX() - objects.frites.body:getX())*(objects.fifi.body:getX() - objects.frites.body:getX())) <= (32+64) )then
	
	
	if checkCollision() then 
		fritesVisibles = false
		-- objects.frites.body:setActive( fritesVisibles )
		energie = energie +	100
		if objects.frites.body:getX() == 450 then
			objects.frites.body:setX(1000)
			objects.frites.body:setY(300)
		else
			objects.frites.body:setX(450)
			objects.frites.body:setY(250)
		
		
		end
		
	else
		fritesVisibles = true
	end
	
		
	tempvx, tempvy = objects.fifi.body:getLinearVelocity()
	tempangle = objects.fifi.body:getAngle()
	
	if love.keyboard.isDown("right") then --press the right arrow key to push the fifi to the right
	
		objects.fifi.body:setAngle(tempangle+0.03)
		
	elseif love.keyboard.isDown("left") then --press the left arrow key to push the fifi to the left
	
		objects.fifi.body:setAngle(tempangle-0.03)		

	elseif love.keyboard.isDown("space") then --press the left arrow key to push the fifi to the left
		
		if energie >= 1 then
			
			faitcaca=true
			energie = energie - 1
			nbCacas = nbCacas + 1
			newmachin = {} 
			newmachin.body = love.physics.newBody(world, objects.fifi.body:getX()+32*math.cos(objects.fifi.body:getAngle()+pisur2), objects.fifi.body:getY()+32*math.sin(objects.fifi.body:getAngle()+pisur2), "dynamic")
			newmachin.shape = love.physics.newRectangleShape(10, 30)
			newmachin.fixture = love.physics.newFixture(newmachin.body, newmachin.shape, 2)
			
			table.insert(cacas,newmachin)
		
			objects.fifi.body:applyForce(3000*math.sin(objects.fifi.body:getAngle()), -3000*math.cos(objects.fifi.body:getAngle()))
			love.graphics.setBackgroundColor(1, 1, 1)
			
		end
	else
		faitcaca = false

	end
	
	if energie == 0 and tempvx*tempvx <= 0.4 and tempvy*tempvy <= 0.4 then
	
		fini = true
	
	end

	
	if fini then
	
		
		if love.keyboard.isDown('q') then
			love.graphics.clear( )
			charge()
			fini = false
			end 
	end
	

end
 
function love.draw()

	-- Score
	love.graphics.setColor(1, 0, 0)
	love.graphics.print("ENERGIE : " .. energie,10,0)
	love.graphics.print("  SCORE : " .. nbCacas,10,10)
	
	love.graphics.setColor(0, 0, 0) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.sol.body:getWorldPoints(objects.sol.shape:getPoints()))
	love.graphics.polygon("fill", objects.plafond.body:getWorldPoints(objects.plafond.shape:getPoints()))
	love.graphics.polygon("fill", objects.cotegauche.body:getWorldPoints(objects.cotegauche.shape:getPoints()))
	love.graphics.polygon("fill", objects.cotedroit.body:getWorldPoints(objects.cotedroit.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinate
  
	-- dessin des bordures
	
	love.graphics.setColor(1, 1, 1)
	
	
	love.graphics.draw(caisseImage, objects.caisse.body:getX(),  objects.caisse.body:getY(), objects.caisse.body:getAngle(),1 ,1 , 50,50,0,0)
	love.graphics.draw(caisseImage, objects.caisse2.body:getX(),  objects.caisse2.body:getY(), objects.caisse2.body:getAngle() ,1 ,1 , 50,50,0,0)
	love.graphics.draw(caisseImage, objects.caisse3.body:getX(),  objects.caisse3.body:getY(), objects.caisse3.body:getAngle() ,1 ,1 , 50,50,0,0)
	
	if objects.frites.body:isActive( ) then love.graphics.draw(fritesImage, objects.frites.body:getX(),  objects.frites.body:getY(), objects.frites.body:getAngle() ,1 ,1 , 64,85,0,0) end
	
	if faitcaca then
		love.graphics.draw(pipiImage2,objects.fifi.body:getX(), objects.fifi.body:getY(),objects.fifi.body:getAngle(),1 ,1 , 64,32,0,0)
	else
		love.graphics.draw(pipiImage,objects.fifi.body:getX(), objects.fifi.body:getY(),objects.fifi.body:getAngle(),1 ,1 , 64,32,0,0)
	end
	
	if nbCacas ~= 0 then    
		for i=1,#cacas do
			love.graphics.setColor(1, 1, 1)
			love.graphics.draw(metalImage,cacas[i].body:getX(), cacas[i].body:getY(),cacas[i].body:getAngle(),1 ,1 , 5,15,0,0)
		end
	end
	
	if fini then
		love.graphics.setColor(1, 0, 0)
		love.graphics.print("BRAVO ! TON SCORE (DE MERDE) EST DE ".. nbCacas .." !",tailleXecran/2 -20 ,tailleYecran/2 -30)
		love.graphics.print("Prends en photo ton écran et envoie ton score à DANBISS et DANBOSS",tailleXecran/2 -20 ,tailleYecran/2 -10)
		love.graphics.print("Canard PC au 14 rue Soleillet, 75020 PARIS",tailleXecran/2 -20 ,tailleYecran/2 -0)
		love.graphics.print("Appuie sur ton Q pour rejouer",tailleXecran/2 -20 ,tailleYecran/2 +30)
	
	
	end
	

end