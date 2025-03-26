% 초기 좌표 설정
x1_0 = -3.44; y1_0 = -14.09; % 들것, 링크 1의 초기 좌표
x2_0 = -3.44; y2_0 = -18.09; % 들것, 링크 2의 초기 좌표
a = -15.40; b = -17.07;      % 구동부 아닌 고정관절의 좌표
x0 = -1.44; y0 = -16.09;     % 무게중심 초기 좌표

% 최종 좌표 설정
x1_f = -11.44; y1_f = -9.09; % 들것, 링크 1의 최종 좌표
x2_f = -7.44; y2_f = -8.09;  % 들것, 링크 2의 최종 좌표

% 링크 길이 계산
L1 = sqrt(x1_0^2 + y1_0^2);  % 링크 1의 길이 (구동부 기준)
L2 = sqrt((x2_0 - x1_0)^2 + (y2_0 - y1_0)^2); % 링크 1과 링크 2 사이의 길이
L3 = sqrt((a - x2_0)^2 + (b - y2_0)^2); % 링크 2와 고정관절 사이의 길이

% 초기 각도 계산
theta0 = atan2(y1_0, x1_0); % 링크 1의 초기 각도
phi0 = atan2(y2_0 - y1_0, x2_0 - x1_0); % 링크 2의 초기 각도
alpha0 = atan2(b - y2_0, a - x2_0); % 링크 2와 고정관절 사이의 초기 각도

% 최종 각도 계산
theta_f = atan2(y1_f, x1_f); % 링크 1의 최종 각도
phi_f = atan2(y2_f - y1_f, x2_f - x1_f); % 링크 2의 최종 각도

% theta의 변화 범위 설정
theta_values = linspace(theta0, theta_f, 100); % 초기 각도에서 최종 각도까지
y1_values = zeros(size(theta_values));
y2_values = zeros(size(theta_values));
y0_values = zeros(size(theta_values));

options = optimset('Display', 'none');

for i = 1:length(theta_values)
    theta = theta_values(i);
    
    % 링크 1의 새로운 좌표 계산
    x1 = L1 * cos(theta);
    y1 = L1 * sin(theta);
    y1_values(i) = y1;

    % 연립 방정식을 수치적으로 풀기
    fun = @(vars) [
        L1 * cos(theta) + L2 * cos(vars(1)) + L3 * cos(vars(2)) - a;
        L1 * sin(theta) + L2 * sin(vars(1)) + L3 * sin(vars(2)) - b
    ];
    
    vars0 = [phi0, alpha0]; % 초기 추정값 설정
    sol = fsolve(fun, vars0, options);
    phi = sol(1);
    alpha = sol(2);

        % 링크 2의 새로운 좌표 계산
    x2 = x1 + L2 * cos(phi);
    y2 = y1 + L2 * sin(phi);
    y2_values(i) = y2;

    % 무게중심의 새로운 좌표 계산 (회전 변환 좌표계 사용)
    % 초기 무게중심 좌표와 링크 좌표간의 관계 유지
    x0_rel = cos(-theta0) * (x0 - x1_0) - sin(-theta0) * (y0 - y1_0);
    y0_rel = sin(-theta0) * (x0 - x1_0) + cos(-theta0) * (y0 - y1_0);

    % 변환된 좌표를 기준 좌표계로 다시 변환
    x0_new = x1 + cos(theta) * x0_rel - sin(theta) * y0_rel;
    y0_new = y1 + sin(theta) * x0_rel + cos(theta) * y0_rel;

    y0_values(i) = y0_new;
end

% 그래프 그리기
figure;
subplot(2, 1, 1); % 첫 번째 그래프
plot(theta_values, y1_values, 'LineWidth', 2);
hold on;
plot(theta_values, y2_values, 'LineWidth', 2);
plot([theta0, theta_f], [y1_0, y1_f], 'ro', 'MarkerSize', 10, 'LineWidth', 2); % 초기 및 최종 좌표 표시
plot([theta0, theta_f], [y2_0, y2_f], 'bo', 'MarkerSize', 10, 'LineWidth', 2); % 초기 및 최종 좌표 표시
xlabel('\theta (rad)');
ylabel('y 좌표');
title('\theta의 변화에 따른 y_1 및 y_2 좌표의 변화');
legend('y_1', 'y_2', 'y_1 초기/최종', 'y_2 초기/최종');
grid on;

subplot(2, 1, 2); % 두 번째 그래프
plot(theta_values, y0_values, 'LineWidth', 2);
xlabel('\theta (rad)');
ylabel('y_0 좌표');
title('\theta의 변화에 따른 y_0 좌표의 변화');
grid on;

% y1, y2, y0 값 출력
disp('y1_values:');
disp(y1_values);
disp('y2_values:');
disp(y2_values);
disp('y0_values:');
disp(y0_values);
