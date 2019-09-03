b=imread('Origial_image_24.bmp'); % 24-bit BMP nombre de la imagen a cambiar
k=1;
for i=480:-1:1 % Se recorre tomando en cuenta resolución
for j=1:640
a(k)=b(i,j,1);
a(k+1)=b(i,j,2);
a(k+2)=b(i,j,3);
k=k+3;
end
end
fid = fopen('kodim24.hex', 'wt'); %% Imagen de salida en formato .hex
fprintf(fid, '%x\n', a);
disp('Text file write done');disp(' ');
fclose(fid);
