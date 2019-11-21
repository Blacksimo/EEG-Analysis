addpath(genpath('utils'))

[open_eyes_header, open_eyes_record] = edfread('data/S070R01.edf');
open_eyes_annotation = open_eyes_record(65,:);
open_eyes_record = open_eyes_record(1:64,:);

Y = open_eyes_record(1:20,:)';

% a = fdMVAR(Y, eye(size(Y,2)), 80, 160);