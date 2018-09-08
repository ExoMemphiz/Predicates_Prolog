%
% Create a program that models:
%    students
%    classes
%    rooms
%    dates
%
%    class -> * students
%    class -> * dates
%    class -> 1 room
%
%    room -> * class

student(chris).
student(william).
student(viktor).
student(zaeem).
student(christian).

class(discrete_math, chris, '12:30').
class(discrete_math, william, '12:30').
class(discrete_math, viktor, '12:30').

class(business_int, zaeem, '8:30').
class(business_int, christian, '8:30').

class(system_integration, chris, '16:00').
class(system_integration, william, '16:00').
class(system_integration, viktor, '16:00').
class(system_integration, zaeem, '16:00').
class(system_integration, christian, '16:00').

room('1.02', discrete_math).
room('1.02', business_int).
room('1.06', system_integration).

% Problem 1 ------------------------------------------------------------------------------

is_in_room(RoomNr, Person) :-
    student(Person),
    room(RoomNr, Class),
    class(Class, Person, _).

has_class(Person, Time) :-
    class(_, Person, Time).

is_in_class(RoomNr, Person, Time) :-
    is_in_room(RoomNr, Person),
    has_class(Person, Time).

who_has_class(RoomNr, Time) :-
    forall(is_in_class(RoomNr, Student, Time), writeln(Student)).

% Problem 2 ------------------------------------------------------------------------------
    
printInfo(Class, Person, Time) :-
    string_concat(Person, ' has ', Part1),
    string_concat(Part1, Class, Part2),
    string_concat(Part2, ' at ' , Part3),
    string_concat(Part3, Time, Part4),
    writeln(Part4).
    
display_lectures(Person) :-
    forall(class(Class, Person, Time), printInfo(Class, Person, Time)).

% Problem 3 ------------------------------------------------------------------------------

print_classmates(Person, X, Class) :-
    string_concat(Person, ' has class with ', Part1),
    string_concat(Part1, X, Part2),
    string_concat(Part2, ' in ', Part3),
    string_concat(Part3, Class, Part4),
    writeln(Part4).

find_classmates(Student) :-
    forall(class(ClassName, Student, _), forall(class(ClassName, ClassMate, _), test_name(Student, ClassMate, ClassName))).

test_name(Person, X, Class) :-
    Person \= X -> print_classmates(Person, X, Class); true.