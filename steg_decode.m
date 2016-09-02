function [ output ] = steg_decode( stego, key )
%STEG_DECODE Decodes a message from a stego image.
%   Extracts binary data from the luminance of the stego image. The data is
%   then error corrected using a linear block code and interpreted as a
%   binary representation of text.

    n = 7; % Block code bits
    k = 3; % Block code parity bits
    capacity = 1026; % The number of bits which can be hidden
    addpath('./lib');

    % Convert the image to HSL
    hsl_img = stego;
    for col = 1:size(hsl_img, 2)
        for row = 1:size(hsl_img, 1)
            pixel = double(hsl_img(row, col, :)) / 255;
            hsl_img(row, col, :) = rgb2hsl(pixel) * 255;
        end
    end

    % Extract data from luminance
    lum = hsl_img(:, :, 3);
    bits = bitget(lum, 1);
    rng(key);
    perm = randperm(numel(bits));
    data = zeros(1, numel(bits));
    for index = 1:numel(bits)
        data(perm(index)) = bits(index);
    end

    % Decode the extracted data
    pol = cyclpoly(n,k);
    parmat = cyclgen(n,pol);
    genmat = gen2par(parmat);
    output = zeros(capacity / k, k);
    for block = 1:(capacity / k)
        for index = (7 * (block - 1) + 1):(capacity * n / k):numel(data)
            [decoded, error] = decode(data(index:(index + 6)), n, k, 'linear/binary', genmat);
            if ~error(1)
                output(block, :) = decoded;
                break;
            end
        end
    end

    % Interpret the decoded data as binary text
    output = transpose(output);
    output = reshape(output, 1, numel(output));
    output = output(1:capacity - mod(capacity, 8));
    output = reshape(output, 8, numel(output) / 8);
    output = transpose(output);
    output = fliplr(output);
    output = bi2de(output);
    output = char(output);
    output = transpose(output);
end

