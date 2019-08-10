	start :- retractall(item(_,_)),retractall(weapon(_)),retractall(playerScore(_)),retractall(hp(_)),retractall(sneeze(_)),retractall(down(_)), retractall(stun(_)),retractall(npc(_,_)),retractall(playerstun(_)),retractall(playerloc(_)),retractall(complete(_)),
		 assert(hp(healthy)),assert(weapon('Wooden Spatula')),assert(npc('Helpful David', no)),assert(npc('Edythe The Kind',no)),assert(npc('Trader Terry',no)),
		 assert(item(potion,10)),
		 assert(item(blowtorch,3)),
		 assert(item(pepper,3)),
		 assert(item(mt,no)),
		 assert(item(co,no)),
		 assert(item(corkscrew,no)),
		 assert(down(1)),
		 assert(sneeze(no)),
		 assert(stun(no)),
		 assert(playerScore(0)),
		 assert(achievement(nothing)),
		 assert(playerstun(no)),
		 assert(playerloc(town)),
		 assert(complete(nothing)),
		 write('Starting of the story:'),get_single_char(_),nl,story,poster,nl,townhall.

	story :- achievestart,retract(achievement(nothing)),
		 write('This story follows the adventure of Clemen Wohlfahrt, an amazing chef from the land of Redfields.'), get_single_char(_),nl,
		 write('He was born with only one hand due to an accident at birth causing him a big disability in life and so on,but that did not stop him from achieving his dream at all.'), get_single_char(_),nl,
		 write('And there he goes, on his way to open a new restaurant in a place called Calamity Town...'),get_single_char(_),nl,
		 write('Breath in and breath out Clemen, you got this long journey ahead of you, said Clemen'),get_single_char(_),nl,
		 write('You will be controlling Mr. Clemen here and guide him through out this adventure...'),get_single_char(_),nl,
		 write('This... tasty adventure of his...'),get_single_char(_),nl.

	poster :- 
	write(' #######                                 #                                                                                #####                                     '),nl,
	write('    #      ##    ####  ##### #   #      # #   #####  #    # ###### #    # ##### #    # #####  ######     ####  ######    #     # #      ###### #    # ###### #    # '),nl,
	write('    #     #  #  #        #    # #      #   #  #    # #    # #      ##   #   #   #    # #    # #         #    # #         #       #      #      ##  ## #      ##   # '),nl,
	write('    #    #    #  ####    #     #      #     # #    # #    # #####  # #  #   #   #    # #    # #####     #    # #####     #       #      #####  # ## # #####  # #  # '),nl,
	write('    #    ######      #   #     #      ####### #    # #    # #      #  # #   #   #    # #####  #         #    # #         #       #      #      #    # #      #  # # '),nl,
	write('    #    #    # #    #   #     #      #     # #    #  #  #  #      #   ##   #   #    # #   #  #         #    # #         #     # #      #      #    # #      #   ## '),nl,
	write('    #    #    #  ####    #     #      #     # #####    ##   ###### #    #   #    ####  #    # ######     ####  #          #####  ###### ###### #    # ###### #    # '),get_single_char(_).

	%NPC
	interact(1) :- 	npc('Helpful David',no), write('Hello there traveler!!'), get_single_char(_),nl,write('My name is David, people around the town call me The Helpful One!'),get_single_char(_),nl,write('Talk me to if you need any advice!'),
			retract(npc('Helpful David',_)),assert(npc('Helpful David',yes)),nl,nl,location(int).
	interact(1) :- 	npc('Helpful David',yes), random(1,11,X), advice(X),nl,nl,location(int).
	interact(2) :- 	npc('Edythe The Kind',no),write('Hello young man.'),get_single_char(_),nl,write('I am just an old granny that is enjoying her old life.'),get_single_char(_),nl,
			write('Clemen says "She looks kind and very trustworthy, maybe I can ask for some help from her."'),get_single_char(_),nl,retract(npc('Edythe The Kind',_)),assert(npc('Edythe The Kind',yes)),nl,location(int).
	interact(2) :- 	npc('Edythe The Kind',yes),write('Clemen says "Dear Miss Edythe, can I ask for some help from you as I am having some trouble".'),get_single_char(_),write('Sure do dear, but what do you need?'),
			nl,write('1. Tomato Juice x3'),nl,write('2. Pepper x2'),nl,write('3. Blowtorch x1'),nl,read(X),additem(X),nl,nl,write('Good luck on your adventure sonny.'),nl,retract(npc('Edythe The Kind',_)), assert(npc('Edythe The Kind',help)),location(int).
	interact(2) :- npc('Edythe The Kind',help),write('Dear, I already helped you. Good luck on your adventure.'),nl,nl,location(int).
	interact(3) :- npc('Trader Terry', no),write('Welcome to my shop!! Are you here to buy my wares?'),nl,write('What do you mean you have no money?? I can see it right there!'),nl,
		       write('Player Score: '), playerScore(S), write(S),nl,write('Yes!! That right there I need that!'), retract(npc('Trader Terry',_)), assert(npc('Trader Terry',yes)),nl,nl,location(int).
	interact(3) :- npc('Trader Terry', yes), write('1. Tomato juice - 100 Score'),nl,write('2. Pepper - 150 Score'),nl,write('3. Blowtorch - 300 Score'),nl,playerScore(S), write('Currency: '),write(S),nl,
		       write('Your Choice: '),read(X), buy(X).
	
	buy(1) :- playerScore(S), S >= 100, NewS is S - 100, retract(playerScore(_)), assert(playerScore(NewS)), item(potion,X), NewX is X + 1, retract(item(potion,_)),assert(item(potion,NewX)), write('You received one potion! Now you have '),write(NewX),write(' potions!'),interact(3),nl.
	buy(2) :- playerScore(S), S >= 150, NewS is S - 150, retract(playerScore(_)), assert(playerScore(NewS)),item(pepper,X), NewX is X + 1, retract(item(pepper,_)),assert(item(pepper,NewX)), write('You received one pepper! Now you have '),write(NewX),write(' peppers!'),interact(3),nl.
	buy(3) :- playerScore(S), S >= 300, NewS is S - 300, retract(playerScore(_)), assert(playerScore(NewS)),item(blowtorch,X), NewX is X + 1, retract(item(blowtorch,_)),assert(item(blowtorch,NewX)), write('You received one blowtorch! Now you have '),write(NewX),write(' blowtorch!'),interact(3),nl.
	buy(5) :- write('Pleasure doing business with you!!'),nl, location(int).
	buy(_) :- write('Not enought currency for this!!'),nl,interact(3). 
	
	townhall :- nl,
		    write('          | N |          '),nl,
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
		    chooselocation,read(X),nl,location(X).

	chooselocation :- write('int   - Interact with NPC'),nl,
			  write('up    - Go to Violet Garden'),nl,
			  write('left  - Go to Icy Riverside'),nl,
			  write('right - Go to Fiery Hill'),nl,
			  write('Your choice : ').

	location(int) :- write('1. Helpful David'),nl,write('2. Edythe The Kind'),nl,write('3. Trader Terry'),nl,write('Please choose the options above by numbering: '),read(X),interact(X).
	location(up) :- complete(neutral), write('You have completed Violet Garden, choose another place!'),nl,nl,chooselocation,read(X),location(X).
	location(up) :- write('You choose Violet Garden, Good Luck'),nl,neutral.
	location(left) :- complete(ice), write('You have completed Icy Riverside, choose another place!'),nl,nl,chooselocation,read(X),location(X).
	location(left) :- write('You choose Icy Riverside, Good Luck'),nl,ice.
	location(right) :- complete(neutral),complete(ice),write('You choose fire faction, Good Luck'),nl,fire.
	location(right) :- write('You need to complete both Violet Garden and Icy Riverside to enter Fiery Hill'),nl,nl,chooselocation,read(X),location(X).
	location(down) :- down(1),write('I see what you try to do there, but there is no going back'),nl,retractall(down(_)),assert(down(2)),chooselocation,read(X),location(X).
	location(down) :- down(2),write('Are you really sure about that?? (yes/no) : '),read(X), ending1(X).
	location(_) :- write('Invalid Input, Please try again'),nl,nl,townhall.

	ending1(yes) :- fakeending.
	ending1(no) :- retractall(down(_)),assert(down(1)),chooselocation,read(X),location(X).
	ending1(_) :- write('Invalid Input, Please try again'),nl,write('Are you really sure about that?? (yes/no) : '),read(X), ending1(X).

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

	fakeending :- nl,achievedown,write('Clemen feels that he is not ready to do all this, so he decides to go back home and continue his miserable life'),nl,end.

	end :- achievement.

	%Neutral faction
	neutral :- retract(playerloc(_)),assert(playerloc(neutral)),event(30),fight(50).

	fight(X) :- playerloc(Place), X =< 50, random(1,5,Y),encounter(Y,Place).
	fight(_) :- playerloc(Place),nl, write('Boss fight time!'),bossfight(Place).

	encounter(1,neutral) :- fightmeatball.
	encounter(2,neutral) :- fighttarrot.
	encounter(3,neutral) :- fightonion.
	encounter(4,neutral) :- fightsalad.
	encounter(1,ice) :- fighticecube.
	encounter(2,ice) :- fightvanilla.
	encounter(3,ice) :- fightscope.
	encounter(4,ice) :- fightbanana.

	crossroad(left,1) :- write('You walked into a dangerous path full of spiky vines. You took one damage!'), deducthp.
	crossroad(right,1) :-  write('Walking on the pathway, you see something shiny on the ground, you found one HP potion!'), item(potion,X), NewX is X + 1, retractall(item(potion,_)), assert(item(potion,NewX)).
	crossroad(left,2) :-  write('Walking on the pathway, you see something shiny on the ground, you found one HP potion!'), item(potion,X), NewX is X + 1, retractall(item(potion,_)), assert(item(potion,NewX)).
	crossroad(right,2) :- write('You walked into a dangerous path full of spiky vines. You took one damage!'), deducthp.
	crossroad(_,Y) :- write('Please enter only left or right!'),nl,write('Your Choice : '), read(X), crossroad(X,Y).

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

	additem(1) :- item(potion,X), NewX is X + 3, retractall(item(potion,_)), assert(item(potion,NewX)), write('You have received 3 tomato juices!').
	additem(2) :- item(pepper,X), NewX is X + 1, retractall(item(pepper,_)), assert(item(pepper,NewX)), write('You have received 1 pepper!').
	additem(3) :- item(blowtorch,X), NewX is X + 1, retractall(item(blowtorch,_)), assert(item(blowtorch,NewX)), write('You have received 1 blowtorch!').
	additem(_) :- write('Granny cant seem to hear you... (Please enter only shown numbers)'),read(X),additem(X).

	%Monster
	enemyattack('Meatball',X) :- X > 40, write('Meatball attack!     Player hp - 1'), nl,nl, deducthp.
	enemyattack('Tarrot',X) :- X > 15,X =< 45, write('Tarrot card attack!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Tarrot',X) :- X > 45, write('Tarrot pull out its regen card !     Tarrot hp + 1'),nl,nl,enemy(Type,Name,Hp), Newhp is Hp + 1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	enemyattack('Crying Onion',X) :- X > 20, write('Crying Onion makes you sad!     Player hp - 1 from sadness'),nl,nl,deducthp.
	enemyattack('Caesar Salad', X) :- X > 60, write('Caesar Salad attacks!     Player hp - 2'),nl,nl,deducthp,deducthp.
	enemyattack('Spaghetti Regretti',_) :- round(X) ,X \= 4, write('Spaghetti Regretti attack!     Player hp - 1'),nl,nl,deducthp,retractall(round(_)), NewX is X + 1, assert(round(NewX)).
	enemyattack('Spaghetti Regretti',_) :- round(4), write('Spaghetti Regretti performs a double attack!     Player hp - 2'),nl,nl,deducthp,deducthp,retractall(round(_)), assert(round(1)).
	enemyattack('Ice Cube',X) :- X >= 39 ,X =< 59, write('Ice Cube slides towards you!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Ice Cube',X) :- X >= 60 ,X =< 80, write('Ice Cube freezes you this turn!     Player hp - 1'),retract(playerstun(_)),assert(playerstun(yes)),nl,nl,deducthp.
	enemyattack('Vanilla Shake', X) :- X =< 45 , X >= 25, write('Vanilla Shake dances all over you!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Vanilla Shake', X) :- X >= 46, X =< 66, write('Vanilla Shake freezes you!     Player hp - 1'),retract(playerstun(_)),assert(playerstun(yes)),nl,nl,deducthp.
	enemyattack('Triple Scope', X) :- X >= 50, X =< 70, write('Triple Scope snipes you!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Triple Scope', X) :- X >= 71, X =< 91, write('Triple Scope headshots you!     Player hp - 2'),nl,nl,deducthp,deducthp.
	enemyattack('Banana Skit', X) :- X >= 60, X =< 80, write('Banana Skit throws his cream at you!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Banana Skit', X) :- X >= 39, X =< 59, write('Banana Skit tells you a joke and you laughed!     Player hp - 1'),retract(playerstun(_)),assert(playerstun(yes)),nl,nl,deducthp.
		
	enemyattack(_,_) :- enemy(_,Name,_),write('You managed to dodge '),write(Name),write(' attack'),nl,nl. 

	%Weapon
	weaponattack('Wooden Spatula') :- random(1,101,X), woodenspatula(X).
	weaponattack('Metal Spatula') :- random(1,101,X), metalspatula(X).
	weaponattack('Ice Cream Scoop') :- random(1,101,X), icecreamscoop(X).
	weaponattack('Frying Pan') :- enemy(Type,_,_), random(1,101,X),fryingpan(Type,X).
	woodenspatula(X) :- X =< 35,nl, write('Your attack missed!'),nl.
	woodenspatula(X) :- X > 35,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	metalspatula(X) :- X =< 25,nl, write('Your attack missed!'),nl.
	metalspatula(X) :- X > 25,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	icecreamscoop(X) :- X > 25, enemy(ice,_,_),nl,write('Its super effective! 2 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	icecreamscoop(X) :- metalspatula(X).
	fryingpan(boss,X) :- X =< 30,nl,write('Its a direct hit!'),nl, enemy(Type,Name,Hp), Newhp is Hp-2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)),retract(stun(_)),assert(stun(yes)),write('You have stunned the enemy'),nl.
	fryingpan(boss,X) :- X > 30,nl, write('Its a direct hit!'),nl, enemy(Type,Name,Hp), Newhp is Hp-2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	fryingpan(X,_) :- X \= boss, write('Its a direct hit!'),nl, enemy(Type,Name,Hp), Newhp is Hp-Hp, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).

	%Battle
	battle :- \+hp(die), enemy(_,_,Y), Y > 0, chooseaction, read(Z), action(Z), battle.
	battle :- result.

	fightmeatball :- write('A wild meatball appears !'),assert(enemy(neutral,'Meatball',6)),nl,nl,battlestatus,nl, battle.
	fighttarrot :- write('A wild tarrot appears !'),assert(enemy(neutral,'Tarrot',3)),nl,nl,battlestatus,nl,battle.
	fightonion :- write('A crying onion appears ?'),assert(enemy(neutral,'Crying Onion',6)),nl,nl,battlestatus,nl,battle.
	fightsalad :- write('A Caesar Salad appears !'), assert(enemy(neutral,'Caesar Salad',4)),nl,nl,battlestatus,nl,battle.
	bossfight(neutral) :- write('Spaghetti Regretti appears !'), assert(round(1)), assert(enemy(boss,'Spaghetti Regretti',15)),nl,nl,battlestatus,nl,battle.
	fighticecube :- write('A Ice Cube appears !'), assert(enemy(ice,'Ice Cube', 3)),nl,nl,battlestatus,nl,battle.
	fightvanilla :- write('A Vanilla Shake appears !'),nl,write('It seems ready to have a dance off against you!'), assert(enemy(ice,'Vanilla Shake', 5)),nl,nl,battle.
	fightscope :- write('A Triple Scope is taking aim on you!'),assert(enemy(ice,'Triple Scope', 3)),nl,nl,battle.
	fightbanana :- write('A Banana Skit appears !'),nl,write('Clemen thought to himself "That is a funny looking banana split."'),assert(enemy(ice,'Banana Skit', 5)),nl,nl,battle.

	chooseaction :- write('i - view your items'),nl,
			write('a - use your weapon to attack enemy'),nl,
			write('t - use tomato juice'),nl,
			write('b - use blowtorch'),nl,
			write('p - use pepper'),nl,
			write('Your Choice : ').

	action(i) :- itemList,nl,chooseaction,read(X),action(X).
	action(a) :- playerstun(no),get_single_char(_),weapon(X), weaponattack(X),nl,battlestatus,nl,sneeze(no),stun(no),enemy(_,Name,Hp), Hp > 0,get_single_char(_),random(1,101,Random), enemyattack(Name,Random),battlestatus,nl.
	action(a) :- enemy(_,_,Hp), Hp =< 0,!.
	action(a) :- get_single_char(_),playerstun(yes),nl,write('You missed your turn...'),nl,retract(playerstun(_)),assert(playerstun(no)), enemy(_,Name,Hp), Hp > 0, get_single_char(_), random(1,101,Random),enemyattack(Name,Random),battlestatus,nl.
	action(a) :- sneeze(yes),enemy(_,Name,_),write(Name),write(' sneezed and missed its turn !'),nl,nl,retractall(sneeze(_)),assert(sneeze(no)).
	action(a) :- stun(yes),enemy(_,Name,_),write(Name),write(' is stunned and missed its turn !'),nl,nl,retractall(stun(_)),assert(stun(no)).
	action(t) :- get_single_char(_),playerstun(yes),nl,write('You missed your turn...'),nl,retract(playerstun(_)),assert(playerstun(no)), enemy(_,Name,Hp), Hp > 0, get_single_char(_), random(1,101,Random),enemyattack(Name,Random),battlestatus,nl.
	action(t) :- use(potion), nl,chooseaction,read(X),action(X).
	action(p) :- get_single_char(_),playerstun(yes),nl,write('You missed your turn...'),nl,retract(playerstun(_)),assert(playerstun(no)), enemy(_,Name,Hp), Hp > 0, get_single_char(_), random(1,101,Random),enemyattack(Name,Random),battlestatus,nl.
	action(p) :- use(pepper), nl,chooseaction,read(X),action(X).
	action(b) :- get_single_char(_),playerstun(yes),nl,write('You missed your turn...'),nl,retract(playerstun(_)),assert(playerstun(no)), enemy(_,Name,Hp), Hp > 0, get_single_char(_), random(1,101,Random),enemyattack(Name,Random),battlestatus,nl.
	action(b) :- use(blowtorch),nl, battlestatus,nl,enemy(_,_,Hp), Hp > 0, chooseaction,read(X),action(X).
	action(b) :- enemy(_,_,Hp), Hp =< 0,!.
	action(_) :- write('Invalid action, please try again'), nl, chooseaction,read(X) ,action(X).

	result :- hp(die), write('You die'),retractall(enemy(_,_,_)),nl,gameover.
	result :- enemy(_,'Spaghetti Regretti',X), X =< 0, write('You defeated Spaghetti Regretti !  Stage clear !'),nl,nl,scrore(boss),retractall(enemy(_,_,_)),assert(complete(neutral)),retract(playerloc(_)),assert(playerloc(town)).
	result :- enemy(Type,Name,Hp), Hp =< 0, write('You defeated '), write(Name), write('! Good Job!'),nl,nl, random(1,101,X),loot(X),nl,score(Type),retractall(enemy(_,_,_)),nl,random(1,101,Y),fight(Y),!.

	%Utility
	itemList :- nl,weapon(X), write('Weapon : '),write(X),nl,
		    (item(potion,Y),Y > 0, write('Tomato juice   x '),write(Y),nl;!),
		    (item(blowtorch,Z),Z > 0, write('Blowtorch   x '),write(Z),nl;!),
		    (item(pepper,A),A > 0, write('Pepper   x '),write(A),nl;!),
		    (item(mt,yes), write('Meat Tenderizer'),nl;!),
		    (item(co,yes), write('Can Opener'),nl;!),
		    (item(corkscrew,yes), write('Corkscrew'),nl;!),!.

	loot(X) :- X >= 5, X < 80, write('You have obtained potion!'), item(potion,Y), NewY is Y +1, retractall(item(potion,_)), assert(item(potion,NewY)).
	loot(_).

	advice(1) :- write('Did you know? Tomato juice heals your hp full!').
	advice(2) :- write('Edythe will sometimes provide you supplies! You should pay a visit to the old lady often.').
	advice(3) :- write('There are three areas you can explore to gather ingredients which is Violent Garden, Fiery Hill and Icy River!'),nl,write('The other areas are restricted due to its dangerous surroundings for now..').
	advice(4) :- write('Did you know if your HP drops to "die", you actually die?'),achieveuseless.
	advice(5) :- get_single_char(_),write('You have 5 states of HP, make sure to keep track of your HP or else you might lose!'),get_single_char(_),write('..... Oh wait, I mean die not lose. This is not a game after all').
	advice(6) :- write('You gain score everytime you defeat an enemy and extra for bosses, but everytime you heal you lose points! (There is an achievement for this teehee)').
	advice(7) :- write('Use pepper to avoid getting hit for one round!').
	advice(8) :- write('You have limited resources! Make sure to make full use for them!').
	advice(9) :- write('I like me some steak!').
	advice(10) :- write('I am running out of scripts to help you, please stop asking me for help.'),achievelazywriting.

	score(neutral) :- playerScore(S), X is 100, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 100 score!!'),nl,nl,scorestatus.
	score(ice) :- playerScore(S), X is 150, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 150 score!!'),nl,nl,scorestatus.
	score(fire) :- playerScore(S), X is 200, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 200 score!!'),nl,nl,scorestatus.
	score(boss) :- playerScore(S), X is 500, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 500 score!!'),nl,nl,scorestatus.
	scorestatus :- hp(X), write('Player Hp : '),write(X),nl,
		       playerScore(Y), write('Player Score : '), write(Y),nl.


	event(X) :- X > 10, X =< 30, write('There is a crossroad left and right, a signboard is found there.'),nl,random(1,3,R),write('Your choice: '),read(D),crossroad(D,R).
	event(_) :- write('You continued your journey without any interesting events happening...').

	%achievement
	achievestart :- \+achievement('You did it!!'), assert(achievement('You did it!!')),write('You unlocked an achievement : You did it!!'),nl,nl;!.
	achievedown :- \+achievement('Not ready for adventure...'), assert(achievement('Not ready for adventure...')),write('You unlocked an achievement : Not ready for adventure...'),nl,nl;!.
	achieveuseless :- \+achievement('Not so useful now!!'), assert(achievement('Not so useful now!!')),nl, write('You unlocked an achievement : Not so useful now!!');!.
	achievelazywriting :- \+achievement('Lazy writing'), assert(achievement('Lazy writing')),nl, write('You unlocked an achievement : Lazy writing');!.

	achievement :- findall(X,achievement(X),List), nl,write('Achievements obtained :'),nl,printachieve(List).

	printachieve([]).
	printachieve([H|T]) :- write(H),nl,printachieve(T).

	%For test purpose
	give(fryingpan) :- retract(weapon(_)), assertz(weapon('Frying Pan')).
	give(metalspatula) :- retract(weapon(_)), assertz(weapon('Metal Spatula')).
	give(icecreamscoop) :- retract(weapon(_)), assertz(weapon('Ice Cream Scoop')).
