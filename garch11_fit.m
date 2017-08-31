function [EstMdl, stds_residuals, cond_stdev] = garch11_fit(y)
% Fits a GARCH(1,1) to input series y and returns 
% the estimated coefficients and devolatilised series
Mdl = garch(1,1);
[EstMdl,EstParamCov,logL,info] = estimate(Mdl, y);
cond_var    = infer(EstMdl,y); 
cond_stdev = sqrt(cond_var);
stds_residuals = y ./ cond_stdev;
end

