cover_image = imread('F:\stego project running\img\F-16_512-512.png');
stego_image = imread('F:\stego project running\img\stegano.png');

uaci_value = calculate_uaci(cover_image, stego_image);

fprintf('UACI: %.4f\n', uaci_value);

npcr_value = calculate_npcr(cover_image, stego_image);

fprintf('NPCR: %.4f%%\n', npcr_value);