clc
clear all
close all

%%

%   gaussianPlume models the dispersion of a continuous point source, i.e.
%   plume, in various conditions and terrains. The output of gaussianPlume
%   is a 3-dimensional matrix containing the concentrations of the emitted
%   substance over a field with the first dimension (y) representing the
%   cross-wind axis, the second dimension (x) the downwind distance, and
%   the third dimension (z) the vertical axis. The origin is set at the
%   base of the stack unless Briggs plume rise model is used in which case
%   the horizontal (x axis) coordinate is offset such that x=0 marks the 
%   maximum rise of the plume downwind. All units are in <mgs> (meters,
%   grams, seconds) except where noted.
%
%   Most of the equations were taken from the ISC3 User's Manual, Volume
%   II, available online at
%   http://www.epa.gov/scram001/userg/regmod/isc3v2.pdf
%
%   The EPA now has newer software for modeling atmospheric dispersion
%   including AERMOD and CALPUFF
%   http://www.epa.gov/scram001/dispersion_prefrec.htm#aermod as these are
%   their preferred/recommended models.
%
%   C = gaussianPlume(Q) returns the steady-state Gaussian distribution
%   model of a single, continuous point source emitting at a rate of Q
%   grams per second for a 50m physical stack height with no calculations
%   for plume rise, in rural terrain with stability class "F" in the 
%   Guifford-Pasquiill scale. Wind speed is assumed to be 1m/s at the stack
%   tip (50m).


GLC=[];
heights=[1:1:401];
amb_temp= 20;
Stack_Height = 55;
Stack_Diameter = 3;
Exit_Velocity = 6;
exit_temp = 77;
em_rate = 15;
class = ['A', 'B', 'C', 'D', 'E', 'F'];

for css = 1: length(class)
    for i = 1:length(heights)
        C= gaussianPlume(em_rate, 1, Stack_Height,'stability', class(css),'plume_rise_model','none', ...
            'amb_temp', amb_temp,'stack_temp', exit_temp,'stack_diameter', Stack_Diameter, 'terrain','rural', ... 
            'stack_velocity',Exit_Velocity,'reflection', true, 'X', 10000,'Y', 0,'Z', heights(i));
        GLC(i,css) = C*10^6;
        
    end
end

stabilities = {'very unstable','unstable','slightly unstable','neutral','slightly stable','stable'};

figure
for i=1:6
    plot(heights,GLC(:,i),'Linewidth',1.5);
    hold on
end
grid on
grid minor
ylabel('PM Conc. (\mug m^{-3})');
xlabel('Height (m)');
%title(['Class ' class(i)]);
title({'PM concentrations against height projected at 10 km', ...
    'downwind from SUMAS 2 for different stability regimes'});
legend(stabilities);
 
         
     
 
         
        