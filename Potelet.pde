import java.util.Date;
import java.text.SimpleDateFormat;
///////////////////////////////////////////////////////////////////////////
//
// Potelet = potelet "esclave"
// - position/angle/vitesse
// - les infos relatives au ver (identifiant, potelet maître, voisins)
// - les capteurs ultrasons et infrarouges
//
///////////////////////////////////////////////////////////////////////////
class Potelet extends ObjetConnecte {
  PVector posEstimee;     // la position estimée du potelet
  float angleEstime;      // l'angle estimé
  float rayon;            // le rayon du potelet
  float diametre;         // le diametre du potelet
  float vitesse;          // la vitesse du potelet

  Potelet next, prev;     // les potelets auxquels il est attaché
  Potelet maitre;         // le potelet maitre du ver
  int id;                 // l'identifiant du potelet
  int ver;                // l'identifiant du ver

  US us;                  // le capteur Ultra Son
  IR[] ir;                // les capteurs Infra Rouge

  Scene scene;            // la représentation de la scène
  boolean flat;

  Potelet() {
  }

  Potelet(float x, float y, float r, float a) {
    super();
    id = simu.nbPotelets;
    position = new PVector(x, y);
    posEstimee = new PVector(x, y);
    rayon = r;
    diametre = 2 * r;
    angle = a;
    vitesse = 0;

    us = new US(this, 0, rayon);
    ir = new IR[5];
    for (int i=0; i<ir.length; i++)
      ir[i] = new IR(this, 60*(i+1), rayon);
  }

  void init(Potelet precedent, Potelet suivant, Potelet master, int v) {
    prev = precedent;
    next = suivant;
    maitre = master;
    ver = v;
  }

  void updateFlat() {
    flat = false;
    if ((prev != null) && (next != null)) {
      float h1 = towards(prev);
      float h2 = towards(next);
      flat = ((h2 - h1 + TWO_PI) % TWO_PI == PI);
    }
  }

  void update() {
    us.updatePosition();
    us.update();
    for (int i=0; i<ir.length; i++){
      ir[i].updatePosition();
      ir[i].update();
    }

    float[] args = {posEstimee.x, posEstimee.y};
    sendMessage(POSITION, id, -1, args);
  }

  void display() {
    us.display();
    for (int i=0; i<ir.length; i++)
      ir[i].display();

    noStroke();
    fill(0, 100);
    ellipse(position.x, position.y, diametre * echelle, diametre * echelle);
    fill(128, 100);
    ellipse(position.x, position.y, 10 * echelle, 10 * echelle);
  }
  
  // ne représente que la base qui sera perçue par les LIDAR, IR et US
  void virtualDisplay() {
    noStroke();
    fill(0);
    ellipse(position.x, position.y, diametre * echelle, diametre * echelle);
  }

  void saveJSON(){

  }
}

///////////////////////////////////////////////////////////////////////////
//
// Potelet = potelet "maître" = potelet esclave + LIDARs
// - les capteurs LIDAR motorisés
//
///////////////////////////////////////////////////////////////////////////
class PoteletMaitre extends Potelet {
  LIDAR[] lidar;            // les LIDAR
  StringList valLIDAR;
  SimpleDateFormat formater;
  int[][] deg;

  PoteletMaitre(float x, float y, float r, float a) {
    super(x, y, r, a);

    lidar = new LIDAR[3];
    for (int i=0; i<lidar.length; i++)
      lidar[i] = new LIDAR(this, 60 + 120*i, rayon);
    /////////////////////////
    valLIDAR = new StringList();
    formater = new SimpleDateFormat("HH:mm:ss.SSS");
    deg = new int[3][121];
  }

  void update() {
    super.update();
    for (int i=0; i<lidar.length; i++){
      lidar[i].updatePosition();
      if (deg[i][int(lidar[i].dev)]==0){
        int[] l = {int(lidar[i].dev), i, int(lidar[i].mesure), 10000+int(lidar[i].mesure)};
        valLIDAR.append(formater.format(new Date()) + " -> " + join(str(l),','));
        deg[i][int(lidar[i].dev)] = 1;
      }
      lidar[i].update();
    }
  }

  void display() {
    super.display();
    for (int i=0; i<lidar.length; i++)
      lidar[i].display();
  }

  void saveJSON(){
    //saveJSONArray(valLIDAR, "output/LIDAR.json");
    saveStrings("output/LIDAR.log", valLIDAR.toArray());
  }
}
