// non class implementation 
byte[] concatenate(byte[] ... arrays) 
{
  int inLenght = 0;  
  for (byte[] array : arrays) {
    inLenght += array.length;
  }

  byte[] retArray = new byte[inLenght];
  int indx = 0; 
  for (byte[] array : arrays) {
    System.arraycopy(array, 0, retArray, indx, array.length); 
    indx += array.length;
  }
  return retArray;
}
