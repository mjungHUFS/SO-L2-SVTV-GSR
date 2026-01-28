function SSIM_col = ssim_index_col(u,Im0);

sum0 = 0;
for i=1:3
    sum0=sum0+ssim_index(u(:,:,i),Im0(:,:,i));
end
SSIM_col = sum0/3;