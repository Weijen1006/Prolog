start :- retractall(item(_,_)),retractall(weapon(_)),retractall(score(_)),retractall(hp(_)),
	 assert(hp(fresh)),assert(score(0)),assert(weapon(woodenspatula)),
	 assert(item(potion,3)),
	 assert(item(blowtorch,0)),
	 assert(item(pepper,0)),
	 assert(item(mt,no)),
	 assert(item(co,no)),
	 assert(item(corkscrew,no)),
	 write('Starting of the story'),nl,town.

town :- write('          | N |          '),nl,
	write('          |   |          '),nl,
	write('          |   |          '),nl,
	write('          |   |          '),nl,
	write('          |   |          '),nl,
	write('----------     ----------'),nl,
	write('I          Town         F'),nl,
	write('----------     ----------'),nl,
	write('          |   |          '),nl,
	write('          |   |          '),nl,
	write('          |   |          '),nl,
	write('          |   |          '),nl,nl,
	write('Please choose a place to go (up/left/right)'),nl,
	write('Your choice : '),read(X),location(X).

location(up) :- write('You choose neutral faction, Good Luck'),nl,neutral.
location(left) :- write('You choose ice faction, Good Luck'),nl,ice.
location(right) :- write('You choose fire faction, Good Luck'),nl,fire.
location(down) :- write('I see what you try to do there, but there is no going back'),nl,write('Your choice : '),read(X),location(X).
location(_) :- write('Invalid Input, Please try again'),nl,write('Your choice : '),read(X),location(X).

%Neutral faction
neutral :- write('Stay tuned').

%Ice faction
ice :- write('Stay tuned').

%Fire faction
fire :- write('Stay tuned').

%HP
deducthp :- hp(fresh), retractall(hp(_)), assert(hp(spoil)).
deducthp :- hp(spoil), retractall(hp(_)), assert(hp(rotten)).
deducthp :- hp(rotten), retractall(hp(_)), assert(hp(die)).
deducthp :- hp(die),!.

battlestatus :- hp(X), write('Player Hp : '),write(X),nl,
		enemy(Name,Hp), write(Name), write(' Hp : '),write(Hp),nl.


%Monster
enemyattack(meatball) :- write('Meatball attack!   Player hp - 1'), nl,nl, deducthp. 

%Weapon
weaponattack(woodenspatula) :- random(1,101,X), woodenspatula(X).
woodenspatula(X) :- X =< 35,nl, write('Your attack missed!'),nl.
woodenspatula(X) :- X > 35,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Name,Hp), Newhp is Hp-1, retractall(enemy(_,_)), assert(enemy(Name,Newhp)).

%Battle
battle :- hp(X), enemy(_,Y), X \= die, Y > 0, write('What will you do next? :'), read(Z), action(Z), battle; result.

action(attack) :- weapon(X), weaponattack(X),nl,battlestatus,nl, enemy(Name,Hp), Hp > 0, enemyattack(Name),battlestatus,nl.
action(attack) :- enemy(_,Hp), Hp =< 0,!.
action(_) :- write('Invalid action, please try again'), nl, write('What will you do next? : '),read(X) ,action(X).

result :- hp(die), write('You die'),nl.
result :- enemy(Name,Hp), Hp =< 0, write('You defeated '), write(Name), write('! Good Job!'),nl ,retractall(enemy(_,_)).

%Utility
help :- write('List of helpful command'),nl,
	write('itemlist. - to check available item in your inventory'),nl,
	write('potion. - to use tomato juice'),nl,
	write('blowtorch. - only can use on enemy'),nl,
	write('pepper. - only can use on enemy'),!.

itemlist :- weapon(X), write('Weapon : '),write(X),nl,
	    item(potion,Y), write('Tomato juice   x '),write(Y),nl,
	    item(blowtorch,Z), write('Blowtorch   x '),write(Z),nl,
	    item(pepper,A), write('Pepper   x '),write(A),nl,
	    ((item(mt,yes), write('Meat Tenderizer'),nl);(item(mt,no),!)),
	    ((item(co,yes), write('Can Opener'),nl);(item(co,no),!)),
	    ((item(corkscrew,yes), write('Corkscrew'),nl);(item(corkscrew,no),!)),!.

testevent :- write('A wild meatball appears !'),assert(enemy(meatball,2)),nl, battle.