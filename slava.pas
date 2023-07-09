program LETNYAYA_PRAKTIKA2;

const max_Strok = 100;

type vilet_samolrta = record

    fio:string;

    number:string;

    dayOfWeek:string;

    time_dep:string;

    end;

    arr = array [1..max_Strok] of vilet_samolrta;

var 
    stroka:string;

    fio:boolean;

    number:boolean;

    empty_strok:integer;

    writeLine:boolean;

    error_field:string;

    mass:arr;

    i: integer;

    n: integer;

    j:integer;

    f1:text;

    function isDigit (symbol:char):boolean;

    begin 

    if ((symbol >= '0') and (symbol <= '9')) then 

    isDigit := true

    else 

    isDigit := false;

    end;   

begin

    empty_strok:=0;

    j:=1;

    assign(f1,'Список вылетов.txt');

    reset(f1);

    error_field := '';

    for i:=1 to max_Strok do begin

        readln(f1,stroka);

        if (length(stroka) <> 0) then begin

            while stroka[j]<>' ' do

            begin

                if  (j=1) and (not(stroka[j] in ['A..Z'])) then begin

                    while stroka[j]<>' ' do

                    begin

                        error_field:=error_field+stroka[j];

                        j:=j+1;

                    end;
                        
                    writeln('Ошибка в поле ФИО в строке ', i,': ',error_field,'Первя буква фамилии должна быть заглавная');
                    error_field:='';

                end

                else 

                begin

                    if (j<>1) and (not(stroka[j] in ['a..z'])) and (fio = true)  then begin

                        error_field:=stroka[1];

                        fio:= false;
                            
                        while stroka[j]<>' ' do

                        begin

                            error_field:=error_field+stroka[j];

                            j:=j+1;

                        end;

                        writeln('Ошибка в поле ФИО в строке ', i,' ',error_field,'Все буквы кроме первой должны быть строчными');
                        error_field:='';

                    end;

                end;

                j:=j+1

            end;

            while stroka[j]<>' ' do

                begin

                    if not isDigit(stroka[j]) then 

                        number:=false;

                end;

                j:=j+1;

                error_field:=error_field+stroka[j];

            if number = false then begin

                writeln('Ошибка в поле “Номер рейса” в строке ',i,' :',error_field);

                error_field:='';

                writeLine := false;

            end;

            error_field:='';

            j:=j+1;

            if (((stroka[j]<>'M') or (stroka[j+1] <> 'o')) and ((stroka[j] <>'T') or (stroka[j+1] <>'u')) and ((stroka[j] <> 'W') or (stroka[j+1] <> 'e')) and ((stroka[j] <> 'T') or (stroka[j+1]  <>'h')) and ((stroka[j] <> 'F') or (stroka[j+1] <> 'r')) and ((stroka[j] <> 'S') or (stroka[j+1] <> 'a')) and ((stroka[j] <> 'S') or (stroka[j+1] <> 'u'))) then begin

                while stroka[j]<>' ' do

                    begin

                        error_field:=error_field+stroka[j];

                        j:=j+1;

                    end;

                writeln('Ошибка в поле “День вылета” в строке ',i,' :',error_field);

                error_field:='';

                writeLine := false;

            end;

            j:=j+1;

            if ((not isDigit(stroka[j])) or (not isDigit(stroka[j+1])) or (stroka[j+2] <> ':') or (not isDigit(stroka[j+3])) or (not isDigit(stroka[j+4])) or (stroka[j]>'2') or (stroka[j+3]>'5'))  then begin 

                while stroka[j]<>' ' do

                    begin

                        error_field:=error_field+stroka[j];

                        j:=j+1;

                    end;

                writeln('Ошибка в поле “Время вылета” в строке ',i,' :',error_field);

                error_field:='';

                writeLine := false;

            end;

            j:=1;

            if (writeLine = true) then begin 

                while stroka[j]<>' ' do

                    begin

                        mass[j].fio := mass[j].fio+stroka[j]; 

                        j := j+1;
                    
                    end;

                j:=j+1;

                while stroka[j]<>' ' do

                    begin

                        mass[j].number := mass[j].number+stroka[j]; 

                        j := j+1;

                    end;
                    
                j:=j+1;

                while stroka[j]<>' ' do

                    begin

                        mass[j].dayOfWeek := mass[j].dayOfWeek+stroka[j]; 

                        j := j+1;

                    end;
                    
                j:=j+1;

                while stroka[j]<>' ' do

                    begin

                        mass[j].time_dep := mass[j].time_dep+stroka[j]; 

                        j := j+1;

                    end;
                    
                j:=j+1;

                writeLine:=true; 

            end; 
        end;
    end;
end.
