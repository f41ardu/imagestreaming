// Based on Workfrom 
// Daniel Shiffman
// <http://www.shiffman.net>


// A Thread using receiving UDP
// work with ficed chunk length! Check sender! 

class ReceiverThread extends Thread {

  // Port we are receiving.
  // int port = 11111; 
  // String ip = "0.0.0.0"; 
  DatagramSocket ds; 
  // A byte array to read into (max size of 65536, could be smaller)
  byte[] buffer = new byte[65536]; 
  byte[] inBuffer = new byte[0];
  byte[] emptyBuffer = new byte[0]; // emtpy the inBuffer after decoding image, not such elegant but working
  boolean running;    // Is the thread running?  Yes or no?
  boolean available;  // Are there new tweets available?

  // Start with something 
  PImage img;

  ReceiverThread (int w, int h, int port, String ip) {
    img = createImage(w, h, RGB);
    running = false;
    available = true; // We start with "loading . . " being available
    try { 
      InetAddress addr = InetAddress.getByName(ip);
      InetAddress host = (ip==null) ? (InetAddress)null: addr;
    } 
    catch( IOException e ) { 
      // caught SocketException & UnknownHostException
      println( "opening socket failed!"+
        "\n\t> address:"+ip+", port:"+port+
        "\n\t> "+e.getMessage());
    }
    try {
      ds = new DatagramSocket(port);
    } 
    catch (SocketException e) {
      e.printStackTrace();
    }
  }

  PImage getImage() {
    // We set available equal to false now that we've gotten the data
    available = false;
    return img;
  }

  boolean available() {
    return available;
  }

  // Overriding "start()"
  void start () {
    running = true;
    super.start();
  }

  // We must implement run, this gets triggered by start()
  void run () {
    while (running) {
      checkForImage();
      // New data is available!
      available = true;
    }
  }

  void checkForImage() {

    int pos  = 0; 
    DatagramPacket p = new DatagramPacket(buffer, buffer.length); 
    try {
      ds.receive(p);
    } 
    catch (IOException e) {
      e.printStackTrace();
    } 
    // byte[] data = p.getData();
    byte[] data = new byte[ p.getLength() ];
    System.arraycopy( p.getData(), 0, data, 0, data.length );

    println("--- Received datagram with " + p.getLength() + " bytes." );
    // Gather all datagram chunk, last chunk is smaller 
    if ( data.length == 1460 ) {
      inBuffer = concatenate(inBuffer, data); 
      // println("Concate " + inBuffer.length + " bytes." );
    } else {  
      if ( data.length < 1460 ) {
        inBuffer = concatenate(inBuffer, data);
        // println("Picture"); 
        // println("Received datagram with " + inBuffer.length + " bytes." );

        // Read incoming data into a ByteArrayInputStream
        ByteArrayInputStream bais = new ByteArrayInputStream( inBuffer );

        // We need to unpack JPG and put it in the PImage img
        // img.loadPixels();
        try {
          // Make a BufferedImage out of the incoming bytes
          BufferedImage bimg = ImageIO.read(bais);
          // Put the pixels into the PImage
          bimg.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
        } 
        catch (Exception e) {
          e.printStackTrace();
        }
        // Update the PImage pixels
        img.updatePixels();
        inBuffer = emptyBuffer;
      }
    }
  }

  // Our method that quits the thread
  void quit() {
    System.out.println("Quitting."); 
    running = false;  // Setting running to false ends the loop in run()
    // In case the thread is waiting. . .
    interrupt();
  }
}
