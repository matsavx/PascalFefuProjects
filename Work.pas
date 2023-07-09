const
	N = 100;
	posible_ball = 100;
	posible_summ = 320;
	posible_sex: set of char = ['м', 'ж', 'М', 'Ж'];
	posible_name: set of char = ['а'..'я', 'А'..'Я'];
	posible_date: set of char = ['0'..'9'];

type
	i = record
		name : String;
		sex : string;
		summ : Integer;
	end;

	arr = array [1..N] of i;
var 

	file_inpute_first, file_inpute_second: text;
	file_output: text;
	str_in, str_out: String;
	info: arr;
	string_number_first, string_number_second: Integer;
	valid: Integer;
	valid_name_error, valid_sex_error, valid_date_error, valid_ball_error: Boolean;

// парсинг файла и вписывание первых 100 валидных записей в массив
procedure parsing_file (var str:string; const string_number: Integer);
	var
		slash: Integer;
		ball: Integer;
		space: Integer;
		name: String;
		sex: String;
		day, mounth, year: Integer;
		summ: Integer;
		i: Integer;
		err_day, err_mounth, err_year: Integer;
	begin
		name:= '';
		sex:= '';
		space:= 0;

		valid_name_error:= false;
		valid_sex_error:= false;
		valid_date_error:= false;
		valid_ball_error:= false;

		if str[1] in ['А'..'Я'] then 
			begin
				name:= name + str[1];
				delete(str, 1, 1);
			end
		else
			begin
				writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "ФИО")');
				delete(str, 1, 1);
				valid_name_error:= true;
			end;

		while space <> 3 do
			begin
				if str[1] in ['а'..'я'] then
					begin
						if str[2] = ' ' then
							begin
								space:= space + 1;
							end;

						name:= name + str[1];
						delete(str, 1, 1);
					end
				else
					begin
						if str[1] = ' ' then
							begin
								if str[2] <> ' ' then
									begin
										if str[2] in ['А'..'Я'] then 
											begin
												name:= name + str[1] + str[2];
												delete(str, 1, 2);
											end
										else
											begin
												writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "ФИО")');
												delete(str, 1, 1);	
												valid_name_error:= true;	
											end;	
									end
								else
									delete(str, 1, 1);
							end
						else
							begin
								writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "ФИО")');
								delete(str, 1, 1);
								valid_name_error:= true;
							end;
					end;

			end;
		
		while str[1] = ' ' do
			delete(str, 1, 1);

		if str[2] = ' ' then
			begin
				if str[1] in posible_sex then
					sex:= sex + str[1]
				else 
					begin
						writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Пол")');
						valid_sex_error:= true;
					end;

				delete(str, 1, 1);
			end
		else
			begin
				writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Пол")');
				delete(str, 1, pos(' ', str));
				valid_sex_error:= true;
			end;

		while str[1] = ' ' do
			delete(str, 1, 1);

		i:= 1;
		
		while str[i] <> ' ' do
			begin
				if str[i] = '/' then
				slash:= slash + 1;
				i:= i + 1;
			end;

		if slash = 2 then
			begin
				val(copy(str, 1, pos('/', str) - 1), day, err_day);
				delete(str, 1, pos('/', str));
				if (err_day > 1) then
					begin
						writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
						valid_date_error:= true;
					end;

				val(copy(str, 1, pos('/', str) - 1), mounth, err_mounth);
				delete(str, 1, pos('/', str));
				if (err_mounth > 1) then
					begin
						writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
						valid_date_error:= true;
					end;

				val(copy(str, 1, pos(' ', str) - 1), year, err_year);
				delete(str, 1, pos(' ', str));
				if (err_year> 1) then
					begin
						writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
						valid_date_error:= true;
					end;

				if (year < 1990) or (year > 2019) then
					begin
						writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
						valid_date_error:= true;
					end;

				case mounth of
					1, 3, 5, 7, 8, 10, 12 : if (day < 0) or (day > 31) then
											begin
												writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
												valid_date_error:= true;
											end;
					4, 6, 9, 11 : if (day < 0) or (day > 30) then
									begin
										writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
										valid_date_error:= true;
									end;
					2: if (day < 0) or (day > 28) then
						begin
							writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
							valid_date_error:= true;
						end;
					else
						begin
							writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
							valid_date_error:= true;
						end;
						
			end;
			end
			else
				begin
					writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
					delete(str, 1, pos(' ', str));
					valid_date_error:= true;
				end;

		while str[1] = ' ' do
			delete(str, 1, 1);

		ball:= StrToInt(copy(str, 1, pos(' ', str) - 1));

		if (ball > posible_ball) or (ball < 20) then
			begin
				writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Балл")');
				valid_ball_error:= true;
			end;

		while str[1] <> ' ' do
			delete(str, 1, 1);

		while str[1] = ' ' do
			delete(str, 1, 1);



	if pos(' ', str) = 0 then
		summ:= StrToInt(copy(str, 1, Length(str)))
	else
		summ:= StrToInt(copy(str, 1, pos(' ', str) - 1));

	if (summ > posible_summ) or (summ < 100 ) then
		begin
			writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Сумма баллов")');
			valid_ball_error:= true;
		end;

	if (not valid_name_error) and (not valid_sex_error) and (not valid_date_error) and (not valid_ball_error) then
		begin
			valid:= valid + 1;
			info[valid].name:= name;
			info[valid].sex:= sex;
			info[valid].summ:= summ;
		end;
end;

begin
	valid:= 0;
	string_number_first:= 0;

	assign(file_inpute_first, 'first.txt');
	reset(file_inpute_first);

	while (not eof(file_inpute_first)) and (valid <> 1000) do
		begin
			string_number_first:= string_number_first + 1;
			readln(file_inpute_first, str_in);
			parsing_file(str_in, string_number_first);
		end;

	println();
	println('Кол-во валидных строк: ', valid);

	for var k:= 1 to valid do
		println(info[k].name, info[k].sex, info[k].summ);
end.