:- use_module(library(http/http_server)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).

:- json_object node(id:number, title:atom).
:- json_object node(id:number, title:atom, yes:node/2, no:node/2).
:- json_object node(id:number, title:atom, yes:node/2, no:node/4).
:- json_object node(id:number, title:atom, yes:node/4, no:node/2).
:- json_object node(id:number, title:atom, yes:node/4, no:node/4).

:- http_handler('/nodes/next/yes', yes(Method), [method(Method), methods([post])]).
:- http_handler('/nodes/next/no', no(Method), [method(Method), methods([post])]).
:- http_handler('/nodes/current', getCurrent(Method), [method(Method), methods([get])]).
:- http_handler('/nodes', getAll(Method), [method(Method), methods([get])]).
:- http_handler('/nodes/restart', restart(Method), [method(Method), methods([post])]).
:- http_handler('/nodes/title', updateTitle(Method), [method(Method), methods([post])]).
:- http_handler('/nodes/type', updateType(Method), [method(Method), methods([post])]).

:- dynamic node/4.
:- dynamic node/2.
:- dynamic current/3.
:- dynamic count/1.

node(1, 'Ваша ОС Windows?', 2, 42).
node(2, 'Для вас важно наличие мультиплеера?', 3, 4).
node(3, 'Если игры нет в Steam, вы будете в неё играть?', 5, 6).
node(5, 'Escape From Tarkov').
node(6, 'Вам будет интересна игра, если по ней нет киберспортивной дисциплины?', 7, 8).
node(7, 'Для вас многое значат высокие оценки критиков?', 9, 10).
node(9, 'Игра должна быть современной?', 11, 12).
node(11, 'Вам нравятся социальные игры по типу мафии?', 13, 14).
node(13, 'Among Us').
node(14, 'Red Dead Online').
node(12, 'S.T.A.L.K.E.R.: Shadow of Chernobyl').
node(10, 'Вам нравится сеттинг Второй мировой войны?', 15, 16).
node(15, 'Call of Duty: WWII').
node(16, 'Для вас приемлемо, если игра будет периодически вылетать и/или ловить баги?', 17, 18).
node(17, 'Killing Floor 2').
node(18, 'Dying Light').
node(4, 'Вы ищете игру, ставшую классикой?', 19, 20).
node(19, 'Вас интересует игра, побеждавшая в номинации "Игра года" от The Game Awards?', 21, 22).
node(21, 'Для вас многое значат высокие оценки других игроков?', 23, 24).
node(23, 'The Witcher 3: Wild Hunt').
node(24, 'The Elder Scrolls V: Skyrim').
node(22, 'Вам нужна игра, выстроенная вокруг сильной истории?', 25, 26).
node(25, 'Mafia 2').
node(26, 'Вам нравится заниматься в игре развитием своего персонажа?', 27, 28).
node(27, 'Вы бы хотели, чтобы окружающий мир реагировал на ваши действия в игре?', 29, 12).
node(29, 'Fallout: New Vegas').
node(28, 'Outlast').
node(20, 'Захватывающий геймплей - это то, ради чего вы можете возвращаться в игру снова и снова?', 30, 31).
node(30, 'У игры должна быть современная графика?', 32, 33).
node(32, 'Вы готовы провести в одной игре более 100 часов?', 34, 35).
node(34, 'Assassins Creed Odyssey').
node(35, 'Вам бы хотелось, чтобы игра являлась частью франшизы?', 18, 36).
node(36, 'Detroit: Become Human').
node(33, 'Dishonored').
node(31 , 'Если в игре нет поддержки русского языка, вы будете в нее играть?', 37, 38).
node(37, 'Вам нравятся игры от Ubisoft?', 39, 40).
node(39, 'Prince of Persia: The Sands of Time').
node(40, 'Dead Space').
node(38, 'Вы любите посмеяться за игрой?', 41, 15).
node(41, 'Fable').
node(42, 'Ваша OC MacOS?', 43, 45).
node(43, 'Вам нравятся игры с высокой динамикой?', 45, 46).
node(45, 'Для вас многое значит качественная атмосфера в игре?', 47, 8).
node(47, 'Вам нравится, когда в игре есть открытый мир?', 18, 28).
node(8, 'Вам больше нравятся игры от 1 лица?', 48, 49).
node(48, 'Counter-Strike: Global Offensive').
node(49, 'Dota 2').
node(46, 'Вам бы хотелось, чтобы у игры были геймплейные DLC?', 25, 41).

count(49).

current(1, 'Ваша ОС Windows?', 'QUESTION').

start :- http_server(http_dispatch, [port(8081)]).

stop :- http_stop_server(8081, []).

yes(post, _) :- next(yes), emptyResponse().

no(post, _) :- next(no), emptyResponse().

next(yes) :-
    current(Id, _, _), node(Id, _, YesId, _),
    getPointTitle(YesId, YesTitle), getNodeType(YesId, Type),
    retract(current(Id, _, _)), assert(current(YesId, YesTitle, Type)).

next(no) :-
    current(Id, _, _), node(Id, _, _, NoId),
    getPointTitle(NoId, NoTitle), getNodeType(NoId, Type),
    retract(current(Id, _, _)), assert(current(NoId, NoTitle, Type)).

getPointTitle(Id, Title) :- node(Id, Title).
getPointTitle(Id, Title) :- node(Id, Title, _, _).

getNodeType(Id, 'RESULT') :- node(Id, _).
getNodeType(Id, 'QUESTION') :- node(Id, _, _, _).

getCurrent(get ,_) :-
    current(Id, Title, Type),
    format('Content-type: application/json~n~n{"id":"~w","title":"~w",~n"type":"~w"}', [Id, Title, Type]).

getAll(get, _) :-
    getRoot(RootId), getTree(RootId, Tree),
    prolog_to_json(Tree, JsonTerm), atom_json_term(Json, JsonTerm, []),
    format('Content-type: application/json~n~n~w', Json).

getRoot(1).

getTree(Id, Tree) :-
    node(Id, Title), Tree = node(Id, Title).

getTree(Id, Tree) :- node(Id, Title, YesId, NoId),
    getTree(YesId, YesTree), getTree(NoId, NoTree),
    Tree = node(Id, Title, YesTree, NoTree).

restart(post, _) :-
    retract(current(_, _, _)), node(1, Title, _, _),
    assert(current(1, Title, 'QUESTION')),
    emptyResponse().

updateTitle(post, Request) :-
    http_read_json(Request, Dict, [json_object(dict)]),
    Id = Dict.get(id), StringTitle = Dict.get(title),
    string_to_atom(StringTitle, AtomTitle),
    updateTitle(Id, AtomTitle),
    emptyResponse().

updateTitle(Id, Title) :-
    node(Id, _), retract(node(Id, _)),
    assert(node(Id, Title)).

updateTitle(Id, Title) :-
    node(Id, _, YesId, NoId),
    retract(node(Id, _, _, _)),
    assert(node(Id, Title, YesId, NoId)).

updateType(post, Request) :-
    http_read_json(Request, Dict, [json_object(dict)]),
    Id = Dict.get(id), updateType(Id),
    emptyResponse().

updateType(Id) :-
    node(Id, Title, _, _), retract(node(Id, _, _, _)),
    assert(node(Id, Title)).

updateType(Id) :-
    node(Id, Title), retract(node(Id, _)),
    addGame(YesId), addGame(NoId),
    assert(node(Id, Title, YesId, NoId)).

addGame(Id) :-
    count(PrevId), retract(count(PrevId)), Id is PrevId + 1,
    assert(count(Id)), assert(node(Id, 'Пусто')).

emptyResponse() :- format('Content-type: application/json~n~n').