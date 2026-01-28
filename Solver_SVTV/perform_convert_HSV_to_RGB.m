function u = perform_convert_HSV_to_RGB(q);  

q1 = q(:,:,1); q2 = q(:,:,2);q3 = q(:,:,3);
u1 = q1/sqrt(2)+q2/sqrt(6)+q3/sqrt(3);
u2 = u1-sqrt(2)*q1;
u3 = -sqrt(6)*q2/3+sqrt(3)*q3/3;
u = cat(3, u1, u2, u3);

end