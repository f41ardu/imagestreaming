import gohai.glvideo.*;
import javax.imageio.*;
import java.awt.image.*; 
import java.net.*;
import java.io.*;

// This is the port we are sending to
int clientPort = 11111; 
// This is our object that sends UDP out
DatagramSocket ds; 
// Capture object
GLCapture cam;

void setup() {
  size(320, 240, P2D);
  // Setting up the DatagramSocket, requires try/catch
  try {
    ds = new DatagramSocket();
  } 
  catch (SocketException e) {
    e.printStackTrace();
  }
  // Initialize Camera
  // cam = new Capture( this, width,height,30);
  String[] devices = GLCapture.list();
  println("Devices:");
  printArray(devices);
  if (0 < devices.length) {
    String[] configs = GLCapture.configs(devices[0]);
    println("Configs:");
    printArray(configs);
  }
  cam = new GLCapture(this, devices[0], width, height, 10);
  cam.start();
}


/*
void captureEvent( GLCapture c ) {
  c.read();
  // Whenever we get a new image, send it!
  broadcast(c);
} */


void draw() {
  background(0);
  if (cam.available()) {
    cam.read();
  }
  scale(2);
  if (cam.width > 0 && cam.height > 0) {
    image(cam, 0, 0, width/2, height/2);
    broadcast(cam);
  }
}
