:- consult('paises.pl').
:- consult('capitais.pl').

listar(Atributos):-
    findall(Pais, (
                pais(Pais, AtrPais),
                forall(member(Atr, Atributos), member(Atr, AtrPais))
                ),
            Paises),

    ( Paises = []
    -> write('Nenhum país correspondente.'), nl
    ;  write('Países possíveis:'), nl,
       forall(member(Pais, Paises), (
           write(Pais), nl
       ))
    ).

carac(Pais):-
    pais(Pais, Carac),
    write(Carac), nl.

capitais:-
    forall(capital(Cap, Pais), format('~w~n',[Cap])).

paises:-
    listar(pais(Pais, AtrPais)).

:- dynamic pais_correto/1.
:- dynamic dicas_dadas/1.
:- dynamic palpites/1.

iniciar_jogo :-
    findall(P, pais(P, _), Paises),
    random_member(Correto, Paises),
    retractall(pais_correto(_)),
    asserta(pais_correto(Correto)),
    retractall(dicas_dadas(_)),
    assertz(dicas_dadas(0)),
    retractall(palpites(_)),
    assertz(palpites(0)),
    write('Jogo iniciado! Tente adivinhar o país.'), nl.

e_numerico(graus(_)).
e_numerico(populacao(_)).

verificar_palpite(Palpite) :-
    pais_correto(Correto),
    palpites(N),
    pais(Palpite, AtributosPalpite),
    pais(Correto, AtributosCorreta),

    exclude(e_numerico, AtributosPalpite, CategoricosPalpite),
    exclude(e_numerico, AtributosCorreta, CategoricosCorreta),
    intersection(CategoricosPalpite, CategoricosCorreta, AtributosComuns),
    format('Atributos do palpite: ~w~n', [AtributosPalpite]),
    format('Atributos em comum: ~w~n', [AtributosComuns]),

    member(graus(TempPalpite), AtributosPalpite),
    member(graus(TempCorreta), AtributosCorreta),
    (   TempPalpite == TempCorreta
    ->  write('-> Temperatura: Você acertou a temperatura!')
    ;   TempPalpite < TempCorreta
    ->  write('-> Temperatura: A do país correto é MAIOR.')
    ;   write('-> Temperatura: A do país correto é MENOR.')
    ),
    nl,

    member(populacao(PopPalpite), AtributosPalpite),
    member(populacao(PopCorreta), AtributosCorreta),
    (   PopPalpite == PopCorreta
    ->  write('-> População: Você acertou a população!')
    ;   PopPalpite < PopCorreta
    ->  write('-> População: A do país correto é MAIOR.')
    ;   write('-> População: A do país correto é MENOR.')
    ),
    N1 is N + 1,
    retractall(palpites(_)),
    assertz(palpites(N1)),
    nl,nl.

jogo :-
    iniciar_jogo,
    loop_palpites.

loop_palpites :-
    write('> Seu palpite: '),
    read(Palpite),
    pais_correto(Correto),
    palpites(N),
    dicas_dadas(M),
    (   Palpite == Correto
    ->  N1 is N + 1,
        format('Parabéns! Você acertou em ~w palpite(s) com ~w dica(s)! O país era ',[N1, M]),
        write(Correto), nl
    ;   (    Palpite == 'desisto')
        ->  write('Você desistiu! O país era '), write(Correto), nl
    ;   (    Palpite == 'capital')
        -> capital(CapCorreto, Correto),
           write('A capital do país é '), write(CapCorreto), nl,
           loop_palpites
    ;   (    Palpite == 'linguas')
        -> imprimir_linguas(Correto),
           loop_palpites
    ;   (    Palpite == 'dica')
        -> dica, nl,
           loop_palpites
    ;   (   \+ pais(Palpite, _)
        ->  write('Esse país não está no meu banco de dados. Tente outro.'), nl,nl,
            loop_palpites
        ;   verificar_palpite(Palpite),
            loop_palpites
        )
    ).

imprimir_linguas(Pais) :-
    pais(Pais, Atributos),
    encontrar_linguas(Atributos, Linguas),
    format('Línguas: ~w~n~n', [Linguas]).

encontrar_linguas(Atributos, Linguas) :-
    findall(X, (
        member(X, Atributos),
        atom(X),
        \+ e_numerico(X),
        \+ member(X, [hemisferio_norte, hemisferio_sul, america_do_sul, 
                     america_do_norte, america_central, europa, asia, 
                     africa, oceania])
    ), Linguas).

pegar_ate_graus([], []).
pegar_ate_graus([graus(_)|_], []).
pegar_ate_graus([populacao(_)|_], []).
pegar_ate_graus([X|Resto], [X|Resultado]) :-
    \+ e_numerico(X),
    pegar_ate_graus(Resto, Resultado).

exclude(_, [], []).
exclude(Pred, [X|Xs], Ys) :-
    (   call(Pred, X)
    ->  exclude(Pred, Xs, Ys)
    ;   Ys = [X|Ys1],
        exclude(Pred, Xs, Ys1)
    ).

dica :-
    pais_correto(Correto),
    dicas_dadas(N),
    atom_chars(Correto, Chars),
    (   N == 0 ->
        Chars = [Primeira | Resto],
        format('Dica: ~w', [Primeira]),
        print_sublinhados(Resto)
    ;   N == 1 ->
        Chars = [Primeira, Segunda | Resto],
        format('Dica: ~w~w', [Primeira, Segunda]),
        print_sublinhados(Resto)
    ;   N == 2 ->
        Chars = [Primeira, Segunda, Terceira | Resto],
        format('Dica: ~w~w~w', [Primeira, Segunda, Terceira]),
        print_sublinhados(Resto)
    ;
        Chars = [Primeira, Segunda, Terceira | Resto],
        format('Número máximo de dicas atingido: ~w~w~w', [Primeira, Segunda, Terceira]),
        print_sublinhados(Resto)
    ),
    (   N < 3 ->
    N1 is N + 1,
    retractall(dicas_dadas(_)),
    assertz(dicas_dadas(N1))

    ;retractall(dicas_dadas(_)),
    assertz(dicas_dadas(3))
    ).

print_sublinhados([]) :- nl.
print_sublinhados([_|Resto]) :-
    write(' _'),
    print_sublinhados(Resto).
