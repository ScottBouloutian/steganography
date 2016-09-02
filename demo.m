% Generate the stego image
cover = imread('examples/emma.jpg');
[ stego ] = steg_encode(cover, 123, 'Hello World!');
imwrite(stego, 'examples/stego.png');

% Extract the secret message
stego = imread('examples/stego.png');
[ message1 ] = steg_decode(stego, 123);

% Extract the secret message from the altered stego image
stego = imread('examples/stego_modified.png');
[ message2 ] = steg_decode(stego, 123);
