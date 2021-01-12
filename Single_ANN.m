classdef Single_ANN < handle
    properties
        w = [];
        eta = [];

        qk = [];
        rk = 0;
        pk = [];
        
        e_old = 0;
    end
    
    methods
        function obj = Single_ANN (eta,qk,rk)
            obj.eta = eta;
            obj.w = rand(2,1);
            
            obj.qk = eye(2,2)*qk;
            obj.rk = rk;
            obj.pk = eye(2,2);
        end
        
        function u = Control (obj,e)
            x1 = e;
            x2 = (e-obj.e_old);
            obj.e_old = e;
            
            x = [x1; x2];
            v = obj.w'*x;
            y = tanh(v);
            
            % kalman_training
            zk = ((1-y)*(1+y))*x;
            kk = obj.pk*zk/(obj.rk+zk'*obj.pk*zk);
            
            obj.w = obj.w + obj.eta.*kk*e;
            obj.pk = obj.pk - kk*zk'*obj.pk + obj.qk;

            for j=1:2
                if obj.w(j)<0
                    obj.w(j) = 0;
                end
            end
            
            u = y;
        end
    end
end