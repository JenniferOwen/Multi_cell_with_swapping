function [num_neighbours_1,num_neighbours_2]=check_neighbours(R,C,original_R,original_C,domain_matrix,sizex,sizey,no_move)

num_neighbours_1=0;
num_neighbours_2=0;
if C<sizey && (R~=original_R || C+1~=original_C)
    if domain_matrix(R,C+1)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R,C+1)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end
if C<sizey && R>1 && (R-1~=original_R || C+1~=original_C)
    if domain_matrix(R-1,C+1)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R-1,C+1)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end
if C<sizey && R<sizex && (R+1~=original_R || C+1~=original_C)
    if domain_matrix(R+1,C+1)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R+1,C+1)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end
if C>1 && R>1 && (R-1~=original_R || C-1~=original_C)
    if domain_matrix(R-1,C-1)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R-1,C-1)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end
if C>1 && R<sizex && (R+1~=original_R || C-1~=original_C)
    if domain_matrix(R+1,C-1)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R+1,C-1)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end
if C>1  && (R~=original_R || C-1~=original_C)
    if domain_matrix(R,C-1)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R,C-1)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end
if R<sizex  && (R+1~=original_R || C~=original_C)
    if domain_matrix(R+1,C)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R+1,C)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end
if R>1 && (R-1~=original_R || C~=original_C)
    if domain_matrix(R-1,C)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R-1,C)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end

if no_move==0 % only if we are checking for movement scenario
    if domain_matrix(R,C)==1
        num_neighbours_1=num_neighbours_1+1;
    elseif domain_matrix(R,C)==2
        num_neighbours_2=num_neighbours_2+1;
    end
end

end