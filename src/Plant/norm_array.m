function norm_array = norm_array(array)
% norm_array. Performs column-by-column normalisation of input array
norm_array   = array./ repmat((array(1,:).^2 + array(2,:).^2 + array(3,:).^2).^0.5, 3, 1);
