type tNode=^elem;
elem = record
next: tNode;
stp,coef:integer;
end;

begin
	var first, second: tNode;
	var a,b,c,d,x,y,z, head, dopElem, n, p, r:tNode;
    begin
      a:=first;
      b:=second;
      new(x);
      x^.next:=nil;
      c:=x;
      c^.next:=nil;
      d:=c;
      if a<>nil then
        begin
          if b<>nil then
            begin  
              if a^.stp = b^.stp then
                begin
                  c^.coef:=(a^.coef)+(b^.coef);
                  c^.stp:=a^.stp;
                  c:=c^.next;
                end
              else
                b:=b^.next;
              end
          else
            b:=second;
          end
      else
        a:=a^.next;
        writeln();
      end;
        begin
          new(y);
          y^.next:=nil;
          head:=y;
          head^.next:=nil;
          c:=d;
          z:=head;
        while c<>nil do
          begin
            r:=c^.next;
            if (c^.stp)>(r^.stp) then
              begin
                head^.stp:=c^.stp;
                head^.coef:=c^.coef;
                head:=head^.next;
                c:=c^.next;
                r:=r^.next;
            end
            else
              if r<>nil then
                begin
                  c^.stp:=r^.stp;
                  c:=c^.next;
          end;
        end;
        begin  
          c:=d;
          head:=z;
          a:=first;
          while a<>nil do
            begin
              if head<>nil then
                begin
                  if a^.stp<>head^.stp then
                    begin  //примем first за упорядоченный список, а то я устал уже, все и так не правильно
                      p:=head;
                      dopElem:=a;
                      n:=head^.next;
                      dopElem^.next:=n;
                      p^.next:=dopElem;
                      write(head^.coef, 'x', head^.stp, '+', a^.coef, 'x', a^.stp, '+');
                      head:=head^.next;
                    end
                  else
                    write(head^.coef, 'x', head^.stp, '+');
                    head:=head^.next;
                end;
            end;
        end;
    end;    
end.

