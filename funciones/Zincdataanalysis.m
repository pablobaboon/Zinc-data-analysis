%Imput first data and plots to check everything works. Functions needed for the script are left in the following documents.
clear all
datos1000='datos1000.txt';
ruido1000='datosruido1000.txt';
D=importdata(datos1000,' ',2);
R=importdata(ruido1000,' ',2);
r=R.data(:,2);
d=D.data(:,2);
l=R.data(:,1);
p1000=d-r;%plot(l,p,'-')
T1000=[l,p1000];
dispersion=(l(length(l))-l(1))/length(l);
datos210='datos210.txt';
ruido210='datosruido210.txt';
D=importdata(datos210,' ',2);
R=importdata(ruido210,' ',2);
r=R.data(:,2);
d=D.data(:,2);
l210=R.data(:,1);
p210=d-r;%plot(l210,p210,'-')
T210=[l210,p210];
%This data contains no noise.
%%
%We analyse data in a brute force way using std. 
sigma1=std(T210(:,2)); z1=mean(T210(:,2))+sigma1;
%plot(T210(:,1),T210(:,2),'r');hold on
[z2,xrest1,rest1,I1]=refinado(z1,T210(:,1),T210(:,2));
[z3,xrest2,rest2,I2,z3m]=refinado(z2,xrest1,rest1);
%plot(xrest1,rest1,'b'); hold on
%plot(xrest2,rest2,'k')
%We have already decomposed the data into noise and signal resto. Let's isolate now the spectral lines
lines1=T210(I1,2); xlines1=T210(I1,1); lines2=rest1(I2); xlines2=xrest1(I2);
J1=descomponedor(xlines1,2); J2=descomponedor(xlines2,1);
xmax1=buscador(xlines1,lines1,J1); xmax2=buscador(xlines2,lines2,J2);
[Indexes,xmax2opt]=bcorrelacionador(xmax1,xmax2,0.6);

%%
%Lets repeat the same for 1000
sigma3=std(T1000(:,2)); z4=mean(T210(:,2))+sigma3;
%plot(T1000(:,1),T1000(:,2),'r'); hold on
[z5,xrest3,rest3,I3]=refinado(z4,T1000(:,1),T1000(:,2));
[z6,xrest4,rest4,I4,z6m]=refinado(z5,xrest3,rest3);
[z7,xrest5,rest5,I5]=refinado(z6,xrest4,rest4);
%plot(xrest3,rest3,'b'); hold on
%plot(xrest4,rest4,'y')
%plot(xrest5,rest5,'k')
%legend('Datos sin filtrar','Primer Filtrado','Segundo Filtrado','Tercer Filtrado')
%xlabel('\lambda (nm)')
lines3=T1000(I3,2); xlines3=T1000(I3,1); lines4=rest3(I4); xlines4=xrest3(I4); lines5=rest4(I5); xlines5=xrest4(I5);
J3=descomponedor(xlines3,1); J4=descomponedor(xlines4,1); J5=descomponedor(xlines5,1);
xmax3=buscador(xlines3,lines3,J3); xmax4=buscador(xlines4,lines4,J4);xmax5=buscador(xlines5,lines5,J5);
[Indexes3,xmax5opt1]=bcorrelacionador(xmax3,xmax5,1); [Indexes2,xmax4opt]=bcorrelacionador(xmax3,xmax4,0.8); [Indexes4,xmax5opt]=bcorrelacionador(xmax4opt,xmax5opt1,1);
%% 
%We obtain the main lines from the first analysis, and the secondary, from a more precise computation below
%plot(T210(:,1),T210(:,2))
%hold on
%plot(T1000(:,1),T1000(:,2),'r')
%plot(T210(I1,1),T210(I1,2))
%No line at 330 and 334. The ones of 470 appear. Let's define the lines that appear and the ones that no
LinesDef=[xmax1,xmax4opt,xmax3,462.52]; Impurezas=[517.884,545.851];
%%
%We finally present all plots that are needed .
figure(1)
plot(T1000(:,1),T1000(:,2),'r'); hold on
%plot(xrest3,rest3,'b');
%plot(xrest4,rest4,'y')
area(xrest4,z6*ones(1,length(xrest4)))
%area(xrest4,z6m*ones(1,length(xrest4)))
area(xrest4,-z6*ones(1,length(xrest4)))
xlabel('\lambda(nm)'); ylabel('Intensity'); title('Data for an obturation time: 1000ms');
legend('Spectral lines above \sigma + <z>=0.0163','Area in 1\sigma' )
figure(2)
plot(T210(:,1),T210(:,2),'r');hold on
%plot(xrest1,rest1,'b'); 
%plot(xrest2,rest2,'k')
area(xrest2,z3*ones(1,length(xrest2)))
%area(xrest2,z3m*ones(1,length(xrest2)))
area(xrest2,-z3*ones(1,length(xrest2)))
xlabel('\lambda(nm)'); ylabel('Intensity'); title('Data for an obturation time: 210ms');
legend('Spectral lines above \sigma + <z>=0.0057','Area in 1\sigma' )
figure(3)
plot(xrest3,rest3,'b'); hold on
plot(xrest5,rest5,'k')
xlabel('\lambda(nm)'); ylabel('Intensity'); title('Data for an obturation time: 1000ms');
legend('Possible lines','Noise' )
%%


