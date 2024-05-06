///////////////////////////////////////////////////////////////////////////
//
// Capteur = classe abstraite contenant les caractéristiques d'un capteur
// - le potelet auquel il est attaché
// - la position et l'orientation par rapport au potelet
//   (en coordonnées polaires)
// - les caractéristiques (ouverture/portée) du capteur
//
///////////////////////////////////////////////////////////////////////////
class Capteur extends Objet {
  Potelet pote;        // le potelet sur lequel se trouve le capteur
  float angle;         // l'orientation du capteur
  float teta;          // l'angle par rapport au potelet
  float dist;          // la distance au centre du potelet
  float ouverture;     // l'ouverture du capteur
  float portee;        // la portée du capteur
  color couleur;       // la couleur pour l'affichage
  color couleur_cible; // la couleur pour l'affichage de la cible
  float mesure;        // la distance mesurée par le capteur
  PVector cible;       // les coordonnées de la cible

  // constructeur
  Capteur(float o, float p, color c1, color c2) {
    ouverture = o;
    portee = p;
    couleur = c1;
    couleur_cible = c2;
    position = new PVector();
    cible = new PVector();
  }

  // initialisation du potelet
  void init(Potelet p, float a, float d) {
    pote = p;
    teta = a;
    dist = d;

    updatePosition();
  }

  void updatePosition() {
    angle = pote.angle + teta;
    position.x = pote.position.x + dist * echelle * cos(radians(angle));
    position.y = pote.position.y + dist * echelle * sin(radians(angle));
  }

  void update() {
    float minDist = width*2;
    float a;
    cible.x = -10;
    cible.y = -10;

    PVector p = new PVector();
    int k;

    for (float i=0; i <= ouverture; i+=ouverture/10) {
      a = angle - ouverture / 2 + i;
      for (int j=1; j < min(minDist, portee); j++) {
        p.x = int(position.x + j * echelle * cos(radians(a)));
        p.y = int(position.y + j * echelle * sin(radians(a)));
        if ((p.x < 0) || (p.x >= width) ||
          (p.y < 0) || (p.y >= height))
          break;
        k = int(p.y * width + p.x);

        if (pixels[k] == noir) {
          cible.x = p.x;
          cible.y = p.y;
          minDist = j;
          break;
        }
      }
    }

    if (minDist < width*2)
      mesure = minDist / echelle;
    else
      mesure = -1;
  }

  void display() {
    if (mesure != -1)
      fill(0, 50, 100, 50);
    else
      fill(couleur);
    noStroke();
    arc(position.x, position.y, 2 * portee * echelle, 2 * portee * echelle, 
      radians(angle) - radians(ouverture) / 2, radians(angle) + radians(ouverture) / 2);
    fill(couleur_cible);
    ellipse(cible.x, cible.y, 20, 20);
  }
}

class US extends Capteur {
  US(Potelet p, float a, float d) {
    super(30, 500, color(120, 50, 100, 50), color(120, 100, 100, 100));
    init(p, a, d);
  }
}

class IR extends Capteur {
  IR(Potelet p, float a, float d) {
    super(2, 150, color(50, 50, 100, 70), color(50, 100, 100, 100));
    init(p, a, d);
  }
}

class LIDAR extends Capteur {
  float rotationSpeed;
  float minAngle, maxAngle;
  float teta, dev;

  LIDAR(Potelet p, float a, float d) {
    super(1, 12000, color(200, 50, 100, 50), color(200, 100, 100, 100));
    rotationSpeed = /*20 / frameRate*/1;
    minAngle = 0;
    maxAngle = 120;
    dev = 0;
    teta = a;
    init(p, teta, d);
  }

  void update() {
    dev += rotationSpeed;
    if (dev >= maxAngle || dev <= minAngle)
      rotationSpeed *= -1;
    angle = pote.angle + (teta-60) + dev;
    println(angle + " , " + teta + " , " + (dev));
    super.update();
  }
/*
  void display() {
    if (mesure != -1)
      fill(0, 50, 100, 50);
    else
      fill(couleur);
    noStroke();
    arc(position.x, position.y, 2 * portee * echelle, 2 * portee * echelle, 
      angle - ouverture / 2, angle + ouverture / 2);
    fill(couleur_cible);
    ellipse(cible.x, cible.y, 20, 20);
  }*/
}
