
ArrayList Split(byte[] filebytes, int range)
{
    range *= 1000;
    int pos = 0;
    int remaining;

    ArrayList result = new ArrayList();

    //Placed the declaration of block outside the while. 
    byte[] block = null; 
    while ((remaining = filebytes.length - pos) > 0)
    {
        block = new byte[min(remaining, range)];

        System.arraycopy(filebytes, pos, block, 0, block.length);
        result.add(block);

        pos += block.length;
    }

    return result;
}
