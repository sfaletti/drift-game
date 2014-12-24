class Obstacle {
	PVector position, obstacleSize, tlCorner, brCorner;
	Obstacle (PVector _position, PVector _obstacleSize) {
		position = _position;
		obstacleSize = _obstacleSize;
		tlCorner = position;
		brCorner = PVector.add(position, obstacleSize);
	}

	void display() {
		fill(50, 255, 50);
		rect(position.x, position.y, obstacleSize.x, obstacleSize.y);
	}
}