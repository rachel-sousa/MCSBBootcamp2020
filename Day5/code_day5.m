% model equations
%f =@(x,y) a*x + b*y; 
%g =@(x,y) c*x + d*y;

%[T, X] = ode45(@(t,x)[f(x(1),x(2));g(x(1),x(2))], [0,1000], [.1,.1] );

I_tot = 100;
K_tot = 1;
P_tot = 1;

k_onA = 10;
k_offA = 10;
k_onI = 10;
k_offI = 10;
k_catI = 10;
k_catA = 100;

dAdt =@(A, I, AP, IK) -k_onA * (P_tot - AP) * A + k_offA * AP + k_catA * IK;
dAPdt =@(A, I, AP, IK) k_onA * (P_tot - AP) * A - k_offA * AP - k_catI * AP;
dIdt =@(A, I, AP, IK) -k_onI * (K_tot - IK) * I + k_offI * IK + k_catI * AP;
dIKdt =@(A, I, AP, IK) k_onI * (K_tot - IK) * I - k_offI * IK - k_catA * IK;

[T, X] = ode45(@(t, x)[dAdt(x(1),x(2),x(3), x(4)); dIdt(x(1),x(2),x(3), x(4)); 
    dAPdt(x(1),x(2),x(3), x(4)); dIKdt(x(1),x(2),x(3), x(4))], [0, 1], [0.0, I_tot, 0.0, 0.0]) 

figure;
plot(T, X)
legend('A', 'I', 'AP', 'IK')

figure;
K_tot = logspace(-3, 2, 50);
A = [];
for k_tot_var = K_tot 
    dAdt =@(A, I, AP, IK) -k_onA * (P_tot - AP) * A + k_offA * AP + k_catA * IK;
    dAPdt =@(A, I, AP, IK) k_onA * (P_tot - AP) * A - k_offA * AP - k_catI * AP;
    dIdt =@(A, I, AP, IK) -k_onI * (k_tot_var - IK) * I + k_offI * IK + k_catI * AP;
    dIKdt =@(A, I, AP, IK) k_onI * (k_tot_var - IK) * I - k_offI * IK - k_catA * IK;

    [T, X] = ode23s(@(t, x)[dAdt(x(1),x(2),x(3), x(4)); dIdt(x(1),x(2),x(3), x(4)); 
        dAPdt(x(1),x(2),x(3), x(4)); dIKdt(x(1),x(2),x(3), x(4))], [0, 1], [0.0, I_tot, 0.0, 0.0]); 
    
    %store A
    A = [A, X(end, 1)];
end
plot(K_tot, A, '*')
xlabel('K_{tot} (log)')
ylabel('Actived Protein')
set(gca, 'XScale', 'log')
