function f_new = perform_convert_RGB_to_HSV(f);

fr=f(:,:,1); fg=f(:,:,2); fb=f(:,:,3);
f1 = (fr-fg)/sqrt(2);
f2 = (fr+fg-2*fb)/sqrt(6);
f3= (fr+fg+fb)/sqrt(3);

f_new = cat(3, f1, f2, f3);
