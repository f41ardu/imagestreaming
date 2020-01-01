// Many Thanks to Daniel Shiffmann for the initial idea 
// See https://shiffman.net/processing.org/udp/2010/11/13/streaming-video-with-udp-in-processing/

// Function to broadcast a PImage over UDP
// Special thanks to: http://ubaa.net/shared/processing/udp/
// (This example doesn't use the library, but you can!)

import javax.imageio.*;
import java.awt.image.*; 
import java.io.*;

void broadcast(PImage img) {

  // We need a buffered image to do the JPG encoding
  BufferedImage bimg = new BufferedImage( img.width,img.height, BufferedImage.TYPE_INT_RGB );

  // Transfer pixels from localFrame to the BufferedImage
  img.loadPixels();
  bimg.setRGB( 0, 0, img.width, img.height, img.pixels, 0, img.width);
  // Need these output streams to get image as bytes for UDP communication
  ByteArrayOutputStream baStream  = new ByteArrayOutputStream();
  BufferedOutputStream bos    = new BufferedOutputStream(baStream);

  // Turn the BufferedImage into a JPG and put it in the BufferedOutputStream
  // Requires try/catch  
  try {
    ImageIO.write(bimg, "jpg", bos);   
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
 // Get the byte array, which we will send out via UDP!
  byte[] packet = baStream.toByteArray();
  int range = 1460;
  int pos = 0;
  int remaining;
  
  // Send JPEG data as a datagram
 

    //Placed the declaration of block outside the while. 
    byte[] block = null; 
    while ((remaining = packet.length - pos) > 0)
    {
        block = new byte[min(remaining, range)];

        System.arraycopy(packet, pos, block, 0, block.length);
        pos += block.length;
        println("Sending datagram with " + block.length + " bytes" );
        try {
                ds.send(new DatagramPacket(block,block.length, InetAddress.getByName("localhost"),clientPort)); 
             } 
        catch (Exception e) {
                 e.printStackTrace();
            }
    }
}
