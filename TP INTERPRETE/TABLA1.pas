unit TABLA1;
interface
USES Tipos;
Procedure Insertar(Var L:lista;x:TipoTabla);
Procedure CrearLista(Var L:Lista);
Procedure Insertartabla (var L:lista;lexema:string;var complex:TERMINALES);
PROCEDURE MOSTRARLISTA(VAR L:LISTA);
Procedure BuscarLista(var L:lista;lexema:string;var dir:tpuntero);
implementation


Procedure Insertar(Var L:lista;x:TipoTabla);
var
	dir,ant,act:tpuntero;
begin
	New(dir);
	dir^.info:=x;
	If (l.cab=nil) or (l.cab^.info.componente< x.componente) then
	begin
		dir^.sig:=l.cab;
		l.cab:=dir;
	end
	else
	begin
		ant:=l.cab;
		act:=l.cab^.sig;
		while (act<>nil)and (act^.info.componente> x.componente) do
		begin
			ant:=act;
			act:=act^.sig;
		end;
		dir^.sig:=act;
		ant^.sig:=dir;
	end;
	inc(l.tam);
end;


Procedure CrearLista(Var L:Lista);
var x:tipotabla;
begin
	L.tam:=0;
	L.Cab:=nil;
	x.componente:=FUNCION;	
	x.lexema:='FUNCION';
	x.valor:=0;
	insertar(L,x);
	x.componente:=LEER;
	x.lexema:='LEER';
	insertar(L,x);
	x.componente:=MOSTRAR;
	x.lexema:='MOSTRAR';
	insertar(L,x);
	x.componente:=SI;
	x.lexema:='SI';
	insertar(L,x);
	x.componente:=SINO;
	x.lexema:='SINO';
	insertar(L,x);
	x.componente:=MIENTRAS;
	x.lexema:='MIENTRAS';
	insertar(L,x);
	x.componente:=PARA;
	x.lexema:='PARA';
	insertar(L,x);
	x.componente:=FIN;
	x.lexema:='FIN';
	insertar(L,x);
	x.componente:=HASTA;
	x.lexema:='HASTA';
	insertar(L,x);
	x.componente:=AN;
	x.lexema:='AND';
	insertar(L,x);
	x.componente:=O;
	x.lexema:='OR';
	insertar(L,x);
	x.componente:=RAIZ;
	x.lexema:='RAIZ';
	insertar(L,x);
end;


Procedure BuscarL(var L:lista;var x:TipoTabla);
var 
	dir:tpuntero;
begin
	dir:=l.cab;
	WHILE (dir<>NIL) and (dir^.info.lexema<>x.lexema)  DO
	BEGIN
		dir:=dir^.sig;
	END;

	If (dir=nil) then
	begin
		x.componente:=ID;
		insertar(l,x);
	end
	else
		x.componente:=dir^.info.componente;
end;


PROCEDURE MOSTRARLISTA(VAR L:LISTA);
VAR 
	DIR:TPUNTERO;
BEGIN
	DIR:=L.CAB;
	WHILE DIR<>NIL DO 
	BEGIN
		WRITELN(DIR^.INFO.LEXEMA);
		WRITELN('VALOR',DIR^.INFO.VALOR:4:2);
		DIR:=DIR^.SIG;
	END;
END;


Procedure Insertartabla (var L:lista;lexema:string;var complex:TERMINALES);
Var x:tipotabla;          	
	I:integer;
begin
	for i:=1 to length(lexema)do
	lexema[I]:=Upcase(Lexema[I]);
	x.lexema:=lexema;
	buscarL(l,x);
	complex:=x.componente;
end;


Procedure BuscarLista(var L:lista;lexema:string;var dir:tpuntero);
var i:byte;
begin
	dir:=l.cab;
	for i:=1 to length(lexema)do
	lexema[I]:=Upcase(Lexema[I]);
	WHILE (dir<>NIL) and (dir^.info.lexema<>lexema)  DO
		BEGIN
			dir:=dir^.sig;
		END;
	{if dir^.info.lexema<>lexema then
	dir:=nil;}
end;


end.

