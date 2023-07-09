program numbers;

const max = 20;

type num_type = record
	num: array [0..max] of byte;
	sign: boolean;
end;


arr_num = array [0..max] of num_type;

arr_charge = array [0..max] of integer;

var str: string;
f1, f2: text;
A, B, C, sign: num_type;
err_num, mine: integer;
error_flag_num, zeros_flag, thats_zero_flag: boolean;

procedure reading(f: text; var x: num_type; var error_flag_num_1: boolean);//Процедура считывания
	var data: integer;
		s: string;
	begin
	s:='';
	err_num:=0;
	x.sign:=false;
	error_flag_num_1:= false;
	zeros_flag:= false; //Флаг знака для нуля (если число = 0, то знака у него не будет)

		if length(str) = 0 then
			begin
				error_flag_num_1:= true;
				writeln('Пустая строка, подсчет окончен.');
			end

		else
			begin

				if length(str) > max then
					begin
						error_flag_num_1:= true;
						writeln('Число символов больше ' , max);
					end;

				if ((str[1] = '-') or (str[1] = '+')) and (error_flag_num_1 = false) then
					begin
						if str[1] = '-' then
							begin
								x.sign:=true;
								delete (str, 1, 1);
							end
						else
							begin
								if str[1] = '+'then
									delete (str, 1, 1)
								else
									begin
										error_flag_num_1:= true;
										writeln('Ошибка. Недопустимый символ в начале строки.');
									end;
							end;
					end;
			end;


		while (length(str) > 0) and (str[1] = '0') and (error_flag_num_1 = false) do //Удаление ведущих нулей (строка 000..00 будет превращена в 0)
			begin
				delete (str, 1, 1);

				if length(str) = 0 then
					begin
						x.num[1]:= 0;
						x.num[0]:=1;
						zeros_flag:= true;
					end;
			end;

		if (length(str) > 0) and (zeros_flag = false) and (error_flag_num_1 = false) then

			begin
				x.num[0]:= length(str); //Хранение количества разрядов в нулевом элементе массива
				for var n:= length(str) downto 1 do 
					begin
						if (str[1] in ['0'..'7']) then
							begin
								s:=str[1];
								val(s, data, err_num);
								x.num[n]:=data;
								delete(str, 1, 1); 	
							end
						else
							begin
								error_flag_num_1:=true;
								delete(str, 1, 1);
							end;
					end;
			end;

		if error_flag_num_1 = true then
			begin
				writeln('Ошибка в числе');
				str:= '';

			end;
	end;


function Less (x: num_type; y: num_type): boolean;// Функция сравенения. x - это А, y - это В| TRUE если А >= B | FALSE, если B > A
	var flag: boolean;
	begin
		mine:=0;
		flag:= true;
		thats_zero_flag:= false;

		if x = y then
				thats_zero_flag:= true;

		if x.num[0] = y.num[0] then
			begin
				mine:=x.num[0];	
				for var j:= x.num[0] downto 1 do
					begin
						if (flag = true) then
							begin
								if x.num[j] > y.num[j] then
									begin
										flag:=false;
										Less:=true;
									end;
								if y.num[j] > x.num[j] then
									begin
										flag:=false;
										Less:=false; 
									end;
								if x.num[j] = y.num[j] then
									Less:=true;
							end;
					end;
			end
		else
			begin
				if x.num[0] > y.num[0] then
					begin
						Less:=true;
						mine:=x.num[0];
					end
				else
					begin
						Less:=false;
						mine:=y.num[0];
					end;
			end;
	end;

procedure write_num(f:text; x: num_type); //Процедура вывода
	begin
		if (x.sign = true) and (zeros_flag = false) and (thats_zero_flag = false) and (x.num[1] <> 0) then
			write(f, '-');
		for var m:= x.num[0] downto 1 do
			write(f, x.num[m]);
	end;
{----------------------------------------------------------------------------------}

function SumTest1 ( x:num_type; y: num_type): boolean; 
	begin
		if (A.sign = false) and (B.sign = false) then
			SumTest1:=true;
	end;

function SumTest2 ( x:num_type; y: num_type): boolean;
	begin
		if (A.sign = true) and (B.sign = false) then
			SumTest2:=true;
	end;

function SumTest3 ( x:num_type; y: num_type): boolean;
	begin
		if (A.sign = false) and (B.sign = true) then
			SumTest3:=true;
	end;

function SumTest4 ( x:num_type; y: num_type): boolean;
	begin
		if (A.sign = true) and (B.sign = true) then
			SumTest4:=true;
	end;

{----------------------------------------------------------------------}

function SubTest1 ( x:num_type; y: num_type): boolean;
	begin
		if (A.sign = false) and (B.sign = false) then
			SubTest1:=true;
	end;

function SubTest2 ( x:num_type; y: num_type): boolean;
	begin
		if (A.sign = true) and (B.sign = false) then
			SubTest2:=true;
	end;

function SubTest3 ( x:num_type; y: num_type): boolean;
	begin
		if (A.sign = false) and (B.sign = true) then
			SubTest3:=true;
	end;

function SubTest4 ( x:num_type; y: num_type): boolean;
	begin
		if (A.sign = true) and (B.sign = true) then
			SubTest4:=true;
	end;

{----------------------------------------------------------------------}

procedure Sum ( A1: num_type;  B1: num_type; var C1: num_type);//Процедура суммы.
	var carryover, action: integer; // наибольшее количество разрядов, число переноса, число записи данной.
	perenos:boolean;
	begin
	carryover:=0;
	action:=0;

		for var i:= 1 to mine do
			begin
				if (A1.num[i] + B1.num[i] + carryover) < 8 then
					begin
						C1.num[i]:= A1.num[i] + B1.num[i] + carryover;
						carryover:= A1.num[i] div 8;
					end
				else
					begin
						action:= A1.num[i] + B1.num[i] + carryover;
						C1.num[i]:= action mod 8;
						carryover:= action div 8;
						if i = mine then //Если это первый разряд и разрядов станет больше, то добавляется новый разряд
							begin
								if C1.num[0] < max then
									begin
										C1.num[mine+1]:=carryover;
										inc(mine);
									end
								else
									begin
										C1.num[0]:=1;
										C1.num[1]:= ((A1.num[1] + B1.num[1]) mod 8);
										writeln('Произошел перенос младшего разряда.');
										perenos:=true;
									end;
							end;
					end;
			end;
		if perenos = false then
		C1.num[0]:=mine;
	end;

procedure Sub ( A1: num_type;  B1: num_type; var C1: num_type); //Процедура вычитания
	var bool: boolean;
	begin
		bool:= false; //флаг занятия

		for var i:= 1 to mine do
			begin
				if bool = false then
					begin

						if (A1.num[i] >= B1.num[i]) then
							C1.num[i]:= A1.num[i] - B1.num[i];

						if (A1.num[i] < B1.num[i]) then
							begin
								C1.num[i]:= (A1.num[i] + 8) - B1.num[i];
								bool:= true;
							end;
					end

				else
					begin

						if ((A1.num[i] - 1) = 0) and (B1.num[i] = 0) then
							begin
								C1.num[i]:= 0;
								bool:= false;
							end;

						if ((A1.num[i] - 1) >= B1.num[i]) and ((A1.num[i] - 1) <> 0) and (B1.num[i] <> 0) then
							begin
								C1.num[i]:= A1.num[i] - B1.num[i] - 1;
								bool:= false;
							end;

						if ((A1.num[i] - 1) >= B1.num[i]) and ((A1.num[i] - 1) <> 0) and (B1.num[i] = 0) then
							begin
								C1.num[i]:= A1.num[i] - 1;
								bool:= false;
							end;
						
						if ((A1.num[i] - 1) < B1.num[i]) and (A1.num[i] <> 0) then
							C1.num[i]:= (A1.num[i] + 7) - B1.num[i];

						if (A1.num[i] = 0) then
							C1.num[i]:= (A1.num[i] + 7) - B1.num[i];


					end;

			end;
		while C1.num[mine] = 0 do
			dec(mine);
		if mine = 0 then
			inc(mine);
		C1.num[0]:=mine;

	end;

{------------------------------------------------------------------------}

procedure Summation (A1:num_type; B1:num_type; var C1: num_type);
	begin
		if SumTest1(A1,B1) then
			begin
				if Less(A1,B1) then
					Sum(A1,B1,C1)
				else
					Sum(B1,A1,C1);
			end;

		if SumTest2(A1,B1) then
			begin
				if Less(A1,B1) = false then
					begin
						Sub(B1,A1,C1);
						C1.sign:=false;
					end
				else
					begin
						Sub(A1,B1,C1);
						C1.sign:= true;
					end;
			end;

		if SumTest3(A1,B1) then
			begin
				if Less (A1,B1) then
					begin
						Sub(A1,B1,C1);
						C1.sign:=false;
					end
				else
					begin
						Sub(B1,A1,C1);
						C1.sign:=true;
					end;
			end;


		if SumTest4(A1,B1) then
			begin
				if Less(A1,B1) then
					Sum(A1,B1,C1)
				else
					Sum(B1,A1,C1);
				C1.sign:= true;
			end;
	end;


procedure Substruction (A1:num_type; B1:num_type; var C1: num_type);
	begin
		if SubTest1(A1,B1) then
			begin
				if Less(A1,B1) = true then
					begin
						Sub(A1,B1,C1);
						C1.sign:=false;
					end
				else
					begin
						Sub(B1,A1,C1);
						C1.sign:=true;
					end;
			end;

		if SubTest2(A1,B1) then
			begin
				if Less(A1,B1) then
					Sum(A1,B1,C1)
				else
					Sum(B1,A1,C1);
				C1.sign:= true;
			end;
			
		if SubTest3(A1,B1) then
			begin
				if Less(A1,B1) then
					Sum(A1,B1,C1)
				else
					Sum(B1,A1,C1);
			end;

		if SubTest4(A1,B1) then
			begin
				if Less(A1,B1) = true then
					begin
						Sub(A1,B1,C1);
						C1.sign:=true;
					end
				else
					begin
						Sub(B1,A1,C1);
						C1.sign:=false;
					end;
			end;
	end;

//две функции поиска линейный и линейный с барьером,у каждого три параметра вектор,длина и ключ поиска, найти заданный элемент в каждой диагонали, размерность m*m

begin
	assign (f1, 'numbers.txt');
	reset(f1);
	readln(f1,str);
			
	reading(f1, A, error_flag_num);

	while (not eof(f1)) and (error_flag_num = false) do
		begin
			C.num[0]:=A.num[0];
			readln(f1,str);
			reading(f1,sign, error_flag_num);
			if error_flag_num = false then
				begin
					readln(f1,str);
					reading(f1,B,error_flag_num);
				end;

			if sign.sign = true then
				Substruction(A,B,C)
			else
				Summation(A,B,C);

			A:=C;
			for var p:= 1 to B.num[0] do B.num[p]:=0;
			A.sign:=C.sign;
			
		end;

	assign (f2, 'numbers.ANSWER.txt');
	rewrite(f2);
	write_num(f2,C);
	close(f2);
	close(f1);
end.
//происходит фигня, если в строке больше 256 символов


