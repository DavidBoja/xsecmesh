function test_epint()
myPlane = [0,0,0, 1,0,0, 0,1,0];
pA = [0,0,-1];
pB = [0,0,+1];
ip1 = get_line_plane_intersect(pA, pB, myPlane);
ip2 = intersectEdgePlane([pA, pB], myPlane);
disp(ip1);
disp(ip2);
end

function intersectPoint = get_line_plane_intersect(point1, point2, myPlane)
% Find the intersection between a line containing the points point1 & point2 
% and the plane myPlane. See mathworld.wolfram.com/Line-PlaneIntersection.html
p1 = myPlane(1:3);
p2 = p1 + myPlane(4:6);
p3 = p1 + myPlane(7:9);
A = [
    1, 1, 1, 1;
    p1(1), p2(1), p3(1), point1(1);
    p1(2), p2(2), p3(2), point1(2);
    p1(3), p2(3), p3(3), point1(3);
    ];
B = [
    1, 1, 1, 0;
    p1(1), p2(1), p3(1), point2(1)-point1(1);
    p1(2), p2(2), p3(2), point2(2)-point1(2);
    p1(3), p2(3), p3(3), point2(3)-point1(3);
    ];
t = -det(A)/det(B);%-A./B;
xout = point1(1) + (point2(1) - point1(1))*t;
yout = point1(2) + (point2(2) - point1(2))*t;
zout = point1(3) + (point2(3) - point1(3))*t;
intersectPoint = [xout, yout, zout];
end