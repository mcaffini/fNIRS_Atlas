function [DHb,DHbO2] = compute_conc(data,SD,Adot,sigma2)

% written by Matteo Caffini on May, 18 2011 at Dip. di Fisica, Politecnico di Milano (Italy).
% input: data is your fNIRS intensity data (time,channels)
%        SD is your probe struct (HOMER-like)
%        Adot is the sensitivity matrix (from gen_sensitivity_matrix.m)
%        sigma2 is your measurement covariance matrix

duration = size(phi690cw,2);

alpha = 0.01; % regularization paramenter
B = Adot*Adot';

for aa = 1:1:duration
    %if mod(aa,20)==1
        waitbar(aa/duration,hwait,sprintf('%d of %d',aa,duration));
    %end
    DMua_690(:,aa) = Adot'*inv(B+alpha*max(diag(B))*sigma2) * phi690cw(:,aa);
    DMua_820(:,aa) = Adot'*inv(B+alpha*max(diag(B))*sigma2) * phi820cw(:,aa);
end
close(hwait);

eHb_690 = 0.004922;
eHb_820 = 0.001803;

eHbO2_690 = 0.0007189;
eHbO2_820 = 0.002282;

DHbO2 = ( eHb_690*DMua_690   - eHb_820*DMua_820   ) / ( eHbO2_820*eHb_690 - eHbO2_690*eHb_820 );
DHb   = ( eHbO2_820*DMua_690 - eHbO2_690*DMua_820 ) / ( eHbO2_820*eHb_690 - eHbO2_690*eHb_820 );
