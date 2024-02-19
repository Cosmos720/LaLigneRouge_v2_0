///////////////////////////////////////////////////////////////
//
// Décrit la scène telle que le potelet (ou le serveur global)
// se la représente
//
///////////////////////////////////////////////////////////////
class Scene {
  Potelet[] potelets;              // les potelets
  ArrayList<Visiteur> visiteurs;   // les visiteurs "détectés"
  PShape site;                     // la géométrie du site
  
  // initialisation de l'objet scène
  Scene() {
    potelets = new Potelet[nombrePotelets];
    visiteurs = new ArrayList<Visiteur>();
//    site = loadShape("1ercycle.svg");
  }
  
  // initialise la représentation de la scène
  void init() {
  }
  
  // affiche virtuellement la scène telle que le potelet se la représente
  // de manière à pouvoir anticiper ce qu'il est censé percevoir...
  int[] display() {
    // un fond blanc
    background(0, 0, 100);

    // les potelets
    fill(0);
    for (int i=0; i<potelets.length; i++)
      potelets[i].virtualDisplay();

    // les visiteurs détectés
    for (Objet bob : visiteurs)
      bob.display();

    // la géométrie du site
//    shape(site, width/2 - 70, -900, 300, 3000);
    
    // récupère le tableau de pixels correspondant et le renvoie
    loadPixels();
    return pixels;
  }
}
