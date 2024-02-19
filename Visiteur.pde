class Visiteur extends Objet {
  Visiteur() {
    position = new PVector(random(width), random(height));
  }
  
  void update() {
    position.x += random(-10,10);
    position.y += random(-10,10);
  }
  
  void display() {
    fill(noir);
    noStroke();
    ellipse(position.x, position.y, 10, 10);
  }
}

class Mouse extends Visiteur {
  Mouse() {
    position = new PVector(mouseX, mouseY);
  }
  
  void update() {
    position.x = mouseX;
    position.y = mouseY;
  }

  void display() {
    fill(0);
    noStroke();
    ellipse(position.x, position.y, 10, 10);
  }
}
