function probV = norm_pdf(Error_xy,segma)
Det_xy = sqrt(abs(det(2*pi*segma)));   %20*pi
i_segma = inv(segma);                        %[0.1,0;0,0.1]
Es = Error_xy'*i_segma.*Error_xy';        %3000*2æÿ’Û
probV = exp(-0.5*sum(Es'))/Det_xy;     %1*3000æÿ’Û
probV = probV;                            