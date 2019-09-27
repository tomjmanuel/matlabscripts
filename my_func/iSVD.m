%inverse SVD
%that takes results from a 2D svd and reconstructs matrix within
%Svs specified by thresh
%use call SVD to parse 3d
function [ni] = iSVD(U, S, V, thresh)

    dim = size(S);
    ni = zeros(dim);
    S = diag(S);
    for i=thresh(1):thresh(2)
        ni = ni + U(:,i)*S(i)*V(:,i)';
    end

end