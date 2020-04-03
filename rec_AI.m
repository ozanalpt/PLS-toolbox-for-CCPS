function [security_AI,QoS_AI] = rec_AI(x_array,y_array,loc_weight,Pos_a,Pos_b,Pos_j,P_s,P_w,P_j,sim)
d_ab=sqrt((Pos_a(1)-Pos_b(1))^2+(Pos_a(2)-Pos_b(2))^2);
d_jb=sqrt((Pos_j(1)-Pos_b(1))^2+(Pos_j(2)-Pos_b(2))^2);
Pj=10^(P_j/10); %linear scalar
P_s_lin=10^(P_s/10); 
P_w_lin_array=10.^(P_w./10);
No=1; 
%erg_C=zeros(length(x_array),length(y_array));
Sec_pres=zeros(size(P_w));
for cnt_3=1:length(P_w_lin_array)
    Pw=P_w_lin_array(cnt_3);
    for cnt_2=1:length(x_array)
        for cnt_1=1:length(y_array)
            x_e=x_array(cnt_2);
            y_e=y_array(cnt_1);
            d_ae=sqrt((Pos_a(1)-x_e)^2+(Pos_a(2)-y_e)^2);
            d_je=sqrt((Pos_j(1)-x_e)^2+(Pos_j(2)-y_e)^2);
            d_be=sqrt((Pos_b(1)-x_e)^2+(Pos_b(2)-y_e)^2);

CC=0;
Qos=0;
for cnt=1:sim
    h_ab=(sqrt(0.5)/d_ab)*(randn(1,1)+1i*randn(1,1));
    h_ae=(sqrt(0.5)/d_ae)*(randn(1,1)+1i*randn(1,1));
    h_be=(sqrt(0.5)/d_be)*(randn(1,1)+1i*randn(1,1));
    h_jb=(sqrt(0.5)/d_jb)*(randn(1,1)+1i*randn(1,1));
    h_je=(sqrt(0.5)/d_je)*(randn(1,1)+1i*randn(1,1));
    
SINR_b=(abs(h_ab)^2*P_s_lin)/(No+abs(h_jb)^2*Pj);
SINR_e=(abs(h_ae)^2*P_s_lin)/(abs(h_be)^2*Pw+No+abs(h_je)^2*Pj);
C_s=max([0,(log2(1+SINR_b)-log2(1+SINR_e))]);
CC=CC+C_s;
Qos=Qos+SINR_b;
end
QoS_AI(cnt_3)=Qos/sim;
ergg_C(cnt_2,cnt_1)=(CC/sim);
erg_C(cnt_2,cnt_1)=loc_weight(cnt_2,cnt_1)*(CC/sim);
        end
    end
Sec_pres(cnt_3)=sum(sum(erg_C));
figure
 [XX,YY] = meshgrid(x_array,y_array);
 surf(XX,YY,ergg_C.','LineStyle','non','FaceColor','interp')
 hold on
 scatter3(-1,0,1,'k','filled')
 hold on
 scatter3(1,0,1,'k','filled')
  hold on
  scatter3(0,-1,1,'k','filled')
 view(2)
end
security_AI=Sec_pres;
end
