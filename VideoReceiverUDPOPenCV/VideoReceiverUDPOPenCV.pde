// Based on Work from 
// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images
import gab.opencv.*;
import java.awt.image.*; 
import java.awt.*;
import javax.imageio.*;
import java.net.*;
import java.io.*;


PImage video;
ReceiverThread thread;
OpenCV opencv;

void setup() {
  size(320, 240);
  video = createImage(320, 240, RGB);
  thread = new ReceiverThread(320, 240, 11111, "0.0.0.0");
  thread.start();
  opencv = new OpenCV(this, 320, 240);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  frameRate(20); 
}

void draw() {
  if (thread.available()) {
    video = thread.getImage();
    if (video.width > 0 && video.height > 0) {//check if the cam instance has loaded pixels
    //scale(0.5);
    opencv.loadImage(video);
    }
  }
   

  // Draw the image
  background(0);
  imageMode(CENTER);
  //scale(2);
  image(video, width/2, height/2);
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
 Rectangle[] faces = opencv.detect();
  //println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    // println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  
}
