set(groot, ...
    'DefaultFigureColor', 'w', ...
    'DefaultAxesLineWidth', 2, ...
    'DefaultAxesXColor', 'k', ...
    'DefaultAxesYColor', 'k', ...
    'DefaultAxesFontUnits', 'points', ...
    'DefaultAxesFontSize', 18, ...
    'DefaultAxesFontName', 'Helvetica', ...
    'DefaultLineLineWidth', 1, ...
    'DefaultTextFontUnits', 'Points', ...
    'DefaultTextFontSize', 18, ...
    'DefaultTextFontName', 'Helvetica', ...
    'DefaultAxesBox', 'off', ...
    'DefaultAxesTickLength', [0.02 0.025],...
    'DefaultLineLineWidth',3);

green = [0 200 0]./255;
grey = [169 169 169]./255;
red =  [255 0 0]./255;
yellow = [255 230 51]./255;
blue = [0 0 255]./255;
orange = [255 140 0]./255;

% x=[1,2,3,4];
% male1=[520, 606, 591, 358];
% male2=[825, 639, 819, 553];
% figure
% plot(x,male1,'-ko',x, male2, '-ko')
% xticks([1 2 3 4]); %tick mark position
% labels = {'Day 1(Saline)', 'Day 2(Saline)', 'Day 3(Saline)', 'Day 4(Psilocyin)'};
% xticklabels(labels);
% ylabel('Number of Vocalizations')
% title('Psilocybin')
% ylim([0,1000])
% %legend({'Male 1', 'Male 2'})
% 
% clear h;
% figure; hold on;
% male1=[902,777,784,197];
% male2=[759,758,875,3];
% figure
% plot(x,male1,'-ko',x, male2, '-ko')
% xticks([1 2 3 4]); %tick mark position
% labels = {'Day 1(Saline)', 'Day 2(Saline)', 'Day 3(Saline)', 'Day 4(Ketamine)'};
% xticklabels(labels);
% ylabel('Number of Vocalizations')
% title('Ketamine')
% ylim([0,1000])
% %legend({'Male 1', 'Male 2'})
%% Getting data from file
data=xlsread('USV_data.xlsx');
data1=data(:,1:2:30);
data2=data1(~isnan(data1));

ordered_data=[];
new_row=[];
for k=1:240
    new_row=[new_row,data2(k)];
    if rem(k,16)==0
        ordered_data=[ordered_data;new_row];
        new_row=[];
    end
end
baseline_av=[];
nrb=[];
test_days=[];
nrt=[];
for j=1:15
    nrb=[mean(ordered_data(j,1:3)), mean(ordered_data(j,5:7)), mean(ordered_data(j,9:11)), mean(ordered_data(j,13:15))];
    baseline_av=[baseline_av;nrb];
    nrb=[];
    
    nrt=[ordered_data(j,4), ordered_data(j,8), ordered_data(j,12), ordered_data(j,16)];
    test_days=[test_days;nrt];
    nrt=[];
end

%psilo_pdec=1-test_days(:,1)./baseline_av(:,1);
psilo=[baseline_av(:,1),test_days(:,1)];
%ket_pdec=1-test_days(:,2)./baseline_av(:,2);
ket=[baseline_av(:,2),test_days(:,2)];
%fmeodmt_pdec=1-test_days(:,3)./baseline_av(:,3);
fmeodmt=[baseline_av(:,3),test_days(:,3)];
%sfdet_pdec=1-test_days(:,4)./baseline_av(:,4);
sfdet=[baseline_av(:,4),test_days(:,4)];

%% Tests
% [~,p]=ttest(psilo(:,1),psilo(:,2));
% fprintf('Psilocybin Effect: p = %f\n', p)
% [~,p]=ttest(ket(:,1),ket(:,2));
% fprintf('Ketamine Effect: p = %f\n', p)
% [~,p]=ttest(fmeodmt(:,1),fmeodmt(:,2));
% fprintf('5-MeO-DMT Effect: p = %f\n', p)
% [~,p]=ttest(sfdet(:,1),sfdet(:,2));
% fprintf('6-F-DET Effect: p = %f\n', p)

p=signrank([psilo(:,1)-psilo(:,2)]);
fprintf('Sign rank psilocybin Effect: p = %f\n', p)
p=signrank([ket(:,1)-ket(:,2)]);
fprintf('Sign rank ketamine Effect: p = %f\n', p)
p=signrank([fmeodmt(:,1)-fmeodmt(:,2)]);
fprintf('Sign rank 5-MeO-DMT Effect: p = %f\n', p)
p=signrank([sfdet(:,1)-sfdet(:,2)]);
fprintf('Sign rank 6-F-DET Effect: p = %f\n', p)

%% Plotting
psilo_week=ordered_data(:,1:4);
psilo_means=mean(psilo_week,1);

ket_week=ordered_data(:,5:8);
ket_means=mean(ket_week,1);

fmeodmt_week=ordered_data(:,9:12);
fmeodmt_means=mean(fmeodmt_week,1);

sfdet_week=ordered_data(:,13:16);
sfdet_means=mean(sfdet_week,1);

clear h;
figure; hold on;

bar(1,psilo_means(1),'FaceColor',blue);
bar(2,psilo_means(2),'FaceColor',blue);
bar(3,psilo_means(3),'FaceColor',blue);
bar(4,psilo_means(4),'FaceColor',red);
xticks([1 2 3 4]);
labels = {'Day 1(Saline)', 'Day 2(Saline)', 'Day 3(Saline)', 'Day 4(Psilocybin)'};
xticklabels(labels);
ylim([0,1250])
for j=1:15
    plot(1:4, psilo_week(j,1:4),'k-','MarkerSize', 12, 'LineWidth', 2, 'Color', 'k');
end
ylabel('Number of Vocalizations')
title('Psilocybin')

clear h;
figure; hold on;
bar(1,ket_means(1),'FaceColor',blue);
bar(2,ket_means(2),'FaceColor',blue);
bar(3,ket_means(3),'FaceColor',blue);
bar(4,ket_means(4),'FaceColor',red);
xticks([1 2 3 4]);
labels = {'Day 1(Saline)', 'Day 2(Saline)', 'Day 3(Saline)', 'Day 4(Ketamine)'};
xticklabels(labels);
ylim([0,1250])
for j=1:15
    plot(1:4, ket_week(j,1:4),'k-','MarkerSize', 12, 'LineWidth', 2, 'Color', 'k');
end
ylabel('Number of Vocalizations')
title('Ketamine')

clear h;
figure; hold on;
bar(1,fmeodmt_means(1),'FaceColor',blue);
bar(2,fmeodmt_means(2),'FaceColor',blue);
bar(3,fmeodmt_means(3),'FaceColor',blue);
bar(4,fmeodmt_means(4),'FaceColor',red);
xticks([1 2 3 4]);
labels = {'Day 1(Saline)', 'Day 2(Saline)', 'Day 3(Saline)', 'Day 4(5-MeO-DMT)'};
xticklabels(labels);
ylim([0,1250])
for j=1:15
    plot(1:4, fmeodmt_week(j,1:4),'k-','MarkerSize', 12, 'LineWidth', 2, 'Color', 'k');
end
ylabel('Number of Vocalizations')
title('5-MeO-DMT')

clear h;
figure; hold on;
bar(1,sfdet_means(1),'FaceColor',blue);
bar(2,sfdet_means(2),'FaceColor',blue);
bar(3,sfdet_means(3),'FaceColor',blue);
bar(4,sfdet_means(4),'FaceColor',red);
xticks([1 2 3 4]);
labels = {'Day 1(Saline)', 'Day 2(Saline)', 'Day 3(Saline)', 'Day 4(6-F-DET)'};
xticklabels(labels);
ylim([0,1250])
for j=1:15
    plot(1:4, sfdet_week(j,1:4),'k-','MarkerSize', 12, 'LineWidth', 2, 'Color', 'k');
end
ylabel('Number of Vocalizations')
title('6-F-DET')

%% Getting vocalization type data
% v_data=clipboard('pastespecial');
% v_data=struct2cell(v_data);
% v_data=v_data{1};
% v_data=regexprep(v_data,'\s','');
% v_types=[matches(v_data,'chevron'),matches(v_data,'rev_chevron'),matches(v_data,'down_fm'),matches(v_data,'up_fm'),matches(v_data,'flat'),matches(v_data,'short'),matches(v_data,'complex'),matches(v_data,'step_up'),matches(v_data,'step_down'),matches(v_data,'two_steps'),matches(v_data,'mult_steps')];
% sum(v_types)
%% Polar Plots for Vocalization Types After Each Drug Injection
%a+bi=rho(cos(theta)+i*sin(theta))
%a=rho*cos(theta)
%b=rho*sin(theta)

set(groot, ...
    'DefaultFigureColor', 'w', ...
    'DefaultAxesLineWidth', 2, ...
    'DefaultAxesXColor', 'k', ...
    'DefaultAxesYColor', 'k', ...
    'DefaultAxesFontUnits', 'points', ...
    'DefaultAxesFontSize', 18, ...
    'DefaultAxesFontName', 'Helvetica', ...
    'DefaultLineLineWidth', 1, ...
    'DefaultTextFontUnits', 'Points', ...
    'DefaultTextFontSize', 18, ...
    'DefaultTextFontName', 'Helvetica', ...
    'DefaultAxesBox', 'off', ...
    'DefaultAxesTickLength', [0.02 0.025],...
    'DefaultLineLineWidth',1.5);

%for psilocybin
figure;
spacing=2*pi/11;
thetas=[0:10]*spacing;
rho=[0.079482575	0.022615039	0.054104936	0.294734367	0.042360241	0.138603194	0.03843913	0.163925816	0.097733976	0.056276396	0.01172433];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
rlim([0,.5]);
title('Psilocybin')
thetaticks(0:360/11:360)
thetaticklabels({'Chevron';'Rev-chevron';'Down-FM';'Up-FM';'Flat';'Short';'Complex';'Step-up';'Step-down';'Two-steps'; 'Multi-steps'});

%for ketamine
figure;
rho=[0.09039853	0.020317142	0.051010589	0.398031529	0.059382525	0.172821488	0.012544794	0.10296764	0.055231919	0.03267314	0.004620704];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
rlim([0,.5]);
title('Ketamine')
thetaticks(0:360/11:360)
thetaticklabels({'Chevron';'Rev-chevron';'Down-FM';'Up-FM';'Flat';'Short';'Complex';'Step-up';'Step-down';'Two-steps'; 'Multi-steps'});

%for 5-MeO-DMT
% figure;
% rho=[0	0	0.25	0.166666667	0	0.5	0	0.083333333	0	0	0];
% as=rho.*cos(thetas);
% bs=rho.*sin(thetas);
% z=(bs.*i)+as;
% z=[z,z(1)];
% polarplot(z,'-*')
% rlim([0,.5]);
% title('5-MeO-DMT')
% thetaticks(0:360/11:360)
% thetaticklabels({'Chevron';'Rev-chevron';'Down-FM';'Up-FM';'Flat';'Short';'Complex';'Step-up';'Step-down';'Two-steps'; 'Multi-steps'});

%for 6-F-DET
figure;
rho=[0.07330057	0.020101547	0.056563051	0.370274134	0.059913817	0.111529091	0.025816029	0.150265066	0.084935265	0.040339266	0.006962165];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
rlim([0,.5]);
title('6-F-DET')
thetaticks(0:360/11:360)
thetaticklabels({'Chevron';'Rev-chevron';'Down-FM';'Up-FM';'Flat';'Short';'Complex';'Step-up';'Step-down';'Two-steps'; 'Multi-steps'});

%for saline
figure;
rho=[0.088409546	0.020557892	0.052826549	0.24413054	0.035465778	0.045263745	0.040012357	0.216394292	0.1531609	0.081155876	0.022622525];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
rlim([0,.5]);
title('Saline')
thetaticks(0:360/11:360)
thetaticklabels({'Chevron';'Rev-chevron';'Down-FM';'Up-FM';'Flat';'Short';'Complex';'Step-up';'Step-down';'Two-steps'; 'Multi-steps'});
%% 

%Reordered polar plots: {'Up-FM', 'Step_up', 'Chevron', 'Down-FM',
%'Complex', 'Multi-steps', 'Rev-chevron', 'Flat', 'Short', 'Two-steps',
%'Step-down'}
%In terms of saline average ranked: {1 2 4 6 8 10 11 9 7 5 3}
%Can I add error bars?

%for psilocybin
figure;
spacing=2*pi/11;
thetas=[0:10]*spacing;
rho=[0.294734367	0.163925816	0.079482575	0.054104936	0.03843913	0.01172433	0.022615039	0.042360241	0.138603194	0.056276396	0.097733976];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
rlim([0,.5]);
title('Psilocybin')
thetaticks(0:360/11:360)
thetaticklabels({'Up-FM', 'Step-up', 'Chevron', 'Down-FM','Complex', 'Multi-steps', 'Rev-chevron', 'Flat', 'Short', 'Two-steps', 'Step-down'});

hold on

rho=[0.24413054	0.216394292	0.088409546	0.052826549	0.040012357	0.022622525	0.020557892	0.035465778	0.045263745	0.081155876	0.1531609];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
legend('Psilocybin', 'Saline')

%for ketamine
figure;
rho=[0.398031529	0.10296764	0.09039853	0.051010589	0.012544794	0.004620704	0.020317142	0.059382525	0.172821488	0.03267314	0.055231919];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
rlim([0,.5]);
title('Ketamine')
thetaticks(0:360/11:360)
thetaticklabels({'Up-FM', 'Step-up', 'Chevron', 'Down-FM','Complex', 'Multi-steps', 'Rev-chevron', 'Flat', 'Short', 'Two-steps', 'Step-down'});

hold on

rho=[0.24413054	0.216394292	0.088409546	0.052826549	0.040012357	0.022622525	0.020557892	0.035465778	0.045263745	0.081155876	0.1531609];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
legend('Ketamine', 'Saline')
%for 5-MeO-DMT
% figure;
% rho=[0	0	0.25	0.166666667	0	0.5	0	0.083333333	0	0	0];
% as=rho.*cos(thetas);
% bs=rho.*sin(thetas);
% z=(bs.*i)+as;
% z=[z,z(1)];
% polarplot(z,'-*')
% rlim([0,.5]);
% title('5-MeO-DMT')
% thetaticks(0:360/11:360)
% thetaticklabels({'Chevron';'Rev-chevron';'Down-FM';'Up-FM';'Flat';'Short';'Complex';'Step-up';'Step-down';'Two-steps'; 'Multi-steps'});

%for 6-F-DET
figure;
rho=[0.370274134	0.150265066	0.07330057	0.056563051	0.025816029	0.006962165	0.020101547	0.059913817	0.111529091	0.040339266	0.084935265];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
rlim([0,.5]);
title('6-F-DET')
thetaticks(0:360/11:360)
thetaticklabels({'Up-FM', 'Step-up', 'Chevron', 'Down-FM','Complex', 'Multi-steps', 'Rev-chevron', 'Flat', 'Short', 'Two-steps', 'Step-down'});

hold on

rho=[0.24413054	0.216394292	0.088409546	0.052826549	0.040012357	0.022622525	0.020557892	0.035465778	0.045263745	0.081155876	0.1531609];
as=rho.*cos(thetas);
bs=rho.*sin(thetas);
z=(bs.*i)+as;
z=[z,z(1)];
polarplot(z,'-*')
legend('6-F-DET', 'Saline')
% %for saline
% figure;
% rho=[0.246899042 0.20984456 0.088318417 0.052284503 0.040116188 0.023080546 0.021117915 0.035484377 0.04388444 0.083372586 0.155597425];
% as=rho.*cos(thetas);
% bs=rho.*sin(thetas);
% z=(bs.*i)+as;
% z=[z,z(1)];
% polarplot(z,'-*')
% rlim([0,.5]);
% title('Saline')
% thetaticks(0:360/11:360)
% thetaticklabels({'Up-FM', 'Step-up', 'Chevron', 'Down-FM','Complex', 'Multi-steps', 'Rev-chevron', 'Flat', 'Short', 'Two-steps', 'Step-down'});

%% 2-way anova for the vocalization type factor and drug treatment factor
tdata=xlsread('usv_type_data');
v_types=ones(75,11);
for j=1:11
    v_types(:,j)=v_types(:,j)*j;
end
drug_groups=[ones(15,11);2*ones(15,11);3*ones(15,11);4*ones(15,11);5*ones(15,11)];

%generate proportion data
pre_ptdata=zeros(75,11);
for j=1:75
    pre_ptdata(j,:)=tdata(j,:)/sum(tdata(j,:));
end

%Number of vocalizations with 5-MeO-DMT included
p=anovan(tdata(:),{v_types(:) drug_groups(:)},'model','interaction','varnames',{'Vocalization Types', 'Drug Groups'});

%exclude 5-MeO-DMT
tdata=tdata(drug_groups~=3 & ~isnan(pre_ptdata));
ptdata=pre_ptdata(drug_groups~=3 & ~isnan(pre_ptdata));
v_types=v_types(drug_groups~=3 & ~isnan(pre_ptdata));
drug_groups=drug_groups(drug_groups~=3 & ~isnan(pre_ptdata));

% %Exclude NaN's from ptdata
% ptdata=pre_ptdata(~isnan(pre_ptdata));
% pv_types=v_types(~isnan(pre_ptdata));
% pdrug_groups=drug_groups(~isnan(pre_ptdata));

%Number of vocalizations with 5-MeO-DMT excluded
p=anovan(tdata,{v_types drug_groups},'model','interaction','varnames',{'Vocalization Types', 'Drug Groups'});

%Proportion of vocalizations with 5-MeO-DMT excluded
[p,~,stats]=anovan(ptdata,{v_types drug_groups},'model','interaction','varnames',{'Vocalization Types', 'Drug Groups'});
c=multcompare(stats,'Dimension',[1,2]);

%Compare 2A agonists (psilocybin and 6-F-DET) to ketamine
for j = 1:length(drug_groups)
    if drug_groups(j)==1 | drug_groups(j)==4
        drug_groups(j)=1;
    end
end
% [p,~,stats]=anovan(ptdata,{v_types drug_groups},'model','interaction','varnames',{'Vocalization Types', 'Drug Groups'});
% c=multcompare(stats,'Dimension',[1,2]);


