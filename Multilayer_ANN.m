classdef Multilayer_ANN < handle
    properties
        nP = 0;
        nO = 0;
        n = 0; 
        w = [];
        eta = 0;

        Q = [];
        R = 0;
        P = [];
        
        e_old = 0;
    end
    
    methods
        function obj = Multilayer_ANN (nO,eta,q,r)
            obj.nP = 2;
            obj.nO = nO;
            obj.n = (obj.nP+1)*obj.nO + (obj.nO+1); 
            obj.w = rand(obj.n,1);
            obj.eta = eta; 
            obj.P = eye(obj.n);
            obj.Q = eye(obj.n)*q;
            obj.R = r;
        end
        
        function u = Control (obj,e)
%             obj.w = obj.w/norm(obj.w);
            
            xO = [1; e; (e-obj.e_old)];
            obj.e_old = e;
            
            wO = reshape(obj.w(1:(obj.nP+1)*obj.nO),[obj.nP+1 obj.nO]);
            wS = obj.w((obj.nP+1)*obj.nO+1:obj.n);
            
            vO = wO'*xO;
            yO = tanh(vO);
            
            xS = [1; yO];
            vS = wS'*xS;
            yS = tanh(vS);
%             yS = vS;
            
            % Matriz H
            yS_vS = (1-yS)*(1+yS);
%             yS_vS = 1;
            yO_vO = (1-yO).*(1+yO);

            H = zeros(obj.n,1);    
            M = (yS_vS*wS(2:end).*yO_vO)*xO';
            H(1:(obj.nP+1)*obj.nO) = reshape(M',[(obj.nP+1)*obj.nO 1]);
            H((obj.nP+1)*obj.nO+1:obj.n) = yS_vS*xS;

            K = obj.P*H*(obj.R+H'*obj.P*H)^(-1);
            obj.P = obj.P - K*H'*obj.P + obj.Q;
            obj.w = obj.w + obj.eta*K*e;

            u = yS; 
        end
    end
end