const
  N = 100;
  posible_points = 100;
  posible_summ = 320;
  posible_gender: set of char = ['м', 'ж', 'М', 'Ж'];
  posible_name: set of char = ['а'..'я', 'А'..'Я'];
  posible_date: set of char = ['0'..'9'];
  max_valid_students = 100;
  max_valid_groups = 10;
  max_students_in_group = 20;

type
  info_student = record 
    name: String;
    gender: string;
    points: byte;
  end;
  
  arr = array [1..N] of info_student;

  arr_students = array [1..max_valid_students] of info_student;

  info_group = record
      number: Word;
      points: Word;
      amount: Byte;
      students: array [1..max_students_in_group] of info_student;
    end;

  arr_groups = array [1..max_valid_groups] of info_group;
var
  
  f1,f2: text;
  str_in: String;
  info: arr;
  students: arr_students;
  groups: arr_groups;
  string_number_first, valid, group_number, points_in_groups, count: Integer;
  valid_name_error, valid_gender_error, valid_date_error, valid_points_error, valid_group_number_err, valid_points_in_groups_err: Boolean;

// парсинг файла и вписывание первых 100 валидных записей в массив
procedure parsing_file(var str: string; const string_number: Integer);
var
  slash, points, space, summ, i, m: Integer;
  name: String;
  gender: String;
  day, mounth, year: Integer;
  err_day, err_mounth, err_year: Integer;
begin
  if FileExists('first.txt') then
  begin
  name := '';
  gender := '';
  space := 0;
  m := 0;
  
  valid_name_error := false;
  valid_gender_error := false;
  valid_date_error := false;
  valid_points_error := false;
  
  for var z := 1 to length(str) do
  begin
    if str[z] = ' ' then
      m := m + 1;
  end;
  
  if m <> 6 then 
    writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (Неверное количество полей или пробелов между ними. Полей должно быть 7)')
    else
  begin
    if str[1] in ['А'..'Я'] then 
    begin
      name := name + str[1];
      delete(str, 1, 1);
    end
    else
    begin
      writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "ФИО")');
      delete(str, 1, 1);
      valid_name_error := true;
    end;
    
    while space <> 3 do
    begin
      if str[1] in ['а'..'я'] then
      begin
        if str[2] = ' ' then
        begin
          space := space + 1;
        end;
        
        name := name + str[1];
        delete(str, 1, 1);
      end
      else
      begin
        if str[1] = ' ' then
        begin
          if str[2] in ['А'..'Я'] then 
          begin
            name := name + str[1] + str[2];
            delete(str, 1, 2);
          end
              else
          begin
            writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "ФИО")');
            delete(str, 1, 1);  
            valid_name_error := true; 
          end;  
        end
          else
        begin
          writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "ФИО")');
          delete(str, 1, 1);
          valid_name_error := true;
        end;
      end;  
    end;
    
    delete(str, 1, 1);
    
    if str[2] = ' ' then
    begin
      if str[1] in posible_gender then
        gender := gender + str[1]
        else 
      begin
        writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (Ошибка в поле "Пол". Это поле должно содержать одну букву, отражающую пол абитуриента. Это может быть строчная или заглавная буква "М" или буква "Ж".)');
        valid_gender_error := true;
      end;
      
      delete(str, 1, 1);
    end
    else
    begin
      writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (Ошибка в поле "Пол". Это поле должно содержать одну букву, отражающую пол абитуриента. Это может быть строчная или заглавная буква "М" или буква "Ж".)');
      delete(str, 1, pos(' ', str));
      valid_gender_error := true;
    end;
    
    delete(str, 1, 1);
    
    i := 1;
    
    while str[i] <> ' ' do
    begin
      if str[i] = '/' then
        slash := slash + 1;
      i := i + 1;
    end;
    
    if slash = 2 then
    begin
      val(copy(str, 1, pos('/', str) - 1), day, err_day);
      delete(str, 1, pos('/', str));
      if (err_day > 1) then
      begin
        writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
        valid_date_error := true;
      end;
      
      val(copy(str, 1, pos('/', str) - 1), mounth, err_mounth);
      delete(str, 1, pos('/', str));
      if (err_mounth > 1) then
      begin
        writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
        valid_date_error := true;
      end;
      
      val(copy(str, 1, pos(' ', str) - 1), year, err_year);
      delete(str, 1, pos(' ', str));
      if (err_year > 1) then
      begin
        writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения")');
        valid_date_error := true;
      end;

      
      if (year < 1990) or (year > 2019) then
      begin
        writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения". Год должен лежать в диапазоне от 1990 до 2019.)');
        valid_date_error := true;
      end;
      
      case mounth of
        1, 3, 5, 7, 8, 10, 12: 
          if (day < 1) or (day > 31) then
          begin
            writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения". Число дня не соответствует количеству календарных дней в данном месяце.)');
            valid_date_error := true;
          end;
        4, 6, 9, 11: 
          if (day < 1) or (day > 30) then
          begin
            writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения". Число дня не соответствует количеству календарных дней в данном месяце.)');
            valid_date_error := true;
          end;
        2: 
          if (day < 1) or ((day > 28) and (not(year mod 4 = 0))) then
          begin
            writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения". Число дня не соответствует количеству календарных дней в данном месяце.)');
            valid_date_error := true;
          end;
      else
        begin
          writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (ошибка в поле "Дата рождения". Месяц должен лежать в диапазоне от 1 до 12.)');
          valid_date_error := true;
        end;
      
      end;
    end
      else
    begin
      writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (Ошибка в поле "Дата Рождения". Недопустимый знак между числами. Поле должно содержать два знака "/" и иметь вид дд/мм/гггг.)');
      delete(str, 1, pos(' ', str));
      valid_date_error := true;
    end;
    
    while str[1] = ' ' do
      delete(str, 1, 1);
    
    points := StrToInt(copy(str, 1, pos(' ', str) - 1));
    
    if (points > posible_points) or (points < 22) then
    begin
      writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (Ошибка в поле "Балл по профилирующему предмету". Это поле должно содержать только цифры, лежащие в диапазоне [22..100])');
      valid_points_error := true;
    end;
    
    while str[1] <> ' ' do
      delete(str, 1, 1);
    
    while str[1] = ' ' do
      delete(str, 1, 1);
    
    
    
    if pos(' ', str) = 0 then
      summ := StrToInt(copy(str, 1, Length(str)))
    else
      summ := StrToInt(copy(str, 1, pos(' ', str) - 1));
    
    if (summ > posible_summ) or (summ < 85) then
    begin
      writeln('Ошибка в файле "first.txt" в строке ', string_number_first, ' (Ошибка в поле "Сумма балов". Это поле должно содержать только цифры, лежащие в диапазоне [85..320]")');
      valid_points_error := true;
    end;
    
    if (not valid_name_error) and (not valid_gender_error) and (not valid_date_error) and (not valid_points_error) then
    begin
      valid := valid + 1;
      info[valid].name := name;
      info[valid].gender := gender;
      info[valid].points := points;
    end;
  end;
  end
  else writeln('Файл пуст');
end;

procedure groups_count(var count: integer);
  begin
  count:=0;
  while not eof(f2) do
    begin
     readln(f2); // сами числа
     inc(count);
    end;
  end;


procedure groups_bugging(var str_in: string; var group_number, points_in_groups: integer);
  begin
    valid_group_number_err:= false;
    valid_points_in_groups_err:= false;
      begin
        group_number := StrToInt(copy(str_in, 1, pos(' ', str_in) - 1));

        if (group_number < 0) or (group_number > 9999) then
          begin
            writeln('Ошибка в файле "second". (Номер группы может содержать только целые числа от 1 до 9999).');
            valid_group_number_err:= true;
          end;
        delete(str_in, 1, pos(' ', str_in));
      end;

      begin
        if pos(' ', str_in) = 0 then
          points_in_groups:= StrToInt(copy(str_in, 1, Length(str_in)))
        else
          points_in_groups := StrToInt(copy(str_in, 1, pos(' ', str_in) - 1));
      end;

      if (points_in_groups > posible_points) or (points_in_groups < 22) then
        begin
          writeln('Ошибка в файле "second". (Минимальный средний балл по профилирующему предмету может содержать только целое число от 22 до 100)');
          valid_points_in_groups_err:=true;
        end;
      
    if (not valid_group_number_err) and (not valid_points_in_groups_err) then
      begin
        groups[count].number:= group_number;
        groups[count].points:= points_in_groups;
      end;

  end;


procedure deleteStudent(number: byte; var students: arr_students);
  begin
    students[number].name:= '';
    students[number].points:= 0;
  end;


function FindMin(i: integer; var groups: arr_groups):Integer;
    begin
      result:= i;
      for var j:= i downto 2 do
        if groups[j - 1].amount < groups[result].amount then
          result:= j - 1;
    end;

procedure distribution(var students: arr_students; var groups: arr_groups);
  var
      success: Boolean;
      j: Byte;
    begin
      for var i:= 1 to valid do
        begin
              j:= 1;
              success:= false;
              while (j < count) and (success = false) do
                begin
                  if (students[i].points < groups[j + 1].points) then
                    begin
                      if (students[i].points >= groups[j].points) then
                        begin
                          groups[FindMin(j, groups)].students[groups[FindMin(j, groups)].amount + 1]:= students[i];
                          groups[FindMin(j, groups)].amount:= groups[FindMin(j, groups)].amount + 1;
                          deleteStudent(i, students);
                          success:= true;
                        end;
                    end
                  else
                    if ((j + 1) = count) then
                      begin
                        groups[FindMin(j + 1, groups) ].students[groups[FindMin(j + 1, groups) ].amount + 1]:= students[i];
                        groups[FindMin(j + 1, groups)].amount:= groups[FindMin(j + 1, groups) ].amount + 1;
                        deleteStudent(i, students);
                        success:= true;
                      end;
                  j:= j + 1;
                end;
            end;
    end;

procedure CreateFile;
    var
      availability: Boolean;
    begin
      
      for var i:= 1 to count do
        begin
          groups[i].amount:= 0;
        end;

      distribution(students,groups);

      for var i:= 1 to count do
        begin
          assign(f2, groups[i].number + '.txt');
          rewrite(f2);
          for var j:= 1 to groups[i].amount do
            println(f2, groups[i].students[j].name);
          close(f2);
        end;

      for var i:= 1 to valid do 
        if students[i].name <> '' then
          availability:= true;

      if availability then
        begin
          println('Список нераспределенных студентов: ');
          for var i:=1 to valid do
            if students[i].name <> '' then
              println(students[i].name, students[i].points);
        end
      else
        writeln('Все студенты распределены!');

    end;


begin
  valid := 0;
  string_number_first := 0;
  
  assign(f1, 'first.txt');
  reset(f1);
  
  while (not eof(f1)) and (valid <> 1000) do
  begin
    string_number_first := string_number_first + 1;
    readln(f1, str_in);
    parsing_file(str_in, string_number_first);
  end;
  
  println();
  println('Кол-во валидных строк: ', valid);
  
  for var k := 1 to valid do
    println(info[k].name, info[k].gender, info[k].points);
  
  assign (f2, 'second.txt');
  reset(f2);
  groups_count(count);
  close(f2);
  reset(f2);  
  while not eof(f2) do
    begin
      readln(f2, str_in);
      groups_bugging(str_in, group_number, points_in_groups);
    end;
  close(f2);
  CreateFile();
end.