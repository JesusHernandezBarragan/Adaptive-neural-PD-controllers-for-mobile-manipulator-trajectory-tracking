function Save_Figure (f,name)
%     tsize = 19;
%     set(gca,'FontSize',tsize-2)
%     set(findobj(gca,'Type','text'),'FontSize',tsize-3,'VerticalAlignment','Middle')
%     ax = gca; outerpos = ax.OuterPosition; ti = ax.TightInset;  
%     left = outerpos(1) + ti(1); bottom = outerpos(2) + ti(2); 
%     ax_width = outerpos(3) - ti(1) - ti(3); ax_height = outerpos(4) - ti(2) - ti(4); 
%     ax.Position = [left bottom ax_width ax_height];
    saveas(f,['Images/' name '_Exp.eps'],'epsc')
%     saveas(f,['Images/' name '.png'])
