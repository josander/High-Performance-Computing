%% Using ()

clc
clear all

n = 1000;
v = randn(n, 1);
a = randn(n, 1);
loops = 100;

tic
for j = 1:loops
    A = v * v';
    y = A * a;
end
toc

tic
for j = 1:loops
    y = v * v' * a;
end
toc

tic
for j = 1:loops
    y = v * (v' * a);
end
toc