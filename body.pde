class Body {
	PVector position, velocity, acceleration;
	float bodySize;
	float vMax;
	boolean isColliding;
	PImage[] bodyImages = new PImage[5];
	int imageVal;
	int thrustLength;
	boolean collisionFlag;
	Body (PVector _position) {
		position = _position;
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
		bodySize = 50;
		vMax = 5;
		isColliding = false;
		String[] imgList = {"up", "down", "left", "right", "none"};
		for (int i = 0; i < 5; ++i) {
			String imageName = "ship-"+imgList[i]+".png";
			bodyImages[i] = loadImage(imageName);
		}
		imageVal = 4;
		thrustLength = 0;
		collisionFlag = false;
	}

	void display () {
		pushMatrix();
		translate(position.x, position.y);
		imageMode(CENTER);
		image(bodyImages[imageVal], 0, 0, bodySize, bodySize);
		popMatrix();
	}

	void addThrust(int _direction) {
		// println (_direction);
		float aVal = .1;
		imageVal = _direction;
		thrustLength = 20;
		switch (_direction) {
			// up arrow is 0
			case 0: 
			acceleration.y -= aVal;
			return;
			// down arrow is 1
			case 1: 
			acceleration.y += aVal;
			return;
			//left arrow is 2
			case 2: 
			acceleration.x -= aVal;
			return;
			//right arrow is 3
			case 3: 
			acceleration.x += aVal;
			return;
		}
	}

	void move() {
		float drag = 1;
		velocity.x += acceleration.x;
		velocity.y += acceleration.y;
		if (velocity.x > vMax) velocity.x = vMax;
		if (velocity.y > vMax) velocity.y = vMax;
		position.x += velocity.x;
		position.y += velocity.y;
		velocity.x *= drag;
		velocity.y *= drag;
		acceleration.x = 0;
		acceleration.y = 0;
	}

	void update() {
		move();
		checkEdge();
		display();
		if (thrustLength > 0) thrustLength --;
		if (thrustLength == 0) imageVal = 4;

	}

	void checkEdge() {
		if (position.x <= bodySize/2 || position.x >= width-(bodySize/2)) velocity.x *= -1;
		if (position.y <= bodySize/2 || position.y >= height-(bodySize/2)) velocity.y *= -1;
	}

	void givePenalty() {
		if (!collisionFlag && isColliding && bodySize < 200) {
			// bodySize *= 1.1;
			collisionFlag = true;
			// println("bodySize: "+bodySize +", frame:"+frameCount);
		}
	}

	void checkCollisions(ArrayList<Obstacle> _obstacles) {
		for (Obstacle o : _obstacles) {
			if (isColliding(o.tlCorner, o.brCorner)) {
				isColliding = true;
				return;
			}
		}
	}

	boolean isColliding(PVector tlCorner, PVector brCorner) {
		isColliding = false;
		if ((position.x + (bodySize/2) > tlCorner.x && position.x - (bodySize/2) < brCorner.x) && position.y + (bodySize/2) > tlCorner.y && position.y - (bodySize/2) < brCorner.y ) {
			isColliding = true;
			givePenalty();
		}
		else collisionFlag = false;
		return isColliding;
	}
}