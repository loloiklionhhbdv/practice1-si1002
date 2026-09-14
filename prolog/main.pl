periodo(262, '2026-2').
periodo(271, '2027-1').
periodo(272, '2027-2').
periodo(281, '2028-1').
periodo(282, '2028-2').
periodo(291, '2029-1').
periodo(292, '2029-2').

divisor_propio(N, D) :-
    between(1, N, D), D < N,
    0 is N mod D.
    
divisores(N, Lista) :-
    findall(D, divisor_propio(N, D), Lista).
    
suma_divisores(N, Suma) :-
    divisores(N, Lista),
    sum_list(Lista, Suma).
    
nicomachus(N, perfecto) :-
    suma_divisores(N, Suma),
    Suma =:= N.
    
nicomachus(N, abundante) :-
    suma_divisores(N, Suma),
    Suma > N.

nicomachus(N, deficiente) :-
    suma_divisores(N, Suma),
    Suma < N.
    
categoria(N, 'Engineering'):- 
    nicomachus(N, perfecto).
    
categoria(N, 'Administrative'):- 
    nicomachus(N, abundante).

categoria(N, 'Humanities'):- 
    nicomachus(N, deficiente).
    
descomponer_codigo(Codigo, CodigoPeriodo, CodigoCategoria, Numero) :-
    integer(Codigo),
    Codigo >= 10000000, Codigo =< 99999999,
    CodigoPeriodo is Codigo // 100000,
    CodigoCategoria is (Codigo // 1000) mod 100,
    Numero is Codigo mod 1000.

etiqueta(Numero, Etiqueta):-
    atomic_concat(num, Numero, Etiqueta).

paridad(Codigo, even):-
    0 is Codigo mod 2.
    
paridad(Codigo, odd):-
    1 is Codigo mod 2.  
    
codigo_estudiante(Codigo, Periodo, Categoria, Numero, Paridad):-
    descomponer_codigo(Codigo, CodigoPeriodo, CodigoCategoria, CodigoNumero),
    periodo(CodigoPeriodo, Periodo),
    categoria(CodigoCategoria, Categoria),
    etiqueta(CodigoNumero, Numero),
    paridad(Codigo, Paridad).

describir_codigo(Codigo, Descripcion):-
    codigo_estudiante(Codigo, Periodo, Categoria, Numero, Paridad),
    atomic_list_concat([Periodo, Categoria, Numero, Paridad],' ' , Descripcion).

generar_codigo(Periodo, Categoria, Codigo):-
    periodo(CodigoPeriodo, Periodo),
    between(1, 99, CodigoCategoria),
    categoria(CodigoCategoria, Categoria),
    between(1, 999, Numero),
    Codigo is CodigoPeriodo * 100000 + CodigoCategoria * 1000 + Numero,
    codigo_estudiante(Codigo, Periodo, Categoria,_,_).
    
main :-
writeln('Comprobacion ejemplos'),
    describir_codigo(26276002, R1),
    writeln(R1),

    describir_codigo(27128112, R2),
    writeln(R2),

    describir_codigo(27206025, R3),
    writeln(R3),

    describir_codigo(28124236, R4),
    writeln(R4),

    describir_codigo(28299115, R5),
    writeln(R5),
    nl,
    
 writeln('Verificacion'),
    codigo_estudiante(26276002,'2026-2','Humanities',num2,even),

    writeln('La verificacion fue correcta.'),
    nl,

writeln('Prueba invalido'),
    \+ codigo_estudiante(2627600,_,_,_,_),

    writeln('El codigo de 7 digitos fue rechazado.'),
    nl,
 writeln('Generar codigos'),
    generar_codigo('2029-2','Engineering',CodigoGenerado),

    format('Codigo generado: ~w~n', [CodigoGenerado]).
    
:- initialization(main).
