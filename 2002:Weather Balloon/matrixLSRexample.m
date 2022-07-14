clear all;
clc;

%pressure
x = [65; 75; 85; 95; 105];

%temperature
y = [-20; 17; 42; 94; 127];

%H-matrix
H = [ones(length(y),1),x];

%weight matrix doesnt matter since weights are same

x_hat = ((H' * H)^-1) * H' * y;


%or assign weights to be one
W1 = eye(length(y));
X_hat_new = ((H' * W1 * H)^-1) * H' *  W1 * y;

A = x_hat(1);
B = x_hat(2);
%calculate error in data
Deviation = y - (A + B.*x);
sigma_y = sqrt((1/length(y)-length(x_hat))) * sum (Deviation .* Deviation);

delta_y(1:length(y)) = sigma_y;
diagonal = 1 ./ (delta_y .* delta_y);
W = diag(diagonal);

%error covariance matrix
P = (H' * W * H)^-1;

%uncertainty in A
sigma_A = sqrt(P(1,1));


y_fit = A + B .* x;

%extrapolate in matrix form

y_0_new = [1 0] * x_hat;
sigma_y0 = sqrt([1 0] * P* [1; 0]);

