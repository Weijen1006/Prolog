	menu :- poster,nl,nl,write('Type anything to continue.....'),get_single_char(_),nl,nl,start.
	
	start :- retractall(item(_,_)),retractall(weapon(_)),retractall(playerScore(_)),retractall(hp(_)),retractall(sneeze(_)),retractall(down(_)), retractall(stun(_)),retractall(npc(_,_)),retractall(playerstun(_)),retractall(playerloc(_)),retractall(complete(_)),retractall(burn(_)),retractall(stage(_)),retractall(round(_)),
		 assert(hp(healthy)),assert(weapon('Ice Cream Scoop')),assert(npc('Helpful David', no)),assert(npc('Edythe The Kind',no)),assert(npc('Trader Terry',no)),
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
		 assert(burn(no)),
		 assert(stage(1)),
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
	
	endingpost :-
	write('	#######                                                                                                          '),nl,
	write('    #    #    #   ##   #    # #    #  ####     ######  ####  #####     #####  #        ##   #   # # #    #  ####  '),nl,
	write('    #    #    #  #  #  ##   # #   #  #         #      #    # #    #    #    # #       #  #   # #  # ##   # #    # '),nl,
	write('    #    ###### #    # # #  # ####    ####     #####  #    # #    #    #    # #      #    #   #   # # #  # #      '),nl,
	write('    #    #    # ###### #  # # #  #        #    #      #    # #####     #####  #      ######   #   # #  # # #  ### '),nl,
	write('    #    #    # #    # #   ## #   #  #    #    #      #    # #   #     #      #      #    #   #   # #   ## #    # '),nl,
	write('    #    #    # #    # #    # #    #  ####     #       ####  #    #    #      ###### #    #   #   # #    #  ####  '),nl.

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
	interact(3) :- npc('Trader Terry', yes), write('1. Tomato juice - 50 Score'),nl,write('2. Pepper - 150 Score'),nl,write('3. Blowtorch - 300 Score'),nl,write('4. Metal Spatula'),nl,write('5. Exit shop'),nl,playerScore(S), write('Currency: '),write(S),nl,
		       write('Your Choice: '),read(X), buy(X).
	interact(_) :- townhall.
	
	buy(1) :- playerScore(S), S >= 50, NewS is S - 50, retract(playerScore(_)), assert(playerScore(NewS)), item(potion,X), NewX is X + 1, retract(item(potion,_)),assert(item(potion,NewX)), write('You received one potion! Now you have '),write(NewX),write(' potions!'),nl,interact(3).
	buy(2) :- playerScore(S), S >= 150, NewS is S - 150, retract(playerScore(_)), assert(playerScore(NewS)),item(pepper,X), NewX is X + 1, retract(item(pepper,_)),assert(item(pepper,NewX)), write('You received one pepper! Now you have '),write(NewX),write(' peppers!'),nl,interact(3).
	buy(3) :- playerScore(S), S >= 300, NewS is S - 300, retract(playerScore(_)), assert(playerScore(NewS)),item(blowtorch,X), NewX is X + 1, retract(item(blowtorch,_)),assert(item(blowtorch,NewX)), write('You received one blowtorch! Now you have '),write(NewX),write(' blowtorch!'),nl,interact(3).
	buy(4) :- playerScore(S), S >= 500, NewS is S - 500, retract(playerScore(_)), assert(playerScore(NewS)),retractall(weapon(_)),assert(weapon('Metal Spatula')), write('You received a new weapon! '),nl,interact(3).
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

	location(int) :- write('1. Helpful David'),nl,write('2. Edythe The Kind'),nl,write('3. Trader Terry'),nl,write('Type anything else to go back to menu'),nl,write('Please choose the options above by numbering: '),read(X),interact(X).
	location(up) :- complete(neutral), write('You have completed Violet Garden, choose another place!'),nl,nl,chooselocation,read(X),location(X).
	location(up) :- write('You choose Violet Garden, Good Luck'),nl,neutral.
	location(left) :- complete(ice), write('You have completed Icy Riverside, choose another place!'),nl,nl,chooselocation,read(X),location(X).
	location(left) :- write('You choose Icy Riverside, Good Luck'),nl,ice.
	location(right) :- complete(neutral),complete(ice),write('You choose fire faction, Good Luck'),nl,fire.
	location(right) :- write('You need to complete both Violet Garden and Icy Riverside to enter Fiery Hill'),nl,nl,chooselocation,read(X),location(X).
	location(down) :- down(1),write('I see what you try to do there, but there is no going back'),nl,retractall(down(_)),assert(down(2)),chooselocation,read(X),location(X).
	location(down) :- down(2),write('Are you really sure about that?? (yes/no) : '),read(X), ending1(X).
	location(_) :- write('Invalid Input, Please try again'),nl,nl,townhall.

	ending :- write('You defeated all three areas!! Congratulations!!'),nl,write('Now Clemen has received all the ingredients from those three areas and can now cook amazing dishes to proof everyone in the town he is an awesome chef!'),nl,write('As time went on, Clemen open up a restaurant called Clementouille!!'),nl,nl,endingpost.
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

	%Mini Game
	minigame(ice) :- get_single_char(_),write('As you enter the Icy Riverside, you see a mystery man in black cloak and he noticed you'),get_single_char(_),nl,
			 write('Hello young man, do you want to play a game with me? the reward is something very helpful in this area (evil smile)'),nl,
			 write('Your choice (yes/no) : '), read(X),playgame(X).
	minigame(fire) :- get_single_char(_),write('As you enter the Fiery Hill, you see the mystery man in black cloak again'),get_single_char(_),nl,
			 write('Hello young man, here we meet again, do you want to play a game with me? the reward is something very helpful in this area (evil smile)'),nl,
			 write('Your choice (yes/no) : '), read(X),playgame(X).

	playgame(yes) :- nl,write('I see, you are a man of culture as well, let us begin!'),nl,
			 write('There are 4 fortune cookies here, pick one and test your fortune !'),nl,
			 write('Your Choice  (1-4) : '),read(X),random(1,5,Y), fortune(X,Y).
	playgame(no) :- get_single_char(_),nl, write('Ohh... too bad then, we shall meet again next time'),nl, get_single_char(_),
			write('The mystery man disappear !'),nl,get_single_char(_).
	playgame(_) :- nl,write('Mystery Man : I dont understand you, please tell me your choice again'),nl,
		       write('Your choice (yes/no) : '), read(X),playgame(X).
	
	fortune(X,Y) :- playerloc(ice), X == Y, nl,write('You just got the fortune cookie correcty, its a Ice Cream Scoop in there!!!'),nl, 
			weapon(Weapon),write('Do you want to pick up and replace your '),write(Weapon),write('?'),nl,write('Your choice (yes/no) : '),read(Z),changeweapon(Z,'Ice Cream Scoop').
	fortune(X,Y) :- playerloc(fire), X == Y, nl,write('You just got the fortune cookie correcty, its a pair of Chopsticks in there!!!'),nl, 
			weapon(Weapon),write('Do you want to pick up and replace your '),write(Weapon),write('?'),nl,write('Your choice (yes/no) : '),read(Z),changeweapon(Z,'Chopsticks').
	fortune(X,Y) :- X \= Y,nl, write('You got the fortune cookie wrong, it exploded!    Player hp-2'),nl,deducthp,deducthp.
	
	%Neutral faction
	neutral :- retract(playerloc(_)),assert(playerloc(neutral)),nl,write('Section 1-1: Event 1'),nl,nl,random(1,101,X),event(X),nl,write('Section 1-2: Event 2'),nl,random(1,101,Y),event(Y),nl,write('Section 1-3: Lootbox'),chest(can),nl,write('You have entered a hostile zone! Get ready for battle!'),get_single_char(_),nl,fight(50).

	%Ice faction
	ice :- retract(playerloc(_)), assert(playerloc(ice)),minigame(ice),write('Section 2-1: Event 1'),nl,nl,random(1,101,X),event(X),nl,write('Section 2-2: Event 2'),nl,random(1,101,Y),event(Y),nl,write('Section 2-3: Lootbox'),chest(crabshell),nl,write('You have entered a hostile zone! Get ready for battle!'),get_single_char(_),fight(50).

	%Fire faction
	fire :- retract(playerloc(_)), assert(playerloc(fire)),minigame(fire),write('Section 3-1: Event 1'),nl,nl,random(1,101,X),event(X),nl,write('Section 3-2: Event 2'),nl,random(1,101,Y),event(Y),nl,write('Section 3-3: Lootbox'),chest(wine),nl,write('You have entered a hostile zone! Get ready for battle!'),get_single_char(_),fight(50).

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
	use(blowtorch) :- enemy(ice,_,_),item(blowtorch,X), X > 0, NewX is X - 1, retractall(item(blowtorch,_)), assert(item(blowtorch,NewX)),
			  enemy(Type,Name,Hp), Newhp is Hp - 3, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)),nl,
			  write('You used blowtorch on the enemy, 3 damage dealt !'),nl,write(NewX),write(' blowtorch left'),nl.
	use(blowtorch) :- enemy(boss,'Frozen Tuna',_),item(blowtorch,X), X > 0, NewX is X - 1, retractall(item(blowtorch,_)), assert(item(blowtorch,NewX)),
			  enemy(Type,Name,Hp), Newhp is Hp - 3, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)),nl,
			  write('You used blowtorch on the enemy, 3 damage dealt !'),nl,write(NewX),write(' blowtorch left'),nl.
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
	
	%Ice Area
	enemyattack('Ice Cube',X) :- X >= 39 ,X =< 59, write('Ice Cube slides towards you!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Ice Cube',X) :- X >= 60 ,X =< 80, write('Ice Cube freezes you this turn!     Player hp - 1'),retract(playerstun(_)),assert(playerstun(yes)),nl,nl,deducthp.
	enemyattack('Vanilla Shake', X) :- X =< 45 , X >= 25, write('Vanilla Shake dances all over you!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Vanilla Shake', X) :- X >= 46, X =< 66, write('Vanilla Shake freezes you!     Player hp - 1'),retract(playerstun(_)),assert(playerstun(yes)),nl,nl,deducthp.
	enemyattack('Triple Scope', X) :- X >= 50, X =< 70, write('Triple Scope snipes you!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Triple Scope', X) :- X >= 71, X =< 91, write('Triple Scope headshots you!     Player hp - 2'),nl,nl,deducthp,deducthp.
	enemyattack('Banana Skit', X) :- X >= 60, X =< 80, write('Banana Skit throws his cream at you!     Player hp - 1'),nl,nl,deducthp.
	enemyattack('Banana Skit', X) :- X >= 39, X =< 59, write('Banana Skit tells you a joke and you laughed!     Player hp - 1'),retract(playerstun(_)),assert(playerstun(yes)),nl,nl,deducthp.
	enemyattack('Frozen Tuna', X) :- round(Y), Y = 3, X >= 0, X =< 79, write('Frozen Tuna slaps you!     Player hp - 2'),nl,nl, deducthp, deducthp, retract(round(_)), assert(round(1)). 
	enemyattack('Frozen Tuna', X) :- round(Y), Y = 3, X >= 80, X =< 100, write('Frozen Tuna spits frozen water at you!     Player hp - 2'),nl,nl,deducthp,deducthp,retract(playerstun(_)),assert(playerstun(yes)), retract(round(_)), assert(round(1)).
	enemyattack('Frozen Tuna', _) :- round(Y), NewY is Y + 1, retract(round(_)), assert(round(NewY)), write('Frozen Tuna is getting ready to attack!'),nl.
	
	%Fire Area
	enemyattack('Pomegrenade',_) :- round(Y), Y = 4, write('Pomegrenade exploded and killed you!'),retract(hp(_)),assert(hp(die)).
	enemyattack('Pomegrenade',_) :- round(Y), Y = 3, write('Pomegrenade is going explode next round!').
	enemyattack('Pomegrenade',_) :- round(Y), NewY is Y + 1, write('Pomegrenade is getting ready to explode!'), retract(round(_)),assert(round(NewY)).
	enemyattack('Stupendous Soup', X) :- X > 80, X =< 100, write('Stupendous Soup spills hot soup at you!'),nl,write('It tastes impressive but it is too hot and it burned you!     Player hp - 1'),retract(burn(_)),assert(burn(yes)),nl,nl,deducthp.
	enemyattack('Stupendous Soup', X) :- X > 40, X =< 80, write('Stupendous Soup hits you with his spoon!    Player hp - 1'),nl,nl,deducthp.
	enemyattack('Pineapple Pizza', X) :- X > 20, X =< 100, write('Pineapple Pizza shoots hot melted cheese on you! '),nl,write('It burns your skin!     Player hp - 1'),nl,nl,retract(burn(_)),assert(burn(yes)),deducthp.
	enemyattack('Pineapple Pizza', X) :- X >= 0, X =< 20,write('Pineapple Pizza flung itself at you!    Player hp - 1'),nl,nl,deducthp.
	enemyattack('French Flies', X) :- X > 40, X =< 80, write('A Swarm of French Flies charged you!    Player hp - 1'),nl,nl,deducthp.
	enemyattack('Dai Bao', X) :- X > 30, X =< 100, write('Dai Bao slams on you!     Player hp - 1'),nl,nl,deducthp.
		
		
	enemyattack(_,_) :- enemy(_,Name,_),write('You managed to dodge '),write(Name),write(' attack'),nl,nl. 

	%Weapon
	weaponattack('Wooden Spatula') :- random(1,101,X), woodenspatula(X).
	weaponattack('Metal Spatula') :- random(1,101,X), metalspatula(X).
	weaponattack('Ice Cream Scoop') :- random(1,101,X), icecreamscoop(X).
	weaponattack('Chopstick') :- random(1,101,X), chopstick(X).
	weaponattack('Frying Pan') :- enemy(Type,_,_), random(1,101,X),fryingpan(Type,X).
	woodenspatula(X) :- X =< 35,nl, write('Your attack missed!'),nl.
	woodenspatula(X) :- X > 35,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	metalspatula(X) :- X =< 25,nl, write('Your attack missed!'),nl.
	metalspatula(X) :- X > 25,nl, write('Its a direct hit! 1 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-1, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	icecreamscoop(X) :- X > 25, enemy(ice,_,_),nl,write('Its super effective! 2 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	icecreamscoop(X) :- \+enemy(ice,_,_),metalspatula(X).
	chopstick(X) :- X > 25, enemy(fire,_,_), nl, write('Its super effective! 2 damage dealt'),nl, enemy(Type,Name,Hp), Newhp is Hp-2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	chopstick(X) :- X > 25, enemy(boss,'Dai Bao',_), nl, write('Its super effective! 3 damage dealt'), nl, enemy(Type,Name,Hp), Newhp is Hp - 3, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	chopstick(X) :- \+enemy(fire,_,_),metalspatula(X).
	fryingpan(boss,X) :- X =< 30,nl,write('Its a direct hit!'),nl, enemy(Type,Name,Hp), Newhp is Hp-2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)),retract(stun(_)),assert(stun(yes)),write('You have stunned the enemy'),nl.
	fryingpan(boss,X) :- X > 30,nl, write('Its a direct hit!'),nl, enemy(Type,Name,Hp), Newhp is Hp-2, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).
	fryingpan(X,_) :- X \= boss, write('Its a direct hit!'),nl, enemy(Type,Name,Hp), Newhp is Hp-Hp, retractall(enemy(_,_,_)), assert(enemy(Type,Name,Newhp)).

	changeweapon(yes,X) :- nl,write('You are now holding '),write(X),give(X).
	changeweapon(no,X) :- nl,write('You ignore the '),write(X).
	changeweapon(_,X) :- nl,write('Invalid Input, Please try again'),nl,write('Your choice (yes/no) : '),read(Y),changeweapon(Y,X),nl.

	%Battle
	battle :- \+hp(die), enemy(_,_,Y), Y > 0, chooseaction, read(Z), action(Z), battle.
	battle :- (hp(die);enemy(_,_,Y), Y =< 0),result.

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
	encounter(1,fire) :- fightpome.
	encounter(2,fire) :- fightsoup.
	encounter(3,fire) :- fightfrench.
	encounter(4,fire) :- fightpizza.

	fightmeatball :- write('A wild meatball appears !'),assert(enemy(neutral,'Meatball',6)),nl,nl,battlestatus,nl, battle.
	fighttarrot :- write('A wild tarrot appears !'),assert(enemy(neutral,'Tarrot',3)),nl,nl,battlestatus,nl,battle.
	fightonion :- write('A crying onion appears ?'),assert(enemy(neutral,'Crying Onion',6)),nl,nl,battlestatus,nl,battle.
	fightsalad :- write('A Caesar Salad appears !'), assert(enemy(neutral,'Caesar Salad',4)),nl,nl,battlestatus,nl,battle.
	fighticecube :- write('A Ice Cube appears !'), assert(enemy(ice,'Ice Cube', 3)),nl,nl,battlestatus,nl,battle.
	fightvanilla :- write('A Vanilla Shake appears !'),nl,write('It seems ready to have a dance off against you!'), assert(enemy(ice,'Vanilla Shake', 5)),nl,nl,battle.
	fightscope :- write('A Triple Scope is taking aim on you!'),assert(enemy(ice,'Triple Scope', 3)),nl,nl,battle.
	fightbanana :- write('A Banana Skit appears !'),nl,write('Clemen thought to himself "That is a funny looking banana split."'),assert(enemy(ice,'Banana Skit', 5)),nl,nl,battle.
	fightpome :- write('A Pome...GRENADE appears !'),nl,write('It looks like it is going to explode!'), assert(enemy(fire,'Pomegrenade', 2)),nl,nl,battle.
	fightsoup :- write('A Stupendous Soup appears !'),nl,write('Awwwww that is hot!!'), assert(enemy(fire,'Stupendous Soup', 5)),assert(round(1)),nl,nl,battle.
	fightfrench :- write(' A group of French Flies appears !'),nl, write('It is raining french flies!!'), assert(enemy(fire,'French Flies', 6)),nl,nl,battle.
	fightpizza :- write('A Pineapple pizza appears ! (EWWWWW)'), assert(enemy(fire,'Pineapple Pizza', 6)),nl,nl,battle.
	
	%Boss
	bossfight(neutral) :- write('As you keep venturing forward into the garden,'),write('You see an area full of vines covering the ground.'),get_single_char(_),write('Suddenly, Spaghetti Regretti appears !'),nl,write('It looks at you menacingly!'), assert(round(1)), assert(enemy(boss,'Spaghetti Regretti',12)),nl,nl,battlestatus,nl,battle.
	bossfight(ice) :- write('You encounter a huge refridgerator in the middle of nowhere.'),write(' You decided to explore the inside of this large container.'),get_single_char(_),nl,write('As you walked into the refridgerator, you feel cold air around you...'),write(' You look up and you see a Frozen Tuna staring back at you!'),get_single_char(_),write('Frozen Tuna appears!'),nl,write('Frozen stares at you with a hostile sense!'), assert(round(1)),assert(enemy(boss,'Frozen Tuna', 20)),nl,nl,battlestatus,nl,battle.
	bossfight(fire) :- write('You hear loud snoring sounds from far away, knowing that it might be the one last ingredient that you are finding,'),get_single_char(_),write(' you move quietly in the shadows to approach the source of the sound.'),nl,write('A giant bun is just sleeping there appearantly.'),write('You tried to get a sneak attack but you stepped on a twig and thus...'),nl,write('Dai Bao awakens! (Use this link for music -> https://www.youtube.com/watch?v=XUhVCoTsBaM)'),nl,write('It shapes just like a volcano... That looks dangerous!'), assert(enemy(boss,'Dai Bao', 15)),nl,nl,battlestatus,nl,battle.

	chooseaction :- write('i - view your items'),nl,
			write('a - use your weapon to attack enemy'),nl,
			write('t - use tomato juice'),nl,
			write('b - use blowtorch'),nl,
			write('p - use pepper'),nl,
			write('Your Choice : ').

	action(i) :- itemList,nl,chooseaction,read(X),action(X).
	action(a) :- burn(no),playerstun(no),get_single_char(_),weapon(X), weaponattack(X),nl,battlestatus,nl,sneeze(no),stun(no),enemy(_,Name,Hp), Hp > 0,get_single_char(_),random(1,101,Random), enemyattack(Name,Random),battlestatus,nl.
	action(a) :- burn(yes), write('You took one burn damage'),deducthp,retract(burn(_)),assert(burn(no)), \+hp(die), get_single_char(_),weapon(X), weaponattack(X),nl,battlestatus,nl,sneeze(no),stun(no),enemy(_,Name,Hp), Hp > 0,get_single_char(_),random(1,101,Random), enemyattack(Name,Random),battlestatus,nl.
	action(a) :- hp(die),!.
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
	action(_) :- \+hp(die),write('Invalid action, please try again'), nl, chooseaction,read(X) ,action(X).

	result :- hp(die),retractall(enemy(_,_,_)),write('You die'),nl,gameover,end.
	result :- enemy(_,'Spaghetti Regretti',X), X =< 0, write('You defeated Spaghetti Regretti !  Stage clear !'),nl,nl,score(boss),retractall(enemy(_,_,_)),assert(complete(neutral)),retract(playerloc(_)),assert(playerloc(town)),retract(hp(_)),assert(hp(healthy)),nl,townhall.
	result :- enemy(_,'Frozen Tuna', X), X =< 0, write('You have defeated Frozen Tuna !   Stage clear !'),nl,nl,score(boss),retractall(enemy(_,_,_)),assert(complete(ice)),retract(playerloc(_)),assert(playerloc(town)),retract(hp(_)),assert(hp(healthy)),nl,townhall.
	result :- stage(1), enemy(_,'Dai Bao',X), X =< 0,write('It seems like Dai Bao has split itself.... Oh no.'),nl,nl,retractall(enemy(_,_,_)),assert(enemy(boss,'Dai Bao', 10)), retract(stage(_)), assert(stage(2)),battle.
	result :- stage(2), enemy(_,'Dai Bao',X), X =< 0, write('Dai Bao seems wounded but it is still not giving up!!!'),nl,nl,retractall(enemy(_,_,_)),assert(enemy(boss,'Dao Bao',5)), retract(stage(3)), assert(stage(3)),battle.
	result :- stage(3), enemy(_,'Dai Bao',X), X =< 0, write('You have finally defeated Dai Bao!!!'),nl,nl,retractall(enemy(_,_,_)),retract(playerloc(_)),assert(playerloc(town)),ending.
	result :- enemy(Type,Name,Hp), Hp =< 0, write('You defeated '), write(Name), write('! Good Job!'),nl,nl, random(1,101,X),loot(X),nl,score(Type),get_single_char(_),retractall(enemy(_,_,_)),nl,random(1,101,Y),fight(Y),!.

	%Chest	
	chest(can) :- nl,write('As you walk around the Violet Garden, you found a very peculiar looking Can with a keyhole on it'),nl,
		      write('Do you want to open it?'),nl,
		      write('Your choice (yes/no) : '),read(X),open(can,X).
	chest(crabshell) :- nl,write('As you walk around the Icy Riverside, you found a Crab Shell, seems like there is something inside?'),nl,
			    write('Do you want to open it?'),nl,
		      	    write('Your choice (yes/no) : '),read(X),open(crabshell,X).	
	chest(wine) :- nl,write('As you walk around the Fiery Hill, you found a Wine Bottle, seems like its not fill up with ordinary wine?'),nl,
			    write('Do you want to open it?'),nl,
		      	    write('Your choice (yes/no) : '),read(X),open(wine,X).	
	
	open(can,yes) :- get_single_char(_),item(co,yes),nl,write('You use the Can Opener to open the top of the Can instead of of putting it into the keyhole...'),get_single_char(_),nl,
			 write('the Can Opener breaks, but the Can is opened!'),nl,item(pepper,X),
			 write('You obtained 3 pepper!'),retractall(item(co,_)),assert(item(co,no)),retractall(item(pepper,_)),NewX is X + 3, assert(item(pepper,NewX)),nl.
	open(can,yes) :- nl,item(co,no),write('You tried to open the Can, but its too hard and you cant break it open...'),nl.
	open(can,no) :- nl,write('You just ignore the peculiar Can and continue along the path...'),nl.
	open(crabshell,yes) :- get_single_char(_),item(mt,yes),nl,write('You use the Meat Tenderizer to hit the Crab Shell...'),get_single_char(_),nl,
			       write('but turns out Meat Tenderizer is not a proper tool to open Crab Shell, so it breaks...'),get_single_char(_),nl,
			       write('Suddenly, the Crab Shell opened'),nl,item(blowtorch,X),
			       write('You obtained 2 blowtorch!'),retractall(item(mt,_)),assert(item(mt,no)),retractall(item(blowtorch,_)),NewX is X + 2, assert(item(blowtorch,NewX)),nl. 
	open(crabshell,yes) :- item(mt,no),nl,write('You tried to open the Crab Shell, but its too hot and you burned your hands on the process...'),nl.
	open(crabshell,no) :- nl,write('You just ignore the Crab Shell and continue along the path...'),nl.
	open(wine,yes) :- get_single_char(_),item(corkscrew,yes),nl,write('You use the the Corkscrew to open the Wine Bottle...'),get_single_char(_),nl,
			 write('but you do it too hard... so the Corkscrew breaks... but the Wine Bottle is opened!'),nl,item(potion,X),
			 write('You obtained 5 potion!'),retractall(item(corkscrew,_)),assert(item(corkscrew,no)),retractall(item(potion,_)),NewX is X + 5, assert(item(potion,NewX)),nl.
	open(wine,yes) :- nl,item(corkscrew,no),write('You tried to open the Wine Bottle, but you slipped and everything in the Wine Bottle spill out...'),nl.
	open(wine,no) :- nl,write('You just ignore the Wine Bottle and continue along the path...'),nl.
	open(X,_) :- write('Invalid Input, Please try again'),nl,write('Your choice (yes/no) : '),read(Y),nl,open(X,Y).	

	%Utility
	itemList :- nl,weapon(X), write('Weapon : '),write(X),nl,
		    (item(potion,Y),Y > 0, write('Tomato juice   x '),write(Y),nl;!),
		    (item(blowtorch,Z),Z > 0, write('Blowtorch   x '),write(Z),nl;!),
		    (item(pepper,A),A > 0, write('Pepper   x '),write(A),nl;!),
		    (item(mt,yes), write('Meat Tenderizer'),nl;!),
		    (item(co,yes), write('Can Opener'),nl;!),
		    (item(corkscrew,yes), write('Corkscrew'),nl;!),!.

	loot(1) :- \+weapon('Frying Pan'),weapon(Weapon), achieverng, write('You found the LEGENDERY Frying Pan!!!, do you want to pick up and replace your '),write(Weapon),write('?'),nl,write('Your choice (yes/no) : '),read(Y),changeweapon(Y,'Frying Pan');random(2,101,R),loot(R).
	loot(X) :- X > 1, X =< 60, write('You have obtained 1 tomato juice!'), item(potion,Y), NewY is Y + 1, retractall(item(potion,_)), assert(item(potion,NewY)).
	loot(X) :- X >60, X =< 75, write('You have obtained 1 blowtorch!'), item(blowtorch,Y), NewY is Y + 1, retractall(item(blowtorch,_)),assert(item(blowtorch,NewY)).
	loot(X) :- X >75, X =< 95,write('You have obtained 1 pepper!'), item(pepper,Y), NewY is Y + 1, retractall(item(pepper,_)), assert(item(pepper,NewY)).

	advice(1) :- write('Did you know? Tomato juice heals your hp full!').
	advice(2) :- write('Edythe will sometimes provide you supplies! You should pay a visit to the old lady often.').
	advice(3) :- write('There are three areas you can explore to gather ingredients which is Violent Garden, Fiery Hill and Icy River!'),nl,write('The other areas are restricted due to its dangerous surroundings for now..').
	advice(4) :- write('Did you know if your HP drops to "die", you actually die?'),achieveuseless.
	advice(5) :- get_single_char(_),write('You have 5 states of HP, make sure to keep track of your HP or else you might lose!'),get_single_char(_),write('..... Oh wait, I mean die not lose. This is not a game after all').
	advice(6) :- write('You gain score everytime you defeat an enemy and extra for bosses, but everytime you heal you lose points! (There is an achievement for this teehee)').
	advice(7) :- write('Use pepper to avoid getting hit for one round!').
	advice(8) :- write('You have limited resources! Make sure to make full use for them!').
	advice(9) :- write('You should visit Trader Terry for more supplies!').
	advice(10) :- write('I am running out of scripts to help you, please stop asking me for help.'),achievelazywriting.
	advice(11) :- write('Each bosses have their unique abilities, watch out for their abilities!').
	advice(12) :- write('Legend says only a few are worthy of wielding the legendary weapon, will it be you?').

	score(neutral) :- playerScore(S), X is 100, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 100 score!!'),nl,nl,(Total >= 2000, achievescore,nl,nl;!),scorestatus.
	score(ice) :- playerScore(S), X is 150, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 150 score!!'),nl,nl,(Total >= 2000, achievescore,nl,nl;!),scorestatus.
	score(fire) :- playerScore(S), X is 200, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 200 score!!'),nl,nl,(Total >= 2000, achievescore,nl,nl;!),scorestatus.
	score(boss) :- playerScore(S), X is 500, Total is S + X, retract(playerScore(_)), assert(playerScore(Total)),write('You received 500 score!!'),nl,nl,(Total >= 2000, achievescore,nl,nl;!),scorestatus.
	scorestatus :- hp(X), write('Player Hp : '),write(X),nl,
		       playerScore(Y), write('Player Score : '), write(Y),nl.

	%Event
	event(X) :- X > 10, X =< 30, write('There is a crossroad left and right, a signboard is found there.'),nl,random(1,3,R),write('Your choice (left/right) : '),read(D),crossroad(D,R).
	event(X) :- get_single_char(_),X > 30, X =< 50, \+item(potion,0), write('You encounter some babarians along the way, some of your tomato juice has been snatched'),get_single_char(_),nl,random(1,4,R),snatch(R),get_single_char(_).
	event(X) :- X > 50, X =< 70, item(co,no),playerloc(neutral), write('You see something shinny on the floor, so you pick it up'),nl,retractall(item(co,_)),assert(item(co,yes)),write('You obtained a Can Openner!'),nl.
	event(X) :- X > 50, X =< 70, item(mt,no),playerloc(ice), write('You see something shinny on the floor, so you pick it up'),nl,retractall(item(mt,_)),assert(item(mt,yes)),write('You obtained a Meat Tenderizer!'),nl.
	event(X) :- X > 50, X =< 70, item(corkscrew,no),playerloc(fire), write('You see something shinny on the floor, so you pick it up'),nl,retractall(item(corkscrew,_)),assert(item(corkscrew,yes)),write('You obtained a Can Openner!'),nl.
	event(_) :- write('You continued your journey without any interesting events happening...'),nl.

	crossroad(left,1) :- write('You walked into a dangerous path full of spiky vines. You took one damage!'), deducthp.
	crossroad(right,1) :-  write('Walking on the pathway, you see something shiny on the ground, you found one HP potion!'), item(potion,X), NewX is X + 1, retractall(item(potion,_)), assert(item(potion,NewX)).
	crossroad(left,2) :-  write('Walking on the pathway, you see something shiny on the ground, you found one HP potion!'), item(potion,X), NewX is X + 1, retractall(item(potion,_)), assert(item(potion,NewX)).
	crossroad(right,2) :- write('You walked into a dangerous path full of spiky vines. You took one damage!'), deducthp.
	crossroad(_,Y) :- write('Please enter only left or right!'),nl,write('Your Choice : '), read(X), crossroad(X,Y).	

	snatch(X) :- item(potion,Y), Y >= X, write('Tomato Juice - '), write(X), NewY is Y - X, retractall(item(potion,_)), assert(item(potion,NewY)), write('     '),write(NewY),write(' Tomato Juice left'),nl.
	snatch(X) :- item(potion,Y), Y < X, random(1,X,R), snatch(R).

	%Achievement
	achievestart :- \+achievement('You did it!!'), assert(achievement('You did it!!')),write('You unlocked an achievement : You did it!!'),nl,nl;!.
	achievedown :- \+achievement('Not ready for adventure...'), assert(achievement('Not ready for adventure...')),write('You unlocked an achievement : Not ready for adventure...'),nl,nl;!.
	achieveuseless :- \+achievement('Not so useful now!!'), assert(achievement('Not so useful now!!')),nl, write('You unlocked an achievement : Not so useful now!!');!.
	achievelazywriting :- \+achievement('Lazy writing'), assert(achievement('Lazy writing')),nl, write('You unlocked an achievement : Lazy writing');!.
	achievescore :- \+achievement('Score for the sky!!'), assert(achievement('Score for the sky!!')), nl, write('You unlocked an achievement : Score for the sky!!');!.
	achieverng :- \+achievement('RNGesus'), assert(achievement('RNGesus')),nl,write('You unlocked an achievement : RNGesus'),nl,nl;!.

	achievement :- findall(X,achievement(X),List), nl,write('Achievements obtained :'),nl,printachieve(List).

	printachieve([]).
	printachieve([H|T]) :- write(H),nl,printachieve(T).

	%For test purpose
	give('Frying Pan') :- retract(weapon(_)), assert(weapon('Frying Pan')).
	give('Metal Spatula') :- retract(weapon(_)), assert(weapon('Metal Spatula')).
	give('Ice Cream Scoop') :- retract(weapon(_)), assert(weapon('Ice Cream Scoop')).
	give('Chopstick') :- retract(weapon(_)), assert(weapon('Chopstick)).
