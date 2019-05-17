function [ xenp, Pnp ] = my_kalman( zn, xen_1p, Pn_1p, H, R, phi, Q, bn_1 )
%MY_KALMAN [ xenp, Pnp ] = my_kalman( zn, xen_1p, Pn_1p, H, R, phi, Q, bn_1 )
%   - xenp is the updated estimate x^ +[n] obtained by combining x^ [n] 
%   and the measurement z[n] (x^ +[n] is the required estimate x^[n]).
%  - Pnp is the updated error covariance matrix P +[n] (the error 
%   covariance matrix corresponding to the estimate x^[n]).
%  - zn is the measurement z[n] at time n.
%  - xen_1p is the previous state estimate x^ +[n  1] (that is x^[n  1]).
%  - Pn_1p is the error covariance matrix P +[n  1] (the error covariance
%   matrix of the previous estimate x^[n  1]).
%  - H is the measurement matrix H.
%  - R is the covariance matrix R.
%  - PHI is the transition matrix .
%  - Q is the covariance matrix Q.
%  - bn_1 is the vector b[n  1]

% Identity matrix
I = eye(length(xen_1p));
% State estimate extrapolation
xenn = phi * xen_1p + bn_1;
% Error covariance extrapolation
Pnn = phi * Pn_1p * phi' + Q;
% Kalman gain
Kn = Pnn * H' * inv((H * Pnn * H' + R));
% State estimate update
xenp = (I - Kn * H) * xenn + Kn * zn;
% Error covariance update
Pnp = (I - Kn * H) * Pnn * (I - Kn * H)' + Kn * R * Kn';

end
