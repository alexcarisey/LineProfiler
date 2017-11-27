x = rand(1,2);
y = rand(1,2);
line(x,y)
% Slope of current line
m = (diff(y)/diff(x));
% Slope of new line
minv = -1/m;
line([mean(x) mean(x)+0.5],[mean(y) mean(y)+0.5*minv],'Color','red')
axis equal


%%

x = 0:0.1:1;
y = x.*x;
dy = gradient(y);
dx = gradient(x);
quiver(x,y,-dy,dx)
hold on; plot( x, y)