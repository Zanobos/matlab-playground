% Generates a Huffman codebook for a specified set of symbol probabilities
% Rob Maunder 24/02/2010

% Copyright © 2010 Robert G. Maunder. This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.


clear all

% Define your symbol probabilities here

% Simple test
% probabilities = [0.1 0.2 0.3 0.4];

% Letters        A      B      C      D      E      F      G      H      I      J      K      L      M      N      O      P      Q      R      S      T      U      V      W      X      Y      Z
%probabilities = [0.0856 0.0139 0.0279 0.0378 0.1304 0.0289 0.0199 0.0528 0.0627 0.0013 0.0042 0.0339 0.0249 0.0707 0.0797 0.0199 0.0012 0.0677 0.0607 0.1045 0.0249 0.0092 0.0149 0.0017 0.0199 0.0008];

% Max-Lloyd quantiser of Gaussian distributed samples having zero mean and unity variance
% 2 levels:      -0.7970    0.7970
%probabilities = [ 0.5000    0.5000];

% 3 levels:      -1.2242         0    1.2242
%probabilities = [ 0.2706    0.4588    0.2706];

% 4 levels:      -1.5103   -0.4520    0.4520    1.5103
%probabilities = [ 0.1634    0.3366    0.3366    0.1634];

% 5 levels:      -1.7228   -0.7633         0    0.7633    1.7228
%probabilities = [ 0.1071    0.2439    0.2979    0.2439    0.1071];

% 6 levels:      -1.8941   -1.0011   -0.3182    0.3182    1.0011    1.8941
%probabilities = [ 0.0735    0.1813    0.2452    0.2452    0.1813    0.0735];

% 7 levels:      -2.0366   -1.1893   -0.5613         0    0.5613    1.1893    2.0366
%probabilities = [ 0.0534    0.1373    0.1992    0.2202    0.1992    0.1373    0.0534];

% 8 levels:      -2.1491   -1.3421   -0.7536   -0.2441    0.2441    0.7536    1.3421    2.1491
probabilities = [ 0.0406    0.1070    0.1611    0.1913    0.1913    0.1611    0.1070    0.0406];


% Normalise the probabilities
probabilities = probabilities/sum(probabilities);

% For each probability...
for index = 1:length(probabilities)
    % ...create an empty codeword
    codewords{index} = [];
    % Create a set containing only this codeword
    set_contents{index} = index;
    % Store the probability associated with this set
    set_probabilities(index) = probabilities(index);
end

disp('-------------------------------------------------------------------------');
disp('The sets of symbols and their probabilities are:')
for set_index = 1:length(set_probabilities)
    disp([num2str(set_probabilities(set_index)),'    ', num2str(set_contents{set_index})]);
end
    
% Keep going until all the sets have been merged into one
while length(set_contents) > 1
    
    % Determine which sets have the lowest total probabilities
    [temp, sorted_indices] = sort(set_probabilities);

    % Get the set having the lowest probability
    zero_set = set_contents{sorted_indices(1)};
    % Get that probability
    zero_probability = set_probabilities(sorted_indices(1));
    % For each codeword in the set...
    for codeword_index = 1:length(zero_set)
        % ...append a zero
        codewords{zero_set(codeword_index)} = [codewords{zero_set(codeword_index)}, 0];       
    end
    
    % Get the set having the second lowest probability
    one_set = set_contents{sorted_indices(2)};
    % Get that probability
    one_probability = set_probabilities(sorted_indices(2));
    % For each codeword in the set...
    for codeword_index = 1:length(one_set)
        % ...append a one
        codewords{one_set(codeword_index)} = [codewords{one_set(codeword_index)}, 1];       
    end

    disp('The symbols, their probabilities and the allocated bits are:');
    % For each codeword...
    for index = 1:length(codewords)
        % ...display its bits
        disp([num2str(index),'    ',num2str(probabilities(index)),'    ',num2str(codewords{index})]);
    end
    
    % Remove the two sets having the lowest probabilities...
    set_contents(sorted_indices(1:2)) = [];
    % ...and merge them into a new set
    set_contents{length(set_contents)+1} = [zero_set, one_set];
    
    % Remove the two lowest probabilities...
    set_probabilities(sorted_indices(1:2)) = [];
    % ...and give their sum to the new set
    set_probabilities(length(set_probabilities)+1) = zero_probability + one_probability;
            
    disp('The sets and their probabilities are:')
    for set_index = 1:length(set_probabilities)
        disp([num2str(set_probabilities(set_index)),'    ', num2str(set_contents{set_index})]);
    end
    
    
end

disp('-------------------------------------------------------------------------');
disp('The symbols, their probabilities and the allocated Huffman codewords are:');
% For each codeword...
for index = 1:length(codewords)
    % ...display its bits in reverse order
    disp([num2str(index), '    ', num2str(probabilities(index)),'    ',num2str(codewords{index}(length(codewords{index}):-1:1))]);
end

% Calculate the symbol entropy
entropy = sum(probabilities.*log2(1./probabilities));

% Calculate the average Huffman codeword length
av_length = 0;
for index = 1:length(codewords)
    av_length = av_length + probabilities(index)*length(codewords{index});
end

disp(['The symbol entropy is:                     ',num2str(entropy)]);
disp(['The average Huffman codeword length is:    ',num2str(av_length)]);
disp(['The Huffman coding rate is:                ',num2str(entropy/av_length)]);

