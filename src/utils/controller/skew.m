function S = skew(v)
% SKEW  Returns the 3×3 skew-symmetric matrix of vector v.
    S = [  0,   -v(3),  v(2) ;
          v(3),   0,   -v(1) ;
         -v(2),  v(1),   0   ];
end