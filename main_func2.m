function [A omega V] = main_func2(filename)


    % known variables    
    theta = 0;
    rmin = 0.0482;  %m
    rmax = 0.05875;   %m
    zmax = 0.026725;  %m
    numpoles = 8;   %number of poles in alternator
   
    
    
    % import data from file
    fileID=fopen(filename);
    DATA = textscan(fileID,'%f %f %f %f %f %f %*[^\n]','Delimiter',' ', 'MultipleDelimsAsOne', 1);
    fclose(fileID);
  
    
    [x, y, z, vx, vy, vz] = selectPoints(DATA{1},DATA{3},DATA{2},DATA{4},DATA{5},DATA{6},rmin,rmax,zmax);
    % This selects the points we within the stator
    
    figure;
    scatter3(x,y,z,0.1)
    [r, theta, z]=toCylind(x,y,z); 
    %Converts to cylindrical coordinates
    
    magVal = magDir(x,y,z,vx,vy,vz);
    % Finds the magnitude of B field vectors pointing away from the center,
    % this will be normal to the stator coils
    
    
    [flux, Theta] = calc_flux(theta,rmin,rmax,zmax,magVal);
    % Divides stator into segments base on angle and calculates the flux in
    % each segment, this will make flux a function of theta.  
    
    
    
    for i = 1:23
        rpms = 100*i;
      [A(i) omega(i) emf V(i)] = flux_vals(flux, numpoles, Theta, rpms);  
    end
   figure 
   rpms=100:100:2300;
  plot(rpms,V)
   
    
    
    
    %For each angular velocity we rewrite flux as a function of time.
    %We then fit it to the equation Flux=(A)sin((omega)t+(phase shift)),
    %and determine the amplitude, voltage and frequency based on the fitted
    %equation    
    
    pause;
    close all;
end
