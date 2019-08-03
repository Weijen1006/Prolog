start :- retractall(item(_,_)),retractall(weapon(_)),retractall(score(_)),retractall(hp(_)),
	 assert(hp(fresh)),assert(score(0)),assert(weapon(woodenspatula)),
	 assert(item(potion,5)),
	 assert(item(blowtorch,3)),
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
deducthp :- hp(fresh), retractall(hp(_)), assert(hp(raw)).
deducthp :- hp(raw), retractall(hp(_)),assert(hp(spoil)).
deducthp :- hp(spoil), retractall(hp(_)), assert(hp(rotten)).
deducthp :- hp(rotten), retractall(hp(_)), assert(hp(die)).
deducthp :- hp(die),!.

battlestatus :- hp(X), write('Player Hp : '),write(X),nl,
		enemy(_,Name,Hp), write(Name), write(' Hp : '),write(Hp),nl.

%item
use(potion) :- item(potion,0),nl, write('You have no tomato juice left'),nl.
use(potion) :- item(potion,X), X > 0, NewX is X - 1, retractall(item(potion,_)), assert(item(potion,NewX)), retractall(hp(_)), assert(hp(fresh)),nl,
	       write('1 tomato juice used, player health recovered to fresh !'),nl,
	       write(NewX), write(' tomato juice left'),nl.
use(blowtorch) :- item(blowtorch,0),nl, write('You have no blowtorch left'),nl.
use(blowtorch) :- item(blowtorch,X), X > 0, NewX is X - 1, retractall(item(blowtorch,_)), assert(item(blowtorch,NewX)),
		  enemy(Type,Name,Hp), Newhp is Hp - 2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)),nl,
		  write('You used blowtorch on the enemy, 2 damage dealt !'),nl,write(NewX),write(' blowtorch left'),nl.

%Monster
enemyattack(_,X) :- X =< 20, write('You managed to dogde the monster attack'),nl,nl.
enemyattack('Meatball',X) :- X > 20, write('Meatball attack!   Player hp - 1'), nl,nl, deducthp.
enemyattack('Tarrot',X) :- X > 20, write('Tarrot attack! Player hp - 1'),nl,nl,deducthp.
enemyattack('Crying Onion',X) :- X> 20, write('Crying Onion makes you sad! Player hp - 1 from sadness'),nl,nl,deducthp.
enemyattack('Caesar Salad', X) :- X > 20, write('Caesar Salad attacks! Player hp - 1'),nl,nl,deducthp. 

%Weapon
weaponattack(woodenspatula) :- random(1,101,X), woodenspatula(X).
woodenspatula(X) :- X =< 35,nl, write('Your attack missed!'),nl.
woodenspatula(X) :- X > 35,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).

%Battle
battle :- \+hp(die), enemy(_,_,Y), Y > 0, write('What will you do next? :'), read(Z), action(Z), battle; result.

action(attack) :- weapon(X), weaponattack(X),nl,battlestatus,nl, enemy(_,Name,Hp), Hp > 0,random(1,101,Random), enemyattack(Name,Random),battlestatus,nl.
action(attack) :- enemy(_,_,Hp), Hp =< 0,!.
action(potion) :- use(potion), nl,write('What will you do next? : '),read(X),action(X).
action(blowtorch) :- use(blowtorch),nl, battlestatus,nl,enemy(_,_,Hp), Hp > 0, write('What will you do next? :'),read(X),action(X).
action(blowtorch) :- enemy(_,_,Hp), Hp =< 0,!.
action(_) :- write('Invalid action, please try again'), nl, write('What will you do next? : '),read(X) ,action(X).

result :- hp(die), write('You die'),retractall(enemy(_,_,_)),nl.
result :- enemy(_,Name,Hp), Hp =< 0, write('You defeated '), write(Name), write('! Good Job!'),nl ,retractall(enemy(_,_,_)).

%Utility
help :- write('List of helpful command'),nl,
	write('itemlist. - to check available item in your inventory'),nl,
	write('potion. - to use tomato juice'),nl,
	write('blowtorch. - only can use on enemy'),nl,
	write('pepper. - only can use on enemy'),!.

itemlist :- weapon(X), write('Weapon : '),write(X),nl,
	    (item(potion,Y),Y > 0, write('Tomato juice   x '),write(Y),nl;!),
	    (item(blowtorch,Z),Z > 0, write('Blowtorch   x '),write(Z),nl;!),
	    (item(pepper,A),A > 0, write('Pepper   x '),write(A),nl;!),
	    (item(mt,yes), write('Meat Tenderizer'),nl;!),
	    (item(co,yes), write('Can Opener'),nl;!),
	    (item(corkscrew,yes), write('Corkscrew'),nl;!),!.

fightmeatball :- write('A wild meatball appears !'),assert(enemy(neutral,'Meatball',6)),nl,nl,battlestatus,nl, battle.
fighttarrot :- write('A wild tarrot appears !'),assert(enemy(neutral,'Tarrot',6)),nl,nl,battlestatus,nl,battle.
fightonion :- write('A crying onion appears ?'),assert(enemy(neutral,'Crying Onion',6)),nl,nl,battlestatus,nl,battle.
fightsalad :- write('A Caesar Salad appears !'), assert(enemy(neutral,'Caesar Salad',6)),nl,nl,battlestatus,nl,battle.
