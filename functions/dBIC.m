function delBIC = dBIC(A,B,lamda)
%
% Inputs: A,B matrices with same number of columns
% 
% H0: hypothesis that A and B will be modelled best by 1 Gaussian
% H1: hypothesis that A and B will be modelled best by 2 separate Gaussians
% 
% Output: dBIC = BIC(H1) - BIC(H0)
%
% dBIC = deltaBIC(A,B) evaluates the change ni BIC criterion used to determine
% whether segments A and B should be modelled as same speaker
% 
% Here both A and B will be modelled as Multivariate Gaussians


    d = size(A,2);
    if (isempty(lamda))
        lamda = 10;
    end

    n = size(A,1);
    m = size(B,1);
    
    fused = [A;B];
    
    % For a d dim-Gaussian estimated from N vectors
    % BIC = - N * log (det(covariance)) - lamda/2*(d+1/2*d(d+1))
    
    fusedBIC = (n + m)*log(abs(det(cov(fused))));
    
    ABIC = n*log((det(cov(A))));
    BBIC = m*log((det(cov(B))));
    
    % deltaBIC = (N+M)log(merged) -N.log(data1) -M.log(data2) -const(N,M)
    
    P = 0.5*(d + d*(d+1)/2)*log(n + m);

    delBIC = fusedBIC - ABIC - BBIC - lamda*P;

end