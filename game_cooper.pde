Body myBody;
ArrayList<Obstacle> obstacles;

void setup() {
	size(600, 800);
	myBody = new Body(new PVector(30, 30));
	obstacles = new ArrayList<Obstacle>();
	int minOSize = 10;
	int maxOSize = 50;
	for (int i = 0; i < 35; ++i) {
		PVector rPos = new PVector(random(0, width), random(0, height));
		PVector rSize = new PVector(random(minOSize, maxOSize), random(minOSize, maxOSize));
		obstacles.add(new Obstacle(rPos, rSize));
	}
}

void draw() {
	background(255);
	for (Obstacle obstacle : obstacles) {
		obstacle.display();
		myBody.isColliding(obstacle.tlCorner, obstacle.brCorner);
	}
	myBody.update();
}

void keyPressed() {
	println (keyCode);
	int[] keyMap = {38, 40, 37, 39}; //up, down, left, right
	myBody.addThrust(mapDirection(keyCode, keyMap));
}

int mapDirection (int _keyCode, int[] _keyMap) {
	for (int i = 0; i < _keyMap.length; ++i) {
		if (_keyMap[i] == _keyCode) {
			return i;
		}
	}
	return 200;

}
