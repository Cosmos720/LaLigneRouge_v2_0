class Objet {
  PVector position;
  float angle;

  Objet() {
  }
  
  Objet(PVector p, float a) {
    position = p;
    angle = a;
  }
  
  float towards(Objet cible) {
    return atan2(cible.position.y - position.y, cible.position.x - position.x);
  }

  float distance(Objet cible) {
    return dist(position.x, position.y, cible.position.x, cible.position.y);
  }

  void update() {
  }
  
  void display() {
  }
}

class ObjetConnecte extends Objet {
  ArrayList<Message> messages;     // la boîte de réception de messages

  ObjetConnecte() {
    super();
    messages = new ArrayList<Message>();
  }
  
  void sendMessage(int ty, int from, int to, float[] args) {
    Message msg = new Message(ty, from, to, args);
    simu.sendMessage(msg);
  }
  
  void receiveMessage(Message msg) {
    messages.add(msg);
  }
}
