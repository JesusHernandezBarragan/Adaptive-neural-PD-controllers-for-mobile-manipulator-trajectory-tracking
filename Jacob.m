function J = Jacob(q)
    q3 = q(3);
    q4 = q(4);
    q5 = q(5);
    q6 = q(6);
    q7 = q(7);
    
    J = [ 1, 0, -(sin(q3 + q4)*(1087*sin(q5 + q6 + q7) + 675*cos(q5 + q6) + 775*cos(q5) + 165))/5000, -(sin(q3 + q4)*(1087*sin(q5 + q6 + q7) + 675*cos(q5 + q6) + 775*cos(q5) + 165))/5000, -(cos(q3 + q4)*(675*sin(q5 + q6) - 1087*cos(q5 + q6 + q7) + 775*sin(q5)))/5000, (cos(q3 + q4)*(1087*cos(q5 + q6 + q7) - 675*sin(q5 + q6)))/5000, (1087*cos(q5 + q6 + q7)*cos(q3 + q4))/5000, 0;
          0, 1,  (cos(q3 + q4)*(1087*sin(q5 + q6 + q7) + 675*cos(q5 + q6) + 775*cos(q5) + 165))/5000,  (cos(q3 + q4)*(1087*sin(q5 + q6 + q7) + 675*cos(q5 + q6) + 775*cos(q5) + 165))/5000, -(sin(q3 + q4)*(675*sin(q5 + q6) - 1087*cos(q5 + q6 + q7) + 775*sin(q5)))/5000, (sin(q3 + q4)*(1087*cos(q5 + q6 + q7) - 675*sin(q5 + q6)))/5000, (1087*cos(q5 + q6 + q7)*sin(q3 + q4))/5000, 0;
          0, 0,                                                                                    0,                                                                                    0,       (1087*sin(q5 + q6 + q7))/5000 + (27*cos(q5 + q6))/200 + (31*cos(q5))/200,           (1087*sin(q5 + q6 + q7))/5000 + (27*cos(q5 + q6))/200,              (1087*sin(q5 + q6 + q7))/5000, 0];