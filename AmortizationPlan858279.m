S = input("Input the amount of the loan  ");
installment = input('Indicates A if the installments are in advance and D if they are deferred (do not insert spaces) ','s');
% Possibility of correcting the answer in case there is a typo (A/D)
p=0;
while p==0;
    if strcmpi(installment, 'A');
        p=1;
    elseif strcmpi(installment, 'D');
        p=1;
    else
        disp(" ")
        disp("There is probably a typo. Try rewriting the answer paying attention to capital letters.")
        installment = input('Indicates A if the installments are in advance and D if they are deferred (do not insert spaces) ','s');
    end
end
n = input("Indicates the total number of installments  ");
r = input("Indicates the annual interest rate  ");
t = input("Indicate how many times a year you want to pay the installments  ");
% Interest rate per period
ix=((1+r)^(1/t))-1;
i = input('Indicate if you want the amount of the installments to be constant (Yes or No)  ', 's');
% Possibility of correcting the answer in case there is a typo (Yes/No)
p=0;
while p==0;
    if strcmpi(i, 'Yes');
        p=1;
    elseif strcmpi(i, 'No');
        p=1;
    else
        disp(" ")
        disp("There is probably a typo. Try rewriting the answer paying attention to capital letters.")
        i = input('Indicate if you want the amount of the installments to be constant (Yes or No) ', 's');
    end
end
%% installments are in advance A

if strcmpi(installment, 'A');
    for h=1:n;
        time(h)=h-1;
    end
    time=time';
    
    if strcmpi(i, 'Yes')
        % I find the amount of the installment in the event of an ADVANCED payment and of a CONSTANT amount
        n=n-1;
        x=1;
        for z=1:n;
            x=x+(1+ix)^-z;
            l=z+1;
            arrayinst(l)=1;
        end
        arrayinst(1)=1;
        R=S/x;
        n=n+1;
        disp("The amount of constant "+n+" installments is "+R)
        
    elseif strcmpi(i, 'No')
        % I find the amount of the installment in the event of an ADVANCED payment and of a NOT NECESSARY CONSTANT amount
        disp(" ")
        disp("Indicate the proportion of the installment amounts, for example by writing: ")
        disp("1 if you want it to be of a normal amount,") 
        disp("0.5 if you want the installment to be halved, ")
        disp("2 if you want the installment to have a double value and so on ")
        
        inst = input("Indicates the proportion of the installment number 1   ");
        arrayinst(1)=inst;
        n=n-1;
        for z=1:n;
            l=z+1;
            installment = input("Installment number "+l+"   ");
            inst=inst+installment*(1+ix)^-z;
            arrayinst(l)=installment;
        end
        R=S/inst;
        n=n+1;
        disp("The amount of "+n+" installments is "+R)
        
    end
 
    %I find the installment to pay
    Rk(1)=arrayinst(1)*R;
    %I find the debt on which to calculate the interest(DK)
    DK(1)=(S-Rk(1))*(1+ix);
    %i calcolate the interest rate when the installments are deferred (id)
    id=ix/(1+ix);
    %I find the interest paid (Ik)
    Ik(1)=DK(1)*id;
    %I find the amount of capital paid (Ck)
    Ck(1)=Rk(1)-Ik(1);
    
    
    for k=2:n;
        g=k-1;
        %I find the installment to pay
        Rk(k)=arrayinst(k)*R;
        %I find the debt on which to calculate the interest(DK)
        DK(k)=(DK(g)-Rk(k))*(1+ix);
        %I find the interest paid (Ik)
        Ik(k)=DK(k)*id;
        %I find the amount of capital paid (Ck)
        Ck(k)=Rk(k)-Ik(k);
        
    end
    
       
%% installments are in deferred D   

elseif strcmpi(installment, 'D');
    for h=1:n;
         time(h)=h;
     end
time=time';        
    
    if strcmpi(i, 'Yes')
         % I find the amount of the installment in the event of an DEFERRED payment and of a CONSTANT amount
        x=0;
        for z=1:n;
            x=x+(1+ix)^-z;
            arrayinst(z)=1;
        end
        R=S/x;
        disp("The amount of constant "+n+" installments is "+R)
 
    elseif strcmpi(i, 'No')
         % I find the amount of the installment in the event of an DEFERRED payment and of a NOT NECESSARY CONSTANT amount
        disp(" ")
        disp("Indicate the installment proportion by writing 1 if you want ")
        disp("it to be of a normal amount, 0.5 if you want the installment to be halved, ")
        disp("2 if you want the installment to have a double value, ")
        disp("3 if you want the installment to have a value 3 times greater and so on")

        inst=0;
        for z=1:n;
            w = input("Indicates the proportion of the installment number "+z+"   ");
            arrayinst(z)=w;
            inst=inst+w*(1+ix)^-z;

        end
        R=S/inst;
        disp("The amount of "+n+" installments is "+R)
        
    end
 
    %I find the installment to pay
    Rk(1)=arrayinst(1)*R;
    %I find the interest paid (Ik)
    Ik(1)=S*ix;
    %I find the amount of capital paid (Ck)
    Ck(1)=Rk(1)-Ik(1);
    %I find the debt on which to calculate the interest(DK)
    DK(1)=(S-Ck(1));
    
    
    for k=2:n;
        g=k-1;
        %I find the installment to pay
        Rk(k)=arrayinst(k)*R;
        %I find the interest paid (Ik)
        Ik(k)=DK(g)*ix;
        %I find the amount of capital paid (Ck)
        Ck(k)=Rk(k)-Ik(k);
         %I find the debt on which to calculate the interest(DK)
        DK(k)=DK(g)-Ck(k);
        
    end
    
end

      Installment=Rk';
      Capital_paid=Ck';
      Interest_paid=Ik';
      Remaining_debit=DK';
    % With all the variables found we build the amortization plan, then we create a table
          T = table(time,Installment,Capital_paid,Interest_paid,Remaining_debit)
          if t==1
              disp("Annual interest per period is "+ix)
          elseif t==2
          disp("Semi-annual interest per period is "+ix)
      elseif t==3
          disp("Quarterly interest per period is "+ix)
      elseif t==4
          disp("Trimester interest per period is "+ix)
           elseif t==12
          disp("Monthly interest per period is "+ix)
      else
      disp("The interest per period is "+ix)
      end
      disp("It may happen that the debt remaining in the last period ")
      disp("is a small number other than 0.")
      disp("This is due to the fact that during the calculations the ")
      disp("numerical values have been approximated.")
     
      %We build two plots.
      %The first plot contains all the variables present in the amortization plan.
 
      figure;
      x=T{:,1};
      y1=T{:,2};
      y2=T{:,3};
      y3=T{:,4};
      y4=T{:,5};
      plot(x,y1,'k',x,y2,'r',x,y3,'b',x,y4,'g');
      legend('Installment','Capital paid','Interest paid','Remaining debit')
      title('Plot of the amortization plan')
      
      % The second plot contains all the variables present in the 
      % amortization plan except the "Remaining debit" variable to better 
      %appreciate the other variables that have very similar values to 
      %each other compared to those of the "Remaining debit" variable 
      %which initially has very large values.
      
      
      figure;
      x=T{:,1};
      y1=T{:,2};
      y2=T{:,3};
      y3=T{:,4};
      y4=T{:,5};
      plot(x,y1,'k',x,y2,'r',x,y3,'b');
      legend('Installment','Capital paid','Interest paid')
      title('Plot of the amortization plan without the variable Remaining debit')
      
     
     
     
 
       save = menu('Do you want to save the amortization schedule ', 'Yes','No');
     if save==1
     print = menu('In what format do you want to save the amortization schedule?','CSV','Excel(.xlsx)','both','exit');
     if print==1;
         writetable(T,'AmortizationplanCSV.csv')
     elseif print==2;
         writetable(T,'AmortizationplanExcel.xlsx')
     elseif print==3;
         writetable(T,'AmortizationplanCSV.csv')
         writetable(T,'AmortizationplanExcel.xlsx')
     end
     end
             
           

