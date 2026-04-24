function out = spikefilter(in, limit)
% spike filter for angular values - if in exceeds limit, 2*pi is
% subtracted/added to remove false spike

in_mag  = abs(in);
out_mag = (in_mag-2*pi).*(in_mag>limit) + in_mag.*(in_mag<=limit);
out     = out_mag.*sign(in);