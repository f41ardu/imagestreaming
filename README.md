# Upd Imagestreaming with Processing
 
Inspired by Daniel Shiffmans tutorial:
https://shiffman.net/processing.org/udp/2010/11/13/streaming-video-with-udp-in-processing/

Driven to find a udp video reveiver for Ryze Tello quadcopter. Tello send an h246 encoded video stream in 
chunks of 1460 bytes. 

This library is far from beeing perfect. The chunk parameter is defined for example in RaspberryVideoSender2 as variable range.
The corresponding varaible in VideoReceiverThreadChunks is definde in ReceiverThread as variable chunk. 

Use an usb connected camera and run either sender and receiver on the client. If you plan to stream to another client change 
localhost in the related broadcast pde: 

 ds.send(new DatagramPacket(block,block.length, InetAddress.getByName("localhost"),clientPort));

If you plan to use it on the Windows platform you may use the Processing Video library instead
of Haiders Video library for Linux/Raspberry. Unfortunately depreciated now. 

At this point in time I plan no further update. I'm not able to encode h264 videstream using this approach. 

 
