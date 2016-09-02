# steganography
Matlab functions for image steganography

## Running
The included `demo.m` script provides an example of how to use the `steg_encode` and `steg_decode` functions.

## Background
The algorithm hides text in the form of binary data within the luminance channel of a color image. Before the binary data is hidden, it is first encoded with a linear block error detection and correction code. The resulting sequence is then cyclically repeated until there is enough data to fill the least significant bits of the luminance channel. Next, the repeating data stream is shuffled pseudo-randomly using an integer key as a seed. The shuffled data stream is then hidden in the luminance channel of the image. The entire process is reversed in order to extract the secret message.

## Results
### Original Image
![Cover Image](https://github.com/ScottBouloutian/steganography/blob/master/examples/emma.jpg)
### Stego Image
![Cover Image](https://github.com/ScottBouloutian/steganography/blob/master/examples/stego.png)
### Error correction
Because error correction is utilized in the decoding process, the stego image may be modified to some extend without affecting the ability to retrieve the secret message. Below you can see a modified stego image with its secret message intact.

![Cover Image](https://github.com/ScottBouloutian/steganography/blob/master/examples/stego_modified.jpg)
