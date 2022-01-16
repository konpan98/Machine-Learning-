function y=take_array(k,test0,test1,test2,test3,test4,test5,test6,test7,test8,test9)
y=(k==1).*test0+(k==2).*test1+(k==3).*test2+(k==4).*test3+(k==5).*test4+(k==6).*test5+...
    (k==7).*test6+(k==8).*test7+(k==9).*test8+(k==10).*test9;
end