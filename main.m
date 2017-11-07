clear all; close all; clc;


I = imread('volleyball.jpg');
J = imread('volleyball_multiop.jpg');


score_add  = bims( I, J, 9, 'CC', 'avg');

score_mul  = bims( I, J, 9, 'CC', 'mul');

score_lin  = bims( I, J, 9, 'CC', 'lin');

score_nlin = bims( I, J, 9, 'CC', 'nlin');
