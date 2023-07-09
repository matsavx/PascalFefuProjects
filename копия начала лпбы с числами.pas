program numbers;

const N = 300;

type num_type = record
	num: array [0..N] of byte;
	sign: boolean;
end;


arr_num = array [0..N] of num_type;

arr_charge = array [0..N] of integer;

var str,s: string;
number: num_type;
f1: text;
A: num_type;
err_num, num_count: integer;
info_num: arr_num;
error_flag_num: boolean;

procedure reading(var f: text; var x: num_type; var error_flag_num_1: boolean);
	var data: integer;
	begin
	err_num:=0;
	x.sign:=false;
		begin
			error_flag_num_1:= false;
			for var n:= 1 to length(str) do 
				begin
					inc(num_count);
					if (str[1] in ['0'..'7']) or (str[1] = '-') then
						begin
							if str[1] = '-' then
								begin
									x.sign:=true;
									delete (str, 1, 1);
								end;
							x.num[num_count]:=str[1];
						end
					else
						begin
							error_flag_num_1:=true;
							delete(str, 1, 1);
						end;

				end;
			if error_flag_num_1 = true then
				begin
					writeln('Ошибка в числе номер ', num_count, '. Недопустимый символ.');
					str:= '';
				end
			else
				begin
					val(str, data, err_num);
					x.num[num_count]:=data;
				end;
	    end;
	end;
//procedure discharge (f1: text, info_num: arr_num_count);
//	var
//	begin



begin
	num_count:= 0;
	assign (f1, 'numbers.txt');
	reset(f1);
		while not (eof (f1)) and (err_num = 0) do 
			begin
				readln(f1,str);
				reading(f1,A,error_flag_num);
				readln(f1,str);
				writeln(A.num[num_count]);
			end;
	close(f1);
end.
//Если знак неправильный или ошибка в числе, то подсчет должен закончиться. Есть фотка в телефоне.


