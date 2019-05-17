function [ goldCode ] = GenerateGoldCode( firstTap, secondTap )
%GENERATEGOLDCODE Summary of this function goes here
%   Detailed explanation goes here

    codeLength = 1023;
    goldCode = zeros(1,codeLength);
    gOne = ones(1,10);
    gTwo = ones(1,10);
    
    for i = 1 : codeLength
        
        goldCode(i) = mod(gOne(end) + gTwo(firstTap) + gTwo(secondTap),2);
                
        nextGone = mod(gOne(3) + gOne(10),2);
        nextGTwo = mod(gTwo(2) + gTwo(3) + gTwo(6) + gTwo(8) + gTwo(9) + gTwo(10),2);
        
        gOne = circshift(gOne,[0,1]);
        gTwo = circshift(gTwo,[0,1]);
        
        gOne(1) = nextGone;
        gTwo(1) = nextGTwo;
        
    end   
    
%   From 0 1 signal to -1 1
    goldCode = -(goldCode-1/2)*2;
end

