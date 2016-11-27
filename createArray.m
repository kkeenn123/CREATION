%CREATION - Array Generator
%This program creates the multi-array datasystem that stores information
%for the game.
%Ken Varghese
filename = 'CDATA.mat';
nm = 'name';
des = 'desc';
cntn = 'contains';
roomfields = [nm,des,cntn];
%room1 - start room
rm1Name = 'START ROOM';
rm1Desc = ['A dim-lighted cell with a CANDLE in the center. ',...
'YOU smell the stench of a corpse, signaling there is a ghoul nearby. ',...
'The room is safe. There is a cell door NORTH of the player.',...
'There is a BOOK on your bed and a WINDOW behind you. '];
rm1Contains = ['WINDOW', 'BOOK', 'CANDLE'];
%room1 = struct('room', 'STARTROOM', 'desc', rm1Desc,'contains', ...
%rm1Contains);
room1{1} = rm1Name;
room1{2} = rm1Desc;
room1{3} = rm1Contains;
clear rm1Name;
clear rm1Desc;
clear rm1Contains;

%room2 - Jail Hallway
rm2Name = 'JAIL HALLWAY';
%rm2Desc = 'YOU can''t see anything, the room is pitch black...';
rm2Desc = ['Illuminated in front of you is the GHOUL. ',...
    'Your cell is south. There is a cell to the north. ',...
    'There is a hallway to the west.'];
rm2Contains = [];
%room2 = struct('room', 'JAIL HALLWAY','desc',rm2Desc,'desc2',rm2Desc2, ...
%    'contains', rm2Contains);
room2{1} = rm2Name;
room2{2} = rm2Desc;
room2{3} = rm2Contains;
clear rm2Name;
clear rm2Desc;
clear rm2Contains;

%room3 - Hallway West
rm3Name = 'HALLWAY WEST';
rm3Desc = ['There is little different in this room. ',...
'Cells to the north and south, and a door to the west.'];
rm3Contains = {};
%room3 = struct('room','HALLWAY WEST','desc',rm3Desc,'contains',...
% rm3Contains);
room3{1} = rm3Name;
room3{2} = rm3Desc;
room3{3} = rm3Contains;
clear rm3Name;
clear rm3Desc;
clear rm3Contains;

%room4 - Jail Cell Northeast
rm4Name = 'JAIL CELL NORTHEAST';
rm4Desc = ['A corpse lies here, holding the NORTHEAST KEY. ',...
    'The wall has the number 7 etched into it. '...
    'It smells atrocious. ',...
    'You can only go SOUTH from here.'];
rm4Contains = ['NORTHEAST KEY','WALL'];
%room4 = struct('room','JAIL CELL NORTHEAST','desc',rm4Desc,'contains',...
%    rm4Contains);
room4{1} = rm4Name;
room4{2} = rm4Desc;
room4{3} = rm4Contains;
clear rm4Name;
clear rm4Desc;
clear rm4Contains;

%room 5 - Jail Cell Northwest
rm5Name = 'JAIL CELL NORTHWEST';
rm5Desc = ['Same as the other cells. Nothing inside. ',...
    'Etched on the wall are four vertical lines with a ',...
    'diagonal line crossing them'];
rm5Contains = [];
%room5 = struct('room','JAIL CELL NORTHWEST','desc',rm5Desc,'contains',...
%rm5Contains);
room5{1} = rm5Name;
room5{2} = rm5Desc;
room5{3} = rm5Contains;
clear rm5Name;
clear rm5Desc;
clear rm5Contains;

%room 6 - Jail Cell Southwest
rm6Name = 'JAIL CELL SOUTHWEST';
rm6Desc = ['A rat skitters away as the light illuminates it. ',...
    'Etched into the wall is the number sequence: ',...
    '00000110 ',...
    'There is an APPLE on the bed. '];
rm6Contains = ['APPLE'];
room6{1} = rm6Name;
room6{2} = rm6Desc;
room6{3} = rm6Contains;
clear rm6Name;
clear rm6Desc;
clear rm6Contains;

%room 7 - Jail Exit
rm7Name = 'JAIL EXIT';
rm7Desc = ['The exit to this place is a massive iron door.',...
    'The DOOR has a keyhole as well as a combination lock. ',...
    'Exits to the west...',...
    'A compass is on the wall. ',...
    'Someone wrote "First" over NE, ',...
    '"Second" over NW, and "Third" over SW. '];
rm7Contains = [];
room7{1} = rm7Name;
room7{2} = rm7Desc;
room7{3} = rm7Contains;
clear rm7Name;
clear rm7Desc;
clear rm7Contains;

%room 8 - Forest
rm8Name = 'FOREST';
rm8Desc = ['Trees and forest sounds. Paths to the north and south.'];
rm8Contains = [];
room8{1} = rm8Name;
room8{2} = rm8Desc;
room8{3} = rm8Contains;
clear rm8Name;
clear rm8Desc;
clear rm8Contains;



roomData = struct('room1',room1,'room2',room2,'room3',room3,'room4',...
    room4,'room5',room5,'room6',room6,'room7',room7,'room8',room8);
save CData.mat roomData;
clear;
