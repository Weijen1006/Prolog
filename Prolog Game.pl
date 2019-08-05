start :- retractall(item(_,_)),retractall(weapon(_)),retractall(playerScore(_)),retractall(hp(_)),retractall(sneeze(_)),
	 assert(hp(healthy)),assert(weapon('Wooden Spatula')),
	 assert(item(potion,5)),
	 assert(item(blowtorch,3)),
	 assert(item(pepper,3)),
	 assert(item(mt,no)),
	 assert(item(co,no)),
	 assert(item(corkscrew,no)),
	 assert(sneeze(no)),
	 assert(playerScore(0)),
	 write('Starting of the story:'),get_single_char(_),nl,story,poster,nl,town.

story :- write('This story follows the adventure of Clemen Wohlfahrt, an amazing chef from the land of Redfields.'), get_single_char(_),nl,
	 write('He was born with only one hand due to an accident at birth causing him a big disability in life and so on,but that did not stop him from achieving his dream at all.'), get_single_char(_),nl,
	 write('And there he goes, on his way to open a new restaurant in a place called Calamity Town...'),get_single_char(_),nl,
	 write('Breath in and breath out Clemen, you got this long journey ahead of you, said Clemen'),get_single_char(_),nl,
	 write('You will be controlling Mr. Clemen here and guide him through out this adventure...'),get_single_char(_),nl,
	 write('This... tasty adventure of his...'),get_single_char(_),nl.

poster :- 
write('*********    *****    ******** ********* *****     *****'),nl,
write('*       *   *     *   *      * *       *  *   *   *   *'),nl,
write('***   ***  *  ***  *  *  ***** ***   ***   *    *    *'),nl,
write('  *   *   *         * ****** *   *   *      *      *'),nl,
write('  *   *   *   ***   * ****** *   *   *      *      *'),nl,
write('  *   *   *  *   *  * *      *   *   *      *      *'),nl,
write('  *****    **     **  ********   *****      ********').

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

gameover :- nl,
write('    ******   ***   **   ** *******          ******  **   ** ******* ******  '),nl,
write('   *      * *   * *  * *  *       *        *      **  * *  *       *      * '),nl,
write('  *  ***** *     **   *   *  *****        *  ****  *  * *  *  ******  ***  *'),nl,    
write(' *  *  ****   *   *       *  ***          *  *  *  *  * *  *  ***  *  * *  *'),nl,
write(' *  * *   *  ***  *  * *  *     *         *  *  *  *   *   *     * *  **   *'),nl,
write(' *  *  *  *       *  ***  *  ***          *  *  *  **     **  ***  *     ** '),nl,
write('  *  ***  *  ***  *  * *  *  *****        *  ****  * *   * *  ******  *   * '),nl,
write('   *      *  * *  *  * *  *       *        *      *   * *  *       *  **   *'),nl,
write('    ****** **   ** **   ** *******          ******     *    ******* **  *** '),nl,!.

theend :- nl.

%Neutral faction
neutral :- fight(30).

fight(X) :- X =< 30, random(1,5,Y),encounter(Y).
fight(_) :- random(1,31,X), event(X),nl, write('Boss fight time!'),neutralbossfight.

encounter(1) :- fightmeatball.
encounter(2) :- fighttarrot.
encounter(3) :- fightonion.
encounter(4) :- fightsalad.

crossroad(left) :- write('You walked into a dangerous path full of spiky vines. You took one damage!'), deducthp.
crossroad(right) :-  write('Walking on the pathway, you see something shiny on the ground, you found one HP potion!'), item(potion,X), NewX is X + 1, retractall(item(potion,_)), assert(item(potion,NewX)).
crossroad(_) :- write('Please enter only left and right!'), read(X), crossroad(X).

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
deducthp :- hp(die),!.

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
enemyattack('Tarrot',X) :- X > 15,X =< 45, write('Tarrot card attack! Player hp - 1'),nl,nl,deducthp.
enemyattack('Tarrot',X) :- X > 45, write('Tarrot pull out its regen card ! Tarrot hp + 1'),nl,nl,enemy(Type,Name,Hp), Newhp is Hp + 1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
enemyattack('Crying Onion',X) :- X> 20, write('Crying Onion makes you sad! Player hp - 1 from sadness'),nl,nl,deducthp.
enemyattack('Caesar Salad', X) :- X > 60, write('Caesar Salad attacks! Player hp - 2'),nl,nl,deducthp,deducthp.
enemyattack('Spaghetti Regretti',_) :- round(X) ,X \= 4, write('Spaghetti Regretti attack! Player hp - 1'),nl,nl,deducthp,retractall(round(_)), NewX is X + 1, assert(round(NewX)).
enemyattack('Spaghetti Regretti',_) :- round(4), write('Spaghetti Regretti perform a double attack! Player hp - 2'),nl,nl,deducthp,deducthp,retractall(round(_)), assert(round(1)).
enemyattack(_,_) :- enemy(_,Name,_),write('You managed to dodge '),write(Name),write(' attack'),nl,nl. 

%Weapon
weaponattack('Wooden Spatula') :- random(1,101,X), woodenspatula(X).
weaponattack('Metal Spatula') :- random(1,101,X), metalspatula(X).
weaponattack('Frying Pan') :- fryingpan.
woodenspatula(X) :- X =< 35,nl, write('Your attack missed!'),nl.
woodenspatula(X) :- X > 35,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
metalspatula(X) :- X =< 25,nl, write('Your attack missed!'),nl.
metalspatula(X) :- X > 25,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
fryingpan :- write('Its a direct hit!'),nl, enemy(Type,Name,Hp), Newhp is Hp-Hp, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).

%Battle
battle :- \+hp(die), enemy(_,_,Y), Y > 0, write('What will you do next? :'), read(Z), action(Z), battle.
battle :- result.

fightmeatball :- write('A wild meatball appears !'),assert(enemy(neutral,'Meatball',6)),nl,nl,battlestatus,nl, battle.
fighttarrot :- write('A wild tarrot appears !'),assert(enemy(neutral,'Tarrot',3)),nl,nl,battlestatus,nl,battle.
fightonion :- write('A crying onion appears ?'),assert(enemy(neutral,'Crying Onion',6)),nl,nl,battlestatus,nl,battle.
fightsalad :- write('A Caesar Salad appears !'), assert(enemy(neutral,'Caesar Salad',4)),nl,nl,battlestatus,nl,battle.
neutralbossfight :- write('Spaghetti Regretti appears !'), assert(round(1)), assert(enemy(neutral,'Spaghetti Regretti',15)),nl,nl,battlestatus,nl,battle.


action(attack) :- get_single_char(_),weapon(X), weaponattack(X),nl,battlestatus,nl, sneeze(no),enemy(_,Name,Hp), Hp > 0,get_single_char(_),random(1,101,Random), enemyattack(Name,Random),battlestatus,nl.
action(attack) :- sneeze(yes), enemy(_,Name,_),write(Name),write(' sneezed and missed its turn !'),nl,nl,retractall(sneeze(_)),assert(sneeze(no)).
action(attack) :- enemy(_,_,Hp), Hp =< 0,!.
action(potion) :- use(potion), nl,write('What will you do next? : '),read(X),action(X).
action(pepper) :- use(pepper), nl,write('What will you do next? : '),read(X),action(X).
action(blowtorch) :- use(blowtorch),nl, battlestatus,nl,enemy(_,_,Hp), Hp > 0, write('What will you do next? :'),read(X),action(X).
action(blowtorch) :- enemy(_,_,Hp), Hp =< 0,!.
action(_) :- write('Invalid action, please try again'), nl, write('What will you do next? : '),read(X) ,action(X).

result :- hp(die), write('You die'),retractall(enemy(_,_,_)),nl,gameover.
result :- enemy(_,'Spaghetti Regretti',X), X =< 0, write('You defeated Spaghetti Regretti !  Stage clear !'),nl,nl,retractall(enemy(_,_,_)).
result :- enemy(Type,Name,Hp), Hp =< 0, write('You defeated '), write(Name), write('! Good Job!'),nl,nl, random(1,101,X),loot(X),nl,score(Type),retractall(enemy(_,_,_)),nl,random(1,101,Y),fight(Y),!.

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
	    
loot(X) :- X >= 5, X < 80, write('You have obtained potion!'), item(potion,Y), NewY is Y +1, retractall(item(potion,_)), assert(item(potion,NewY)).
loot(_).
 

score(neutral) :- playerScore(S), X is 100, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 100 score!!'),nl,nl,scorestatus.
score(ice).
score(fire).

scorestatus :- hp(X), write('Player Hp : '),write(X),nl,
	       playerScore(Y), write('Player Score : '), write(Y),nl.


event(X) :- X > 10, X =< 30, write('There is a crossroad left and right, a signboard is found there.'),nl,write('Your choice: '),read(D),crossroad(D).
event(_) :- write('You continued your journey without any interesting events happening...').


%For test purpose
give(fryingpan) :- retract(weapon(_)), assertz(weapon('Frying Pan')).
give(metalspatula) :- retract(weapon(_)), assertz(weapon('Metal Spatula')).
