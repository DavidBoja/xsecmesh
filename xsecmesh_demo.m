% xsecmesh_demo.m
% Load the L-shaped membrane mesh, get a collection of cross-sections, and
% plot the results.

% Load "Paul's Membrane"
load PaulsMembrane.mat;

% Preallocate arrays for polygon vertices and isHole Boolean values.
polygonsCell = cell(1,100);

planeZvals = linspace(0.6, 1.5, 3);
for numPlane = 1:numel(planeZvals)
    % disp(numPlane);
    planePoints = [
        0, 0, 0 + planeZvals(numPlane), ...
        1, 0, 0 + planeZvals(numPlane), ...
        0, 1, 0 + planeZvals(numPlane)
        ];
    plane = [
        planePoints(1:3), ...
        planePoints(4:6)-planePoints(1:3), ...
        planePoints(7:9)-planePoints(1:3)
        ];
    % Get the plane/mesh cross-section.
    polyCellNow = xsecmesh(plane,verts,faces);
    % Store the results.
    if ~isempty(polyCellNow)
        % Find the first un-used cell array element.
        firstIx = find(cellfun(@isempty,polygonsCell),1);
        % Store the polygons.
        polygonsCell(firstIx:firstIx+numel(polyCellNow)-1) = polyCellNow;
    end
end

% Remove the empty cells.
polygonsCell = polygonsCell(~cellfun(@isempty,polygonsCell));


hfig1 = figure(1);
    clf;
    
    % Plot the mesh.
    hs1 = subplot(1,2,1);
        hSolid = drawMesh(verts,faces);
        set(                                                ...
            hSolid              ,                           ...
            'FaceColor'         ,   [0.8,0.8,1]         ,   ...
            'EdgeColor'         ,   1/255*[59,59,59]    ,   ...
            'FaceLighting'      ,   'gouraud'           ,   ...
            'AmbientStrength'   ,   0.15                ,   ...
            'LineWidth'         ,   1                   ,   ...
            'FaceAlpha'         ,   0.7                     ...
            );
        grid on;
        hTitle1 = title('mesh');
        material('dull');
        camlight('headlight');
        axis equal;
        
    % Plot the cross-sections.
    hs2 = subplot(1,2,2);
        for numPoly = 1:numel(polygonsCell)
            color = 'none';
            hold on
            hPoly = patch(                  ...
                polygonsCell{numPoly}(:,1), ...
                polygonsCell{numPoly}(:,2), ...
                polygonsCell{numPoly}(:,3), 'k');
            set(                            ...
                hPoly                   ,   ...
                'FaceColor' ,   color   ,   ...
                'EdgeColor' ,   'k'     ,   ...
                'LineWidth' ,   2       ,   ...
                'FaceAlpha' ,   0.7         ...
                );
        end
        grid on;
        hTitle2 = title('plane/mesh cross-sections');
        axis equal;
    set([hTitle1,hTitle2],'FontSize',14);
    set([hs1,hs2],'View',[-105,15]);
    set(hfig1,'Color','w');
    set(hs2,'XLim',[-0.2,1.2],'YLim',[-0.2,1.2],'ZLim',[0.5,1.8]);