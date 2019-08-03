start :- retractall(item(_,_)),retractall(weapon(_)),retractall(score(_)),retractall(hp(_)),retractall(sneeze(_)),
	 assert(hp(healthy)),assert(score(0)),assert(weapon(woodenspatula)),
	 assert(item(potion,5)),
	 assert(item(blowtorch,3)),
	 assert(item(pepper,3)),
	 assert(item(mt,no)),
	 assert(item(co,no)),
	 assert(item(corkscrew,no)),
	 assert(sneeze(no)),
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
deducthp :- hp(healthy), retractall(hp(_)), assert(hp(fresh)).
deducthp :- hp(fresh), retractall(hp(_)), assert(hp(raw)).
deducthp :- hp(raw), retractall(hp(_)),assert(hp(spoil)).
deducthp :- hp(spoil), retractall(hp(_)), assert(hp(rotten)).
deducthp :- hp(rotten), retractall(hp(_)), assert(hp(die)).
deducthp :- hp(dead),!.

battlestatus :- hp(X), write('Player Hp : '),write(X),nl,
		enemy(_,Name,Hp), write(Name), write(' Hp : '),write(Hp),nl.

%item
use(potion) :- item(potion,0),nl, write('You have no tomato juice left'),nl.
use(potion) :- item(potion,X), X > 0, NewX is X - 1, retractall(item(potion,_)), assert(item(potion,NewX)), retractall(hp(_)), assert(hp(healthy)),nl,
	       write('1 tomato juice used, player health recovered to healthy !'),nl,
	       write(NewX), write(' tomato juice left'),nl.
use(pepper) :- item(pepper,0),nl,write('You have no pepper left'),nl.
use(pepper) :- item(pepper,X), X > 0, NewX is X - 1, retractall(item(pepper,_)), assert(item(pepper,NewX)), retractall(sneeze(_)),assert(sneeze(yes)),nl,enemy(_,Name,_),
	       write('1 pepper used, '),write(NewX),write(' pepper left'),nl,write('Looks like '),write(Name),write(' is about to sneeze !'),nl.
use(blowtorch) :- item(blowtorch,0),nl, write('You have no blowtorch left'),nl.
use(blowtorch) :- item(blowtorch,X), X > 0, NewX is X - 1, retractall(item(blowtorch,_)), assert(item(blowtorch,NewX)),
		  enemy(Type,Name,Hp), Newhp is Hp - 2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)),nl,
		  write('You used blowtorch on the enemy, 2 damage dealt !'),nl,write(NewX),write(' blowtorch left'),nl.

%Monster
enemyattack('Meatball',X) :- X > 40, write('Meatball attack!   Player hp - 1'), nl,nl, deducthp.
enemyattack('Tarrot',X) :- X > 15, write('Tarrot attack! Player hp - 1'),nl,nl,deducthp.
enemyattack('Crying Onion',X) :- X> 20, write('Crying Onion makes you sad! Player hp - 1 from sadness'),nl,nl,deducthp.
enemyattack('Caesar Salad', X) :- X > 60, write('Caesar Salad attacks! Player hp - 2'),nl,nl,deducthp,deducthp.
enemyattack(_,_) :- enemy(_,Name,_),write('You managed to dodge '),write(Name),write(' attack'),nl,nl. 

%Weapon
weaponattack(woodenspatula) :- random(1,101,X), woodenspatula(X).
weaponattack(metalspatula) :- random(1,101,X), metalspatula(X).
weaponattack(fryingpan) :- fryingpan.
woodenspatula(X) :- X =< 35,nl, write('Your attack missed!'),nl.
woodenspatula(X) :- X > 35,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
metalspatula(X) :- X =< 25,nl, write('Your attack missed!'),nl.
metalspatula(X) :- X > 25,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
fryingpan :- write('Its a direct hit!'),nl, enemy(Type,Name,Hp), Newhp is Hp-Hp, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).

%Battle
battle :- \+hp(die), enemy(_,_,Y), Y > 0, write('What will you do next? :'), read(Z), action(Z), battle; result.

action(attack) :- get_single_char(_),weapon(X), weaponattack(X),nl,battlestatus,nl, sneeze(no),enemy(_,Name,Hp), Hp > 0,get_single_char(_),random(1,101,Random), enemyattack(Name,Random),battlestatus,nl.
action(attack) :- sneeze(yes), enemy(_,Name,_),write(Name),write(' sneezed and missed its turn !'),nl,nl,retractall(sneeze(_)),assert(sneeze(no)).
action(attack) :- enemy(_,_,Hp), Hp =< 0,!.
action(potion) :- use(potion), nl,write('What will you do next? : '),read(X),action(X).
action(pepper) :- use(pepper), nl,write('What will you do next? : '),read(X),action(X).
action(blowtorch) :- use(blowtorch),nl, battlestatus,nl,enemy(_,_,Hp), Hp > 0, write('What will you do next? :'),read(X),action(X).
action(blowtorch) :- enemy(_,_,Hp), Hp =< 0,!.
action(_) :- write('Invalid action, please try again'), nl, write('What will you do next? : '),read(X) ,action(X).

result :- hp(die), write('You die'),retractall(enemy(_,_,_)),nl.
result :- random(1,101,X),enemy(_,Name,Hp), Hp =< 0, write('You defeated '), write(Name), write('! Good Job!'),nl ,retractall(enemy(_,_,_)),loot(X),nl,!.

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
	    
loot(X) :- X >= 5, X < 80, write('You have obtained potion!'), item(potion,X), NewX is X + 1, retractall(item(potion,_)), assert(item(potion,NewX)).
loot(_).

fightmeatball :- write('A wild meatball appears !'),assert(enemy(neutral,'Meatball',6)),nl,nl,battlestatus,nl, battle.
fighttarrot :- write('A wild tarrot appears !'),assert(enemy(neutral,'Tarrot',3)),nl,nl,battlestatus,nl,battle.
fightonion :- write('A crying onion appears ?'),assert(enemy(neutral,'Crying Onion',6)),nl,nl,battlestatus,nl,battle.
fightsalad :- write('A Caesar Salad appears !'), assert(enemy(neutral,'Caesar Salad',4)),nl,nl,battlestatus,nl,battle.

%For test purpose
give(fryingpan) :- retract(weapon(_)), assertz(weapon(fryingpan)).
give(metalspatula) :- retract(weapon(_)), assertz(weapon(metalspatula)).
