function aRatio = computeAspectRatio(image)
    [num_rows, num_cols] = size(image);

    % Fill your code
    %%calculating width by sybtracting the columns where the digit starts
    %%and where it ends
    start=0; finish=0; i=1; j=1; counter=0;
    for i=1:num_cols
        for j=1:num_rows
            if(image(j,i))~=0
                counter=1;
                break;
            end
        end
        if counter == 1
            start=i;
            break;
        end
    end
    counter=0;
    for i=num_cols:-1:1
        for j=1:num_rows
            if(image(j,i))~=0
                counter=1;
                break;
            end
        end
        if counter == 1
            finish=i;
            break;
        end
    end
    width=finish-start;
    
    start=0; finish=0; i=1; j=1; counter=0;
    for i=1:num_rows
        for j=1:num_cols
            if(image(i,j))~=0
                counter=1;
                break;
            end
        end
        if counter == 1
            start=i;
            break;
        end
    end
    counter=0;
    for i=num_rows:-1:1
        for j=1:num_cols
            if(image(i,j))~=0
                counter=1;
                break;
            end
        end
        if counter == 1
            finish=i;
            break;
        end
    end
    height=finish-start;
    aRatio=width/height;        
                
end

