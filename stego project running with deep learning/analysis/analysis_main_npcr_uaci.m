% Read the two images (replace 'image1.png' and 'image2.png' with your image file paths)
img_a = imread('F:\stego project running\img\stegano_bob3.png');
img_b = imread('F:\stego project running\img\stegano_bob4.png');

% Call the NPCR_and_UACI function
results = NPCR_and_UACI(img_a, img_b);

% Display the results
disp('NPCR and UACI Results:');
disp(['NPCR Score: ' num2str(results.npcr_score)]);
disp(['NPCR p-value: ' num2str(results.npcr_pVal)]);
disp(['UACI Score: ' num2str(results.uaci_score)]);
disp(['UACI p-value: ' num2str(results.uaci_pVal)]);


