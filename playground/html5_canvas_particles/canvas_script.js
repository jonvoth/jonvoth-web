//Setup properties
var SCREEN_WIDTH = window.innerWidth,
SCREEN_HEIGHT = window.innerHeight,

stage_canvas, stage_context,

mouseX = 0, mouseY = 0,

particles = [],
MAX_PARTICLES = 150;



function init(){	
	//Get canvas and context
	if(document.getElementById('cnv_stage') != null){
		stage_canvas = document.getElementById('cnv_stage');
		
		//Set stage to full browser
		stage_canvas.width = SCREEN_WIDTH;
		stage_canvas.height = SCREEN_HEIGHT;
	
		if (stage_canvas.getContext){
			stage_context = stage_canvas.getContext('2d');
		}
	}
	
	//Listen for mouse move
	$(document).mousemove(function(e){
		if (e.pageX != undefined && e.pageY != undefined) { 
			mouseX = e.pageX;
			mouseY = e.pageY;
		} else { 
			mouseX = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft; 
			mouseY = e.clientY + document.body.scrollTop + document.documentElement.scrollTop; 
		}
		
		//Offset for canvas position
		mouseX -= stage_canvas.offsetLeft;
		mouseY -= stage_canvas.offsetTop;
	}); 
	
	//Setup timer tick
	setInterval(onTick, 1000/30);
}


function onTick() {
	//Create particles
	makeParticle(4);
	
	// clear the canvas by drawing
	stage_context.fillStyle="rgb(0,0,0)";
	stage_context.fillRect(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
	// OR by resetting size
	//stage_canvas.width = SCREEN_WIDTH;
	//stage_canvas.height = SCREEN_HEIGHT;
	
	// iteratate through each particle
	for (i=0; i<particles.length; i++){
		var particle = particles[i]; 
		
		// render it
		particle.render(stage_context); 
		
		// and then update. We always render first so particle
		// appears in the starting point.
		particle.update();
	}
	
	// Keep taking the oldest particles away until we have 
	// fewer than the maximum allowed. 
	 
	while(particles.length > MAX_PARTICLES) {
		particles.shift();
	}
}

function makeParticle(particleCount) {
	for(var i=0; i<particleCount;i++) {
		// create a new particle in the middle of the stage
		var particle = new Particle(mouseX, mouseY); 
		
		// give it a random x and y velocity
		particle.velX = (Math.random()*20)-10;
		particle.velY = (Math.random()*20)-10;
		
		//Set particle params
		particle.size = 6;
		particle.drag = 0.96;
		particle.gravity = 0.5; 
		particle.fade = .025;
		
		
		//Calculate and set color (Blue: 23,120,230)
		var perX = mouseX / SCREEN_WIDTH;
		var perY = mouseY / SCREEN_HEIGHT;
		var centerPerX = mouseX / (mouseX - (SCREEN_WIDTH * .5));
		var centerPerY = mouseY / (mouseY - (SCREEN_HEIGHT * .5));
		particle.color_r = 50 + Math.floor(centerPerX * 205);
		particle.color_g = 50 + Math.floor(((perX + perY) / 2) * 205);
		particle.color_b = 50 + Math.floor(centerPerY * 205);
		
		//Show color values
		document.getElementById('output').innerHTML = "RGB: "+particle.color_r+","+particle.color_g+","+particle.color_b;
		document.getElementById('output').style.color = "rgb("+particle.color_r+","+particle.color_g+","+particle.color_b+")";
		
		// add it to the array
		particles.push(particle); 
	}
}