// Based on Work from 
// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;
import java.net.*;
import java.io.*;


PImage video;
ReceiverThread thread;

void setup() {
  size(400, 300);
  video = createImage(640, 480, RGB);
  thread = new ReceiverThread(320, 240, 11111, "0.0.0.0");
  thread.start();
}

void draw() {
  if (thread.available()) {
    video = thread.getImage();
  }

  // Draw the image
  background(0);
  imageMode(CENTER);
  image(video, width/2, height/2);
}
