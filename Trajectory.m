function xd = Trajectory (t,trac)
    xd = zeros(3,1);
    
    switch trac
        case 1
            xd(1) = 0.5;
            xd(2) = 0.1*t;
            xd(3) = 0.45;
        case 2
            xd(1) = 0.5;
            xd(2) = 0.1*t;
            xd(3) = 0.45 + 0.05*sin(2*pi*xd(2,:));
        case 3
            xd(1) = 0.5;
            xd(2) = 0.05*cos(0.2*t*pi);
            xd(3) = 0.45 + 0.05*sin(0.2*t*pi);
        case 4 
            r = 0.035 + 0.015*cos(3*(0.2*t*pi));
            xd(1) = 0.5;
            xd(2) = 0.0 + r*cos(0.2*t*pi);
            xd(3) = 0.45 + r*sin(0.2*t*pi);
        case 5
            xd(1) = 0.5;
            xd(2) = 0.1*t;
            xd(3) = 0.45 + 0.08*sin(2*pi*xd(2,:));

            if xd(3)>=0.5
            	xd(3) = 0.5;
            end
            
            if xd(3)<0.4
                xd(3) = 0.4;
            end
    end