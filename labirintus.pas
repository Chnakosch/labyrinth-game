program labirintus;
uses crt;
var
	tilestate : Array[1..79,1..25] of integer; // 0 - nothing || 1 - clear || 2 - wall
	exitpointX : integer;
	exitpointY : integer;
	playerX : integer;
	playerY : integer;
	
	input : char;
	i : integer;
	j : integer;
	ways : integer;
	randomnum : integer;
	i2 : integer;
	debuglogic : boolean;
	
procedure maketile(x : integer; y : integer);
var
	clearways : Array[1..4] of integer; // 1 - up || 2 - right || 3 - down || 4 - left
	k, l : integer;
	logic : boolean;
	randomnum2 : integer;
	randomnum3 : integer;
begin
	debuglogic:=false;
	if tilestate[x,y]=1 then
	begin
		debuglogic:=true;
		for k:=1 to 4 do
		begin
			clearways[k]:=0;
		end;
		
		k:=1;
		if tilestate[x,y-1]=0 then
		begin
			clearways[k]:=1;
			Inc(k);
		end;
		if tilestate[x+1,y]=0 then
		begin
			clearways[k]:=2;
			Inc(k);
		end;
		if tilestate[x,y+1]=0 then
		begin
			clearways[k]:=3;
			Inc(k);
		end;
		if tilestate[x-1,y]=0 then
		begin
			clearways[k]:=4;
		end;
		
		if clearways[1]<>0 then
		begin
		
			if clearways[2]=0 then  //egy irányba lehet csak menni
			begin
				if ways=1 then
				begin
					case clearways[1] of
						1 : tilestate[x,y-1]:=1;
						2 : tilestate[x+1,y]:=1;
						3 : tilestate[x,y+1]:=1;
						4 : tilestate[x-1,y]:=1;
					end;
				end
				else
				begin
					randomnum:=random(7);
					if randomnum=2 then
					begin
						case clearways[1] of
							1 : tilestate[x,y-1]:=2;
							2 : tilestate[x+1,y]:=2;
							3 : tilestate[x,y+1]:=2;
							4 : tilestate[x-1,y]:=2;
						end;
						Dec(ways);
					end
					else
					begin
						case clearways[1] of
							1 : tilestate[x,y-1]:=1;
							2 : tilestate[x+1,y]:=1;
							3 : tilestate[x,y+1]:=1;
							4 : tilestate[x-1,y]:=1;
						end;
					end;
				end;
			end;
		
			if (clearways[3]=0) AND (clearways[2]<>0) then //két irányba lehet menni
			begin
				randomnum:=random(3);
				logic:=false;
				case randomnum of
					0 :	begin
							case clearways[1] of
								1 : tilestate[x,y-1]:=1;
								2 : tilestate[x+1,y]:=1;
								3 : tilestate[x,y+1]:=1;
								4 : tilestate[x-1,y]:=1;
							end;
							case clearways[2] of
								1 : tilestate[x,y-1]:=1;
								2 : tilestate[x+1,y]:=1;
								3 : tilestate[x,y+1]:=1;
								4 : tilestate[x-1,y]:=1;
							end;
							logic:=true;
						end;
					1 :	begin
							case clearways[1] of
								1 : tilestate[x,y-1]:=2;
								2 : tilestate[x+1,y]:=2;
								3 : tilestate[x,y+1]:=2;
								4 : tilestate[x-1,y]:=2;
							end;
							case clearways[2] of
								1 : tilestate[x,y-1]:=1;
								2 : tilestate[x+1,y]:=1;
								3 : tilestate[x,y+1]:=1;
								4 : tilestate[x-1,y]:=1;
							end;
						end;
					2 :	begin
							case clearways[1] of
								1 : tilestate[x,y-1]:=1;
								2 : tilestate[x+1,y]:=1;
								3 : tilestate[x,y+1]:=1;
								4 : tilestate[x-1,y]:=1;
							end;
							case clearways[2] of
								1 : tilestate[x,y-1]:=2;
								2 : tilestate[x+1,y]:=2;
								3 : tilestate[x,y+1]:=2;
								4 : tilestate[x-1,y]:=2;
							end;
						end;
				end;
				if ways>1 then
				begin
					randomnum:=random(7);
					if randomnum=3 then
					begin
						logic:=false;
						case clearways[1] of
							1 : tilestate[x,y-1]:=2;
							2 : tilestate[x+1,y]:=2;
							3 : tilestate[x,y+1]:=2;
							4 : tilestate[x-1,y]:=2;
						end;
						case clearways[2] of
							1 : tilestate[x,y-1]:=2;
							2 : tilestate[x+1,y]:=2;
							3 : tilestate[x,y+1]:=2;
							4 : tilestate[x-1,y]:=2;
						end;
						Dec(ways);
					end;
				end;
				if logic then Inc(ways);
			end;
		
			if clearways[3]<>0 then //három irányba lehet menni
			begin
				l:=0;
				randomnum:=random(4);
				if randomnum=3 then
				begin
					case clearways[1] of
						1 : tilestate[x,y-1]:=1;
						2 : tilestate[x+1,y]:=1;
						3 : tilestate[x,y+1]:=1;
						4 : tilestate[x-1,y]:=1;
					end;
					case clearways[2] of
						1 : tilestate[x,y-1]:=1;
						2 : tilestate[x+1,y]:=1;
						3 : tilestate[x,y+1]:=1;
						4 : tilestate[x-1,y]:=1;
					end;
					case clearways[3] of
						1 : tilestate[x,y-1]:=1;
						2 : tilestate[x+1,y]:=1;
						3 : tilestate[x,y+1]:=1;
						4 : tilestate[x-1,y]:=1;
					end;
					Inc(l,2);
				end
				else
				begin
					randomnum2:=random(2);
					if randomnum2=1 then
					begin
						randomnum3:=random(3)+1;

						case clearways[randomnum3] of
							1 : tilestate[x,y-1]:=2;
							2 : tilestate[x+1,y]:=2;
							3 : tilestate[x,y+1]:=2;
							4 : tilestate[x-1,y]:=2;
						end;
						
						if randomnum3<>1 then
						begin
							case clearways[1] of
								1 : tilestate[x,y-1]:=1;
								2 : tilestate[x+1,y]:=1;
								3 : tilestate[x,y+1]:=1;
								4 : tilestate[x-1,y]:=1;
							end;
						end;
						
						if randomnum3<>2 then
						begin
							case clearways[2] of
								1 : tilestate[x,y-1]:=1;
								2 : tilestate[x+1,y]:=1;
								3 : tilestate[x,y+1]:=1;
								4 : tilestate[x-1,y]:=1;
							end;
						end;
						
						if randomnum3<>3 then
						begin
							case clearways[3] of
								1 : tilestate[x,y-1]:=1;
								2 : tilestate[x+1,y]:=1;
								3 : tilestate[x,y+1]:=1;
								4 : tilestate[x-1,y]:=1;
							end;
						end;
						Inc(l);
					end
					else
					begin
						randomnum3:=random(3)+1;

						case clearways[randomnum3] of
							1 : tilestate[x,y-1]:=1;
							2 : tilestate[x+1,y]:=1;
							3 : tilestate[x,y+1]:=1;
							4 : tilestate[x-1,y]:=1;
						end;
						
						if randomnum3<>1 then
						begin
							case clearways[1] of
								1 : tilestate[x,y-1]:=2;
								2 : tilestate[x+1,y]:=2;
								3 : tilestate[x,y+1]:=2;
								4 : tilestate[x-1,y]:=2;
							end;
						end;
						
						if randomnum3<>2 then
						begin
							case clearways[2] of
								1 : tilestate[x,y-1]:=2;
								2 : tilestate[x+1,y]:=2;
								3 : tilestate[x,y+1]:=2;
								4 : tilestate[x-1,y]:=2;
							end;
						end;
						
						if randomnum3<>3 then
						begin
							case clearways[3] of
								1 : tilestate[x,y-1]:=2;
								2 : tilestate[x+1,y]:=2;
								3 : tilestate[x,y+1]:=2;
								4 : tilestate[x-1,y]:=2;
							end;
						end;
					end;
				end;
				
				if ways>1 then
				begin
					randomnum:=random(7);
					if randomnum=3 then
					begin
						case clearways[1] of
							1 : tilestate[x,y-1]:=2;
							2 : tilestate[x+1,y]:=2;
							3 : tilestate[x,y+1]:=2;
							4 : tilestate[x-1,y]:=2;
						end;
						case clearways[2] of
							1 : tilestate[x,y-1]:=2;
							2 : tilestate[x+1,y]:=2;
							3 : tilestate[x,y+1]:=2;
							4 : tilestate[x-1,y]:=2;
						end;
						case clearways[3] of
							1 : tilestate[x,y-1]:=2;
							2 : tilestate[x+1,y]:=2;
							3 : tilestate[x,y+1]:=2;
							4 : tilestate[x-1,y]:=2;
						end;
						l:=0;
					end;
				end;
				Inc(ways,l);
			end;
		end;	
	end;
end;
	
procedure drawout();
var
	k, l : integer;
begin
	ClrScr;
	for k:=(playerX-3) to (playerX+3) do
	begin
		for l:=(playerY-3) to (playerY+3) do
		begin
			if (k>0) AND (l>0) AND (k<80) AND (l<26) then
			begin
				Gotoxy(k,l);
				if tilestate[k,l]=2 then
				begin
					Textbackground(white);
					Write(' ');
				end;
			end;
		end;
	end;
	Textbackground(black);
	Gotoxy(exitpointX,exitpointY);
	Write('X');
	Gotoxy(playerX,playerY);
	Write('@');
	Gotoxy(80,25);
end;
	
BEGIN
	Randomize;
	repeat
		for i:=1 to 79 do
		begin
			for j:=1 to 25 do
			begin
				tilestate[i,j]:=0;
			end;
		end;
		for i:=1 to 79 do
		begin
			tilestate[i,1]:=2;
			tilestate[i,25]:=2;
		end;
		for i:=1 to 25 do
		begin
			tilestate[1,i]:=2;
			tilestate[79,i]:=2;
		end;
		tilestate[2,2]:=1;
		randomnum:=random(3);
		case randomnum of
			0 :	begin
					tilestate[3,2]:=1;
					tilestate[2,3]:=2;
					ways:=1;
				end;
			1 :	begin
					tilestate[3,2]:=2;
					tilestate[2,3]:=1;
					ways:=1;
				end;
			2 :	begin
					tilestate[3,2]:=1;
					tilestate[2,3]:=1;
					ways:=2;
				end;
		end;
			debuglogic:=false;
			for i2:=1 to 100 do
			begin
				for i:=2 to 78 do
				begin
					for j:=2 to 24 do
					begin
						//if debuglogic then ReadLn;
						maketile(i,j);
						//if debuglogic then drawout();
					end;
				end;
			end;
	until (tilestate[60,15]<>0) OR (tilestate[30,23]<>0) OR (tilestate[50,20]<>0);
	exitpointX:=0;
	for i:=78 downto 2 do
	begin
		for j:=24 downto 2 do
		begin
			if (tilestate[i,j]=1) AND (exitpointX=0) then
			begin
				exitpointX:=i;
				exitpointY:=j;
			end;
		end;
	end;
	
	playerX:=2;
	playerY:=2;
	drawout();
	repeat
		input:=readkey;
		case input of
			#72	:	begin //fel
						if tilestate[playerX,playerY-1]=1 then 
						begin
							Gotoxy(playerX-3,playerY+3);
							dec(playerY);
						end;
					end;
			#75 :	begin //balra
						if tilestate[playerX-1,playerY]=1 then 
						begin
							dec(playerX);
						end;
					end;
			#77	:	begin //jobbra
						if tilestate[playerX+1,playerY]=1 then 
						begin
							inc(playerX);					
						end;
					end;
			#80 :	begin //le
						if tilestate[playerX,playerY+1]=1 then 
						begin
							Inc(playerY);
						end;
					end;
		end;
		Gotoxy(playerX,playerY);
		drawout();
	until (input=#27) OR ((playerX=exitpointX) AND (playerY=exitpointY));
	if (playerX=exitpointX) AND (playerY=exitpointY) then
	begin
		ClrScr;
		WriteLn('Nyertel!');
		ReadLn;
	end;
END.


