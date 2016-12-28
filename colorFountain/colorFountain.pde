ArrayList<Particle> system;
int count = 200;
PVector origin = new PVector(mouseX, mouseY);

void setup() {
  size(640, 640);
  system = new ArrayList<Particle>();
}

class Particle {
  float life;
  PVector acceleration;
  PVector position;
  PVector speed;

  // constructor
  // given the position of the particle.
  Particle(PVector p, float acc) {
    life = 255.0; // measure life as brightness
    acceleration = new PVector(0, acc);
    speed = new PVector(random(-1,1), random(-2,0));;
    position = p.copy();
  }

  // Method to update position
  void update() {
    life -= 1.0;
    speed.add(acceleration);
    position.add(speed);
  }

  // Method to display
  void display(int r, int g, int b, int size) {
    stroke(r,g,b, life);
    fill(r,g,b, life);
    ellipse(position.x, position.y, size, size);
  }

  // Check if the particle has dead. (if yes, erase)
  boolean dead() {
    return (life < 0.0);
  }
}

void addParticle(PVector p, float acc){
  system.add(new Particle(p, acc));
}

void run() {
    for (int i = system.size()-1; i >= 0; i--) {
      Particle p = system.get(i);
      p.update();
      p.display((int)random(255), (int)random(255), (int)random(255),10);
      // avoid memory overflow
      if (p.dead()) {
        system.remove(i);
      }
    }
}
  
void draw() {
  background(0);
  origin = new PVector(mouseX, mouseY);
  //for(int i = 0; i<count; i++){
  addParticle(origin,0.08);
  //}
  run();
}