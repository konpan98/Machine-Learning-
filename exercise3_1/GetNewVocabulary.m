function [newVocabulary, newTermEntropy, new_f] = GetNewVocabulary(r, Vocabulary, e, f)
    %Return the top r words in the Vocabulary (newVocabulary) 
    %    based on their entropy value
    %Also return 
    %   newTermEntropy: their corresponding Entropy value
    %   new_f: the new Term Document Matrix based on the
    %                newVocabulary

    % ADD Your Code Here
    [sorted_e,index]=sort(e);
    newVocabulary=Vocabulary(index(1:r),:);
    newTermEntropy=sorted_e(index(1:r));
    new_f=f(:,index(1:r));
end