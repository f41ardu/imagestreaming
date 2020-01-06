import processing.video.*;
import javax.imageio.*;
import java.awt.image.*; 
import java.net.*;
import java.io.*;

// This is the port and host we are sending to
int clientPort = 11111;
String clientHost = "10.40.16.29"; 
// This is our object that sends UDP out
DatagramSocket ds; 
// Capture object
Capture cam;

void setup() {
  size(400, 300);
  // Setting up the DatagramSocket, requires try/catch
  try {
    ds = new DatagramSocket();
  } 
  catch (SocketException e) {
    e.printStackTrace();
  }
  // Initialize Camera
  // cam = new Capture( this, width,height,30);
  cam = new Capture(this, 320, 240);
  cam.start();
}



void captureEvent( Capture c ) {
 c.read();
 // Whenever we get a new image, send it!
 //broadcast(c);
 } 
 

void draw() {
  background(0);
  //scale(2);

 imageMode(CENTER);
 image(cam, width/2, height/2);
 broadcast(cam, clientPort, clientHost);
}
