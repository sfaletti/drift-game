class Body {
	PVector position, velocity, acceleration;
	float bodySize;
	float vMax;
	boolean isColliding;
	Body (PVector _position) {
		position = _position;
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
		bodySize = 15;
		vMax = 5;
		isColliding = false;
	}

	void display () {
		ellipseMode(CENTER);
		fill(0);
		if (isColliding) fill(255, 0, 0);
		noStroke();
		ellipse(position.x, position.y, bodySize, bodySize);
	}

	void addThrust(int _direction) {
		// println (_direction);
		float aVal = .1;
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
		float drag = .999;
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
		isColliding = false;
	}

	void checkEdge() {
		if (position.x <= bodySize/2 || position.x >= width-(bodySize/2)) velocity.x *= -1;
		if (position.y <= bodySize/2 || position.y >= height-(bodySize/2)) velocity.y *= -1;
	}

	boolean isColliding(PVector tlCorner, PVector brCorner) {
		if ((position.x + (bodySize/2) > tlCorner.x && position.x - (bodySize/2) < brCorner.x) && position.y + (bodySize/2) > tlCorner.y && position.y - (bodySize/2) < brCorner.y ) {
			isColliding = true;
		}
		return isColliding;
	}
}