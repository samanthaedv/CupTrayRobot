qbag = load("q_log.mat")

for i = 0:5
    disp(qbag.q_log((i*6)+1,:))
    disp(qbag.q_log((i*6)+2,:))
    disp(qbag.q_log((i*6)+3,:))
    disp(qbag.q_log((i*6)+4,:))
    disp(qbag.q_log((i*6)+5,:))
    disp(qbag.q_log((i*6)+6,:))
end
