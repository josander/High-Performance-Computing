n = 5000; 
A = spdiags(randn(n, 101), -50:50, n, n);
biggestBS = 20;
reps = 200;
time = [];

for bs = 1:biggestBS
    t = 0;
    for i = 1:reps
        
        X = randn(n,bs);
        tic 
        Y = A * X;
        t = t + toc;
    end    
    time(bs) = t/reps;
end

normTime = time/time(1);
normTime2 = normTime./(1:biggestBS);
subplot(1,2,1)
plot(normTime);
xlabel('Blocksize')
ylabel('Time per block [ ]')
subplot(1,2,2)
plot(normTime2);
xlabel('Blocksize')
ylabel('Time per column [ ]')