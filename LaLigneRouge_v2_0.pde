float echelle = 0.5;
int nombrePotelets = 5;
int nombreVers = 1;
color noir = color(0, 0, 0);
Serveur simu;
Ver v;
PShape salle;
int positionMaitre = 1; //mettre à 2 et modifiée position  dans Ver.pde ligne 23

void setup() {
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100, 100);
  frameRate(30);

  stroke(noir);
  salle = loadShape("1ercycle.svg");
  simu = new Serveur();
  simu.init();
  simu.display();
}

void draw() {
  simu.update();
  simu.display();
}

void dispose() {
  simu.dispose();
  println("Save LIDAR");
}
