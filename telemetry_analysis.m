data = readtable('f1_telemetry.csv');
disp(data.Properties.VariableNames)

%% Step 1 — Load Data
data = readtable('f1_telemetry.csv');

%% Step 2 — Extract Variables
Speed = data.Speed;
Throttle = data.Throttle;
Brake = data.Brake;
nGear = data.nGear;
RPM = data.RPM;
DRS = data.DRS;
X = data.X;
Y = data.Y;
Z = data.Z;

Brake = strcmp(Brake, 'True');
Brake = double(Brake);

%% Step 3 — Compute Distance Along Lap
dist = [0; cumsum(sqrt(diff(X).^2 + diff(Y).^2))];

disp('Section Complete')

%% Step 4 — Track Map (Speed Heatmap)
figure;
scatter(X, Y, 15, Speed, 'filled');
colorbar;
title('Track Map - Speed');
xlabel('Track Position X');
ylabel('Track Position Y');

disp('Section Complete')

%% Step 5 — Speed vs Distance
figure;
plot(dist, Speed);
xlabel('Distance (m)');
ylabel('Speed (km/h)');
title('Speed Profile');

%% Step 6 — Throttle

figure;
plot(dist, Throttle, 'LineWidth', 1.5);

xlabel('Distance along Lap (m)');
ylabel('Throttle (%)');
title('Throttle Application');
disp('Section Complete')

%% Step 7 — Brake

figure;
plot(dist, Brake * 100, 'LineWidth', 1.5);

xlabel('Distance along Lap (m)');
ylabel('Brake (%)');
title('Brake Application');
disp('Section Complete')

%% Step 8 — 3D Track Map

% Clean NaNs
valid = ~isnan(X) & ~isnan(Y) & ~isnan(Z) & ~isnan(Speed);

figure;
scatter3(X(valid), Y(valid), Z(valid), 15, Speed(valid), 'filled');
colorbar;
title('3D Track Map');
xlabel('X');
ylabel('Y');
zlabel('Elevation');
title('3D Track Map');

view(3)
grid on

disp('Section Complete')
