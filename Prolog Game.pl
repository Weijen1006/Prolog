start :- retractall(item(_,_)),retractall(weapon(_)),retractall(score(_)),retractall(hp(_)),
	 assert(hp(fresh)),assert(score(0)),assert(weapon(nothing)),
	 assert(item(potion,0)),
	 assert(item(blowtorch,0)),
	 assert(item(pepper,0)),
	 assert(item(mt,no)),
	 assert(item(co,no)),
	 assert(item(corkscrew,no)),
	 assert(enemy(no)),
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

%Monster

%Battle

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
