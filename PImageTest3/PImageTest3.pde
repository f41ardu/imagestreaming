// Send Images over UDP 
import java.net.*;

// This is the port we are sending to
int clientPort = 11111; 
// This is our object that sends UDP out
DatagramSocket ds; 
// This is the image we are sending
PImage photo;

void setup() {
  size(320,240);
  photo = loadImage("data//space_shuttle.jpg");
  
   // Setting up the DatagramSocket, requires try/catch
  try {
    ds = new DatagramSocket();
  } 
  catch (SocketException e) {
    e.printStackTrace();
  }
  
  //Loop();
}

void draw() {
  image(photo, 0, 0);
  broadcast(photo);  
}
