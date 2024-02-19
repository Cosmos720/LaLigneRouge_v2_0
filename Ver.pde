class Ver {
  int id;
  Potelet[] potes;

  Ver(int who, int taille) {
    id = who;
    potes = new Potelet[taille];

    float x = width / 4;
    float y = height / 4;
    for (int i=0; i<taille; i++) {
      if (i != 2)
        potes[i] = new Potelet(x + i * 200 * echelle, y, 20, 0);
      else
        potes[i] = new PoteletMaitre(x + i * 200 * echelle, y, 20, 0);
      simu.addPotelet(potes[i]);
    }

    potes[0].init(null, potes[1], potes[2], id);
    for (int i=1; i<taille-1; i++)
      potes[i].init(potes[i-1], potes[i+1], potes[2], id);
    potes[potes.length - 1].init(potes[potes.length - 2], null, potes[2], id);
    potes[2].position.y += 100;
    potes[2].posEstimee.y += 100;
    potes[2].angle += 45;
    potes[2].angleEstime += 45;
  }

  void update() {
    for (int i=0; i<potes.length; i++)
      potes[i].update();
  }

  void display() {
    stroke(0, 100, 100, 100);
    strokeWeight(2);
    for (int i=0; i<potes.length - 1; i++)
      line(potes[i].position.x + 5 * echelle * cos(potes[i].angle), 
        potes[i].position.y + 5 * echelle * sin(potes[i].angle), 
        potes[i+1].position.x +  5 * echelle * cos(potes[i].angle + PI), 
        potes[i+1].position.y +  5 * echelle * sin(potes[i].angle + PI));

    for (int i=0; i<potes.length - 1; i++)
      potes[i].display();

    potes[potes.length - 1].display();
  }
}
