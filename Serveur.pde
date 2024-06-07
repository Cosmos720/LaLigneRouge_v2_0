class Serveur extends ObjetConnecte {
  Potelet[] potelets;              // la position "réelle" des potelets
  PVector[] potes;                 // la position "estimée" des potelets
  ArrayList<Visiteur> visiteurs;   // les visiteurs "détectés"
  Mouse mouse;
  Ver[] vers;
  int nbVers;
  int nbPotelets;

  Serveur() {
    potelets = new Potelet[nombrePotelets];
    nbPotelets = 0;
    vers = new Ver[nombreVers];
    visiteurs = new ArrayList<Visiteur>();
  }

  void init() {
    vers[0] = new Ver(0, 5);
    nbVers = 1;
    for (int i=0; i<20; i++) {
      Visiteur v = new Visiteur();
      visiteurs.add(v);
    }
    mouse = new Mouse();
  }

  void addPotelet(Potelet p) {
    potelets[nbPotelets] = p;
    nbPotelets++;
  }

  void sendMessage(Message msg) {
    if ((msg.recepteur >= 0) && (msg.recepteur < potelets.length)) {
      potelets[msg.recepteur].receiveMessage(msg);
    }
  }

  void update() {
    loadPixels();
    for (int i=0; i<nbVers; i++)
      vers[i].update();

    for (Objet bob : simu.visiteurs)
      bob.update();

    mouse.update();
  }

  void display() {
    background(0, 0, 100);

    for (int i=0; i<nbVers; i++)
      vers[i].display();

    for (Objet bob : simu.visiteurs)
      bob.display();

    mouse.display();
    shape(salle, width/2-100, -425, 300, 3000);
  }

  void dispose() {
    for (Potelet p : simu.potelets){
      p.saveJSON();
    }
  }
}
