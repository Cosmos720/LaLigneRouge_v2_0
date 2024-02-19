//
// defines the different types of messages
//
///////////////////////////////////////////////////////////////////////////
//
//    un potelet informe le serveur de sa position estimée
// ou le serveur informe le potelet de sa position estimée
final int POSITION = 0;
// un potelet informe le serveur de la détection d'un obstacle
final int DETECT = 1;

///////////////////////////////////////////////////////////////////////////
//
// Message
// =======
// > a message can be send by a robot to another robot or to the server
// > messages are caracterized by:
//   - type = basically "ask for something" or "inform about something" but
//     more types can be defined...
//   - agent = the sender of the message
//   - args = a list of arguments
//
///////////////////////////////////////////////////////////////////////////
class Message {
  int type;
  int emetteur;
  int recepteur;
  float[] args;

  //
  // constructor
  // ===========
  //
  Message(int ty, int from, int to, float[] msgArgs) {
    type = ty;
    emetteur = from;
    recepteur = to;
    args = new float[msgArgs.length];
    arrayCopy(msgArgs, args);
  }
}
