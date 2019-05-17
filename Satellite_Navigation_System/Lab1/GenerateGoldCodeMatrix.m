function [ goldCodeMatrix ] = GenerateGoldCodeMatrix(  )
%generate_cold_code Summary of this function goes here
%   Detailed explanation goes here

    numberOfCodes = 32;
    codeLength = 1023;
    goldCodeMatrix = zeros(codeLength,numberOfCodes);
    
    SC = [2 6; 3 7; 4 8; 5 9; 1 9; 2 10; 1 8; 2 9; 3 10; 2 3; 3 4;
        5 6; 6 7; 7 8; 8 9; 9 10; 1 4; 2 5; 3 6; 4 7; 5 8; 6 9;
        1 3; 4 6; 5 7; 6 8; 7 9; 8 10; 1 6; 2 7; 3 8; 4 9];
    
    for index = 1 : numberOfCodes
    
        goldCode = GenerateGoldCode(SC(index,1),SC(index,2));
        goldCodeMatrix(:,index) = goldCode.';
        
    end   
   
end

