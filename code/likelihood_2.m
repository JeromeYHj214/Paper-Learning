clc;clear;close;
m_x1 = [4 16];  S_x1 = 0.1 * eye(2);
m_e2 = [4 -4];  S_e2 = 0.1 * eye(2);
m_e3 = [4 -4];  S_e3 = 0.1 * eye(2);
m_e4 = [4 -4];  S_e4 = 0.1 * eye(2);
m_n1 = [0 0];   S_n1 = 0.1 * eye(2);
m_n2 = [0 0];   S_n2 = 0.1 * eye(2);
m_n3 = [0 0];   S_n3 = 0.1 * eye(2);
m_n4 = [0 0];   S_n4 = 0.1 * eye(2);
m_x2 = m_x1 + m_e2;     S_x2 = S_x1 + S_e2;
m_x3 = m_x2 + m_e3;     S_x3 = S_x2 + S_e3;
m_x4 = m_x3 + m_e4;     S_x4 = S_x3 + S_e4;
m_d1 = m_x1 + m_n1;     S_d1 = S_x1 + S_n1;
m_d2 = m_x2 + m_n2;     S_d2 = S_x2 + S_n2;
m_d3 = m_x3 + m_n3;     S_d3 = S_x3 + S_n3;
m_d4 = m_x4 + m_n4;     S_d4 = S_x4 + S_n4;
load('data.mat');
figure(1);
for i = 1:100
    subplot(10,10,i)
    plot(X1{i}(:,1),X1{i}(:,2),'+','color','b')
    hold on;
end
figure(2);
for i = 1:100
    plot(X1{i}(:,1),X1{i}(:,2),'+','color','b')
    hold on;
end

all_val_lh = zeros(1,100);
for i = 1:100
    l = size(X1{i},1)
    if l==1
        val = 0.05/4*factorial(l)
        
        for j = 1:l
            if X1{i}(j,3) == 1
                val = val * 1/(2*pi*det(S_d1)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1)*S_d1^-1*(X1{i}(j,1:2)-m_x1)')
            elseif X1{i}(j,3) == 2
                val = val * 1/(2*pi*det(S_d2)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2)*S_d2^-1*(X1{i}(j,1:2)-m_x1-m_e2)')
            elseif X1{i}(j,3) == 3
                val = val * 1/(2*pi*det(S_d3)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)*S_d3^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)')
            else
                val = val * 1/(2*pi*det(S_d4)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)*S_d4^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)')
            end
        end
        
    elseif l==2
        val = 0.1/6*factorial(l);
        
        for j = 1:l
            if X1{i}(j,3) == 1
                val = val * 1/(2*pi*det(S_d1)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1)*S_d1^-1*(X1{i}(j,1:2)-m_x1)')
            elseif X1{i}(j,3) == 2
                val = val * 1/(2*pi*det(S_d2)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2)*S_d2^-1*(X1{i}(j,1:2)-m_x1-m_e2)')
            elseif X1{i}(j,3) == 3
                val = val * 1/(2*pi*det(S_d3)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)*S_d3^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)')
            else
                val = val * 1/(2*pi*det(S_d4)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)*S_d4^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)')
            end
        end
    
    elseif l==3
        val = 0.15/4*factorial(l)
        
        for j = 1:l
            if X1{i}(j,3) == 1
                val = val * 1/(2*pi*det(S_d1)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1)*S_d1^-1*(X1{i}(j,1:2)-m_x1)')
            elseif X1{i}(j,3) == 2
                val = val * 1/(2*pi*det(S_d2)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2)*S_d2^-1*(X1{i}(j,1:2)-m_x1-m_e2)')
            elseif X1{i}(j,3) == 3
                val = val * 1/(2*pi*det(S_d3)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)*S_d3^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)')
            else
                val = val * 1/(2*pi*det(S_d4)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)*S_d4^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)')
            end
        end
        
    else
        val = 0.7*factorial(l)
        
       for j = 1:l
            if X1{i}(j,3) == 1
                val = val * 1/(2*pi*det(S_d1)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1)*S_d1^-1*(X1{i}(j,1:2)-m_x1)')
            elseif X1{i}(j,3) == 2
                val = val * 1/(2*pi*det(S_d2)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2)*S_d2^-1*(X1{i}(j,1:2)-m_x1-m_e2)')
            elseif X1{i}(j,3) == 3
                val = val * 1/(2*pi*det(S_d3)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)*S_d3^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)')
            else
                val = val * 1/(2*pi*det(S_d4)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)*S_d4^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)')
            end
        end
        
    end
    all_val_lh(i) = val
end
likelihood = reshape(all_val_lh,10,10)'