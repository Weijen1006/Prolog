start :- write('Starting of the story'),nl,town.

town :- write('Please choose a place to go'),nl,
	write('Your choice : '),read(X),location(X).

location(up) :- write('You choose neutral faction, Good Luck'),nl,neutral.
location(left) :- write('You choose ice faction, Good Luck'),nl,ice.
location(right):- write('You choose fire faction, Good Luck'),nl,fire.
location(down):- write('I see what you try to do there, but there is no going back'),nl,write('Your choice : '),read(X),location(X).
location(_):- write('Invalid Input, Please try again'),nl,write('Your choice : '),read(X),location(X).

%Neutral faction
neutral :- write('Stay tuned').

%Ice faction
ice :- write('Stay tuned').

%Fire faction
fire :- write('Stay tuned').

%HP

%Monster

%Battle

%NPC

%Item

%Inventory
