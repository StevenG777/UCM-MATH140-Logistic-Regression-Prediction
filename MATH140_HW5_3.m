%% MATH 140 Homework 5 Problem 3

%% Set Up
% Define X matrix and y vector
X = [1 ,1   ,3;
     1 ,2   ,4;
     1 ,2.5 ,3.5;
     1 ,3   ,1.5;
     1 ,3.5 ,4.5;
     1 ,4   ,1.5;
     1 ,4   ,3.5;
     1 ,4.5 ,2.5;
     1 ,5   ,1  ;
     1 ,6   ,2  ;
     1 ,6.5 ,3  ;
     1 ,7   ,1.5;
     ];

y = [1;1;1;1;1;-1;-1;-1;-1;-1;-1;-1];

% w0 is modified based on the known optimal value because w0 has to be very
% close to optimal w for pure_newton not diverge.
w0 = [0.35,-0.8,0.8]';

h = @(w) 1 ./ (1 + exp(-y .* (X * w)));
f = @(w) (lambda/2) * (w' * w) + sum(log(1 + exp(-y .* (X * w))));
gradf = @(w) lambda * w - X' * (y .* (1 - h(w)));
hessf = @(w) lambda * eye(3) + X' * diag(h(w) .* (1 - h(w))) * X;

%% Part (c) & (d)
lambda = 1;
t = 0.01;
epsilon = 10^-7;

gradient_method_constant(f,gradf,w0,t,epsilon);
% Comment: It takes 755 iterations to find optimal w

pure_newton(f,gradf,hessf,w0,epsilon);
% Comment: It takes 3 iterations to find optimal w

%% Part (e)
w = pure_newton(f,gradf,hessf,w0,epsilon);
[y_pred,pred_percent] = log_regression(X,y,w);
disp(y_pred)
disp(pred_percent)

% comment: y_pred = [1 1 1 -1(error) 1 -1 -1 -1 -1 -1 -1 -1]'
%          It's 91.6667% of y values are predicted correctly


function [y_pred,pred_percent] = log_regression(X,y,w)
    phi = 1 ./ (1 + exp(-X * w));
    y_pred = zeros(length(y),1);
    pred_corr = 0;

    for i = 1:length(phi)
        if phi(i) >= 0.5
            y_pred(i) = 1;
        else
            y_pred(i) = -1;
        end

        if y_pred(i) == y(i)
            pred_corr = pred_corr + 1;
        end
    end    
    pred_percent = (pred_corr/length(y)) * 100;
end

