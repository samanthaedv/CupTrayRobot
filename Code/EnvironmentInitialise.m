function environment = EnvironmentInitialise


hold on;

    % Initialize an empty environment structure array
    environment = struct('model', {}, 'vertices', {}, 'transform', {});

    % Bench object
    benchTransform = [1, 0, 0, 0;
                      0, 1, 0, 0;
                      0, 0, 1, 0;
                      0, 0, 0, 1];
    benchObj = Bench(benchTransform);  % Bench class handles positioning
    environment(end+1).model = benchObj.benchModel;
    environment(end).vertices = benchObj.vertices(:, 1:3);  % Initial vertices
    environment(end).transform = benchTransform;

    % First Aid Kit
    firstAidModel = PlaceObject('FirstAidKit.ply');
    vertices = [get(firstAidModel, 'Vertices'), ones(size(get(firstAidModel, 'Vertices'), 1), 1)];
    firstAidTransform = transl(-0.7, 16, 4) * 0.25;
    transformedVertices = vertices * firstAidTransform';
    set(firstAidModel, 'Vertices', transformedVertices(:, 1:3));
    environment(end+1).model = firstAidModel;
    environment(end).vertices = transformedVertices(:, 1:3);
    environment(end).transform = firstAidTransform;

    % E-stop
    eStopModel = PlaceObject('estop.ply');
    vertices = [get(eStopModel, 'Vertices'), ones(size(get(eStopModel, 'Vertices'), 1), 1)];
    eStopTransform = transl(1.4, 1, 0) * trotx(pi/2);
    transformedVertices = vertices * eStopTransform';
    set(eStopModel, 'Vertices', transformedVertices(:, 1:3));
    environment(end+1).model = eStopModel;
    environment(end).vertices = transformedVertices(:, 1:3);
    environment(end).transform = eStopTransform;

    % Spill Kit
    spillKitModel = PlaceObject('SpillKit.ply');
    vertices = [get(spillKitModel, 'Vertices'), ones(size(get(spillKitModel, 'Vertices'), 1), 1)];
    spillKitTransform = transl(2.3, -0.2, 0) * trotx(pi/2) * troty(pi) * 0.75;
    transformedVertices = vertices * spillKitTransform';
    set(spillKitModel, 'Vertices', transformedVertices(:, 1:3));
    environment(end+1).model = spillKitModel;
    environment(end).vertices = transformedVertices(:, 1:3);
    environment(end).transform = spillKitTransform;

    % Fence
    fenceModel = PlaceObject('fencetest.ply');
    vertices = [get(fenceModel, 'Vertices'), ones(size(get(fenceModel, 'Vertices'), 1), 1)];
    fenceTransform = transl(-1.5, -3, 0.8) * trotx(pi/2);
    transformedVertices = vertices * fenceTransform';
    transformedVertices(:, 2) = transformedVertices(:, 2) * 0.75; % Adjust Y-axis scale
    set(fenceModel, 'Vertices', transformedVertices(:, 1:3));
    environment(end+1).model = fenceModel;
    environment(end).vertices = transformedVertices(:, 1:3);
    environment(end).transform = fenceTransform;

    % Table
    tableModel = PlaceObject('table.ply');
    vertices = [get(tableModel, 'Vertices'), ones(size(get(tableModel, 'Vertices'), 1), 1)];
    tableTransform = transl(1.4, 1, 0);
    transformedVertices = vertices * tableTransform';
    set(tableModel, 'Vertices', transformedVertices(:, 1:3));
    environment(end+1).model = tableModel;
    environment(end).vertices = transformedVertices(:, 1:3);
    environment(end).transform = tableTransform;

    drawnow;




end