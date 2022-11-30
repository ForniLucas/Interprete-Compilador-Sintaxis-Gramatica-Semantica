unit Automatas;

interface

uses Tipos,TABLA1,crt;

Function EsNumero(var TFuente:tfuente;var Control:longint;Var lexema:string):boolean;
Function EsCadena(var TFuente:tfuente;var Control:longint;Var lexema:string):boolean;
Function EsIden(var TFuente:tfuente;var Control:longint;Var lexema:string):boolean;
Function EsOR(var TFuente:tfuente;var Control:longint;Var lexema:string;Var Complex:Terminales):boolean;
Function EsOA(var TFuente:tfuente;var Control:longint;Var lexema:string;Var Complex:Terminales):boolean;
Function EsOPA(var TFuente:tfuente;var Control:longint;Var lexema:string;VAR COMPLEX:TERMINALES):boolean;
Procedure SigComplex(Var TFuente:tfuente;var Control:longint;Var Complex:Terminales;Var Lexema:String;VAR L:LISTA);

implementation

Function EsNumero(var TFuente:tfuente;var Control:longint;Var lexema:string):boolean;
const
	F=[1,3];
Type
	Q = 0..4;
	Sigma=(Digito,Punto,Menos,Otro);
	TipoDelta=Array[Q,Sigma] of Q;
Var
	car:char;
	EstadoActual:Q;
	Delta:TipoDelta;
	Fin:boolean;
	Paso:set of char;

Function Cambio(Car:Char):Sigma;
Begin
	Case Car of
		'0'..'9':Cambio:=Digito;
		',':Cambio:=Punto;
		'-':Cambio:=Menos;
		else
			Cambio:=Otro;
	end;
End;

begin
	Paso:=['<','>','.','=',':','(',')','+','*','/','^'];
	Delta[0,Digito]:=1;
	Delta[0,Menos]:=1;
	Delta[0,Punto]:=4;
	Delta[0,Otro]:=4;
	Delta[1,Digito]:=1;
	Delta[1,Menos]:=4;
	Delta[1,Otro]:=4;
	Delta[1,Punto]:=2;
	Delta[2,Digito]:=3;
	Delta[2,Otro]:=4;
	Delta[2,Punto]:=4;
	Delta[3,Digito]:=3;
    Delta[3,Otro]:=4;
	Delta[3,Punto]:=4;
	FIN:=FALSE;
	EstadoActual:=q0;
	Seek(Tfuente,Control);
	Read(TFuente,car);
	While (car > #32) and not (car in Paso) and (EstadoActual <> 4) and (Fin=false) do
	begin
		EstadoActual:=Delta[EstadoActual,Cambio(car)];
		IF CAR=',' THEN 
			LEXEMA:=LEXEMA+'.'
		ELSE
			lexema:=lexema+car;
		If not eof(tFuente) then
			Read(TFuente,car)
		else 
			fin:=true;;
	end;
	If EstadoActual in F then
	begin
		EsNumero:=True;
		Control:=FilePos(TFuente)-1;
	end
	else
	begin
		lexema:= '';
		EsNumero:=False;
	end;
end;

Function EsCadena(var TFuente:tfuente; var Control:longint;Var lexema:string):boolean;
Const
	F=[2];
Type
	Q=0..3;
	Sigma=(Comilla,Dentro,Fuera);
	TipoDelta=Array[Q,Sigma] of Q;
var
	car:char;
	Delta:TipoDelta;
	EstadoActual:Q;
	Fin:boolean;
Function Cambio(Car:Char):Sigma;
begin
	Case Car of
		#39: Cambio:=Comilla;
		#10,#13:Cambio:=Fuera;
	else
		Cambio:=Dentro;
	end;
end;

begin
	Delta[0,Comilla]:=1;
	Delta[0,Fuera]:=3;
	Delta[0,Dentro]:=3;
	Delta[1,Dentro]:=1;
	Delta[1,Fuera]:=3;
	Delta[1,Comilla]:=2;
	EstadoActual:=q0;
	Seek(Tfuente,Control);
	Read(TFuente,car);
	EstadoActual:=Delta[EstadoActual,Cambio(car)];
	FIN:=FALSE;
	If (EstadoActual = 1) then
	begin
		While (EstadoActual = 1 ) do
		begin
			If NOT (EstadoActual in F) or (EstadoActual=3) and (Fin=false) then
				If not eof(tFuente) then
					Read(TFuente,car)
				else 
					fin:=true;
			EstadoActual:=Delta[EstadoActual,Cambio(car)];
			IF NOT (ESTADOACTUAL IN F) THEN
				lexema:=lexema+car;
		end;
		If EstadoActual in F then
		begin
			EsCadena:=True;
			Control:=FilePos(TFuente);
		end
		else
		begin
			lexema:= '';
			EsCadena:=False;
		end;
	end
	Else
		Escadena:=False;
end;

Function EsIden(var TFuente:tfuente;var Control:longint;Var lexema:string):boolean;
Const
	F=[1];
type
	Q=0..2;
	Sigma=(Letra,Digito,Otro);
	TipoDelta=Array[Q,Sigma] of Q;
var
	car:char;
	Delta:TipoDelta;
	estadoactual:Q;
	Fin:boolean;
	Paso:set of char;
Function Cambio(Car:Char):Sigma;
begin
	Case Car of
		'0'..'9':Cambio:=Digito;
		'a'..'z','A'..'Z':Cambio:=Letra;
	else
		Cambio:=Otro;
	end;
end;

begin
	Delta[0,Digito]:=2;
	Delta[0,Letra]:=1;
	Delta[0,Otro]:=2;
	Delta[1,Digito]:=1;
	Delta[1,Letra]:=1;
	Delta[1,Otro]:=2;
	estadoactual:=q0;
	Fin:=False;
	Paso:=['<','>','.','=',':','(',')','+','-','*','/',','];
	Seek(Tfuente,Control);
	Read(TFuente,car);
	While (car >#32) and (estadoactual <> 2) and not (Car in Paso) and (fin=False) do
	begin
		estadoactual:=Delta[estadoactual,Cambio(car)];
		If estadoactual <> 2 then
		begin
			lexema:=lexema+car;
			if not eof(tfuente) then
				Read(TFuente,car)
			else
				fin:=true;
		end;
	end;
	If estadoactual in F then
	begin
		EsIden:=True;
		//If car in paso then
		Control:=Filepos(TFuente)-1
		//else Control:=Filepos(TFuente);
	end
	else
	begin
		lexema:= '';
		EsIden:=False;
	end;
 end;


Function EsOR(var TFuente:tfuente;var Control:longint;Var lexema:string;Var Complex:Terminales):boolean;
const
	F=[1,2,3];
type
	Q=0..4;
	Sigma=(Ma,Me,Igu,Otro);
	TipoDelta=Array[Q,Sigma] of Q;
var
	car:char;
	estadoactual:Q;
	delta:TipoDelta;
	A:Sigma;
	Fin:boolean;

function cambio(Car:char):Sigma;
begin
	Case Car of
		'>':cambio:=Ma;
		'<':cambio:=Me;
		'=':cambio:=Igu;
	else
		cambio:=Otro;
	end;
end;

Begin
	estadoactual:=q0;
	delta[0,Me]:=2;
	delta[0,Ma]:=3;
	delta[0,Igu]:=1;
	delta[1,Me]:=4;
	delta[1,Ma]:=4;
	delta[1,Igu]:=4;
	delta[2,Igu]:=1;
	delta[2,Ma]:=1;
	delta[2,Me]:=4;
	delta[3,Igu]:=1;
	delta[3,Ma]:=4;
	delta[3,Me]:=4;
	Seek(Tfuente,Control);
	read(TFuente,car);
	A:=cambio(car);
	fin:=False;
	While (A <> Otro) and (estadoactual<>4) and (Fin=false)  do
	begin
		estadoactual:=delta[estadoactual,A];
		if (estadoactual <> 4) then
		begin
			lexema:=lexema+car;
			If not eof(Tfuente) then
			begin
				read(TFuente,car);
				A:=cambio(car);
			end
			else Fin:=true;
		end;
	end;
	if estadoactual in F then
	begin
		control:= filepos(TFuente)-1;
		if lexema='<' then 
			COMPLEX:=MENOR
		else if lexema='>'then 
			COMPLEX:=MAYOR
		else if lexema='<='then
			COMPLEX:=MENORI
		else if lexema='>='then 
			COMPLEX:=MAYORI
		else if lexema='<>' then 
			COMPLEX:=DISTINTO
		ELSE IF LEXEMA='=' THEN 
			COMPLEX:=IGUAL;
		EsOR:= true;
	end
	else
	begin
		lexema:= '';
		EsOR:=false;
	end;
end;


Function EsOA(var TFuente:tfuente;var Control:longint;Var lexema:string;Var Complex:Terminales):boolean;
Const
	F=[1,2];
Type
	Q=0..3;
	Sigma=(Pun,Igu,Otro);
	TipoDelta=array[Q,Sigma] of Q;
var
	car:char;
	A:Sigma;
	estadoactual:Q;
	delta:TipoDelta;
	fin:boolean;

Function cambio(Car:Char):Sigma ;
begin
	case Car of
		':':cambio:=Pun;
		'=':cambio:=Igu;
	else
		cambio:=Otro;
	end;
end;

Begin
	estadoactual:=q0;
	delta[0,Pun]:=1;
	delta[0,Igu]:=3;
	delta[1,Pun]:=3;
	delta[1,Igu]:=2;
	delta[2,Igu]:=3;
	delta[2,Pun]:=3;
	fin:=false;
	Seek(Tfuente,Control);
	Read(TFuente,car);
	A:=Cambio(car);
	While (A <> Otro) and (estadoactual<>3) and (fin=false) do
	begin
		estadoactual:=delta[estadoactual,A];
		If estadoactual<>3 then
		begin
			lexema:=lexema+car;
			if not eof(tFuente) then
			begin
				Read(TFuente,car);
				A:=Cambio(car);
			end
			else
			begin 
				Fin:=true; 
				A:=Otro;
			end;
		end;
	end;
	If (estadoactual in F) then
	begin
		case estadoactual of
			1:COMPLEX:=DOSPUNTOS;
			2:COMPLEX:=ASIGNACION1;
		END;
		Control:=FilePos(TFuente)-1;
		EsOA:=True;
	end
	else
	begin
		EsOA:=false;
		lexema:='';
	end;
end;


Function EsOPA(var TFuente:tfuente;var Control:longint;Var lexema:string;VAR COMPLEX:TERMINALES):boolean;
var 
	car:Char;
Begin
	Seek(Tfuente,Control);
	Read(TFuente,car);
	case car of
		'+':begin
			EsOPA:=True; lexema:=lexema+car; Complex:=SUMA; Control:=Filepos(TFuente);
		end;
		'*':begin
			EsOPA:=True; lexema:=lexema+car; Complex:=MULT; Control:=Filepos(TFuente);
		end;
		'/':begin
			EsOPA:=True; lexema:=lexema+car; Complex:=DIB; Control:=Filepos(TFuente);
		end;
		'(':begin
			EsOPA:=True; lexema:=lexema+car;Complex:=PARENTESISA; Control:=Filepos(TFuente);
		end;
		')':begin
			EsOPA:=True; lexema:=lexema+car; Complex:=PARENTESISB; Control:=Filepos(TFuente);
		end;
		'.':begin
			EsOPA:=True; lexema:=lexema+car; Complex:=PUNTO; Control:=Filepos(TFuente);
		end;
		',':begin
			EsOPA:=True; lexema:=lexema+car; Complex:=COMA; Control:=Filepos(TFuente);
		end;
		'^': begin
			EsOPA:=TRUE; lexema:=lexema+car; complex:=POTEN; COntrol:=Filepos(Tfuente);
		end;  
	else
	Begin 
		EsOPA:=False; 
		Lexema:=''; 
	end;
	end;
end;

Procedure SigComplex(Var TFuente:tfuente;var Control:longint;Var Complex:Terminales;Var Lexema:String;VAR L:LISTA);
var	
	car:char;
begin
	LEXEMA:='';
	seek(Tfuente,Control);
	
	
	 if not eof(Tfuente) then
	   Read(Tfuente,car);
	   
	IF EOF(Tfuente)=true then
	begin
	Write(tFuente,' ');
	control:=control-1;
	end; 	 
		
	If (car > #32) and (not eof (Tfuente)) then
	Begin
	   
		Control:=FilePos(Tfuente)-1;
		Seek(Tfuente,Control);
		end;
		
		While (car < #33) and not eof(Tfuente) do
		begin
			Read(Tfuente,car);
			If (car > #32 )then
				Seek(TFuente,FilePos(Tfuente)-1);
	end;
	
	Control:=FilePos(Tfuente);
	seek(Tfuente,control);
	If eof(Tfuente) then
		Complex:=PESOS
	else If EsIden(Tfuente,Control,Lexema) then
		Insertartabla (L,lexema,complex)
	else If EsNumero(Tfuente,Control,Lexema)then
	begin	
		Complex:=ConstanteReal;
	end
	else If EsCadena(Tfuente,Control,Lexema) then
	begin
		Complex:=ConstanteCadena;
	end
	else IF EsOR(Tfuente,Control,Lexema,Complex) then
		else If EsOA(Tfuente,Control,Lexema,Complex) then
			else If ESOPA(Tfuente,Control,Lexema,COmplex) then
				else  Complex:=ErrorLexico;
end;



end.

