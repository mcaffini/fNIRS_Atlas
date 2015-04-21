function display_maps_on_pial(DHb,DHbO2)

% written by Matteo Caffini on May, 20 2011 at Fisica, Polimi.
% input: DHb and DHbO2 are the oxy and deoxy hemoglobin concentration maps as calculated by compute_concentration_maps.m

load('atlas.mat'); % atlas.mat contains the pial surface (cat left and right hemispheres) in node and elem format
time = size(DHb,2);

% data normalization by max of maxs
norm = max( max(abs(min(min(DHb))),max(max(DHb))) , max(abs(min(min(DHbO2))),max(max(DHbO2))) );
DHb_norm = DHb / norm;
DHbO2_norm = DHbO2 / norm;

% just a nice colormap
cm = colormap('Jet');
cm(32,:) = [1 1 1];
cm(33,:) = [1 1 1];
close;

% I wanted 8 time steps (thus 8 maps)
titlestring(1,:) = ' 1 -  5 s';
titlestring(2,:) = ' 6 - 10 s';
titlestring(3,:) = '11 - 15 s';
titlestring(4,:) = '16 - 20 s';
titlestring(5,:) = '21 - 25 s';
titlestring(6,:) = '26 - 30 s';
titlestring(7,:) = '31 - 35 s';
titlestring(8,:) = '36 - 40 s';

HbO2 = figure;
nummean=5;
for j=1:1:8
    subplot(2,4,j)
    foo1 = mean(DHbO2_norm(:,((j-1)*nummean+1):(j*nummean)),2);
    trisurf(elem,-nodeX(:,1),nodeX(:,2),nodeX(:,3),foo1), axis equal,shading interp, lighting phong, light
    if j==1
        title({'HbO2';titlestring(j,:)})
    else
        title(titlestring(j,:));
    end
    set(gca,'clim',[-1,1]);
    axis off, grid off
    view(0,0);
    colormap(cm);
end;

Hb = figure;
nummean=5; % number of seconds you want to average to get a time step (my trial was 40 s = 5 s * 8 steps)
for j=1:1:8
    subplot(2,4,j)
    foo1 = mean(DHb_norm(:,((j-1)*nummean+1):(j*nummean)),2);
    trisurf(elem,-nodeX(:,1),nodeX(:,2),nodeX(:,3),foo1), axis equal,shading interp, lighting phong, light
    if j==1
        title({'Hb';titlestring(j,:)})
    else
        title(titlestring(j,:));
    end
    set(gca,'clim',[-1,1]);
    axis off, grid off
    view(0,0);
    colormap(cm);
end;
