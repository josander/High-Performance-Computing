function B = getDense(A)

indexRow = min(find(A(:,1) == 0));
indexCol = min(find(A(1,:) == 0));

kl = indexRow - 2;
ku = indexCol - 2;

lda = kl + ku + 1;

B = zeros(lda,1);

for i = kl + 1:size(A,2)
    B(i) = A()
end

end