%% Fetch, read and run strange.m

clc
clear all

% Are you surprised by the times?
% Think about the time for s2.

n = 1000000;
a = randn(1, n);

tic
s1 = 0;
for k = 1:n
    s1 = s1 + a(k);
end
toc

tic
s2 = 0;
for k = a
    s2 = s2 + k;
end
toc

tic
s3 = 0;
k  = 1;
while k <= n
    s3 = s3 + a(k);
    k  = k + 1;
end
toc

tic
s4 = sum(a);
toc

err = [s1 s2 s3] - s4
