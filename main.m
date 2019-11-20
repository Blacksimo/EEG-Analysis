addpath(genpath('utils'))

[open_eyes_header, open_eyes_record] = edfread('data/S070R01.edf');
open_eyes_annotion = open_eyes_record(65,:);
open_eyes_record = open_eyes_record(1:64,:);

