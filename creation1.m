%CREATION game
%USAGE: start by calling creation1 in terminal
%Relies on file CData.mat in the same directory.
%By Ken Varghese, 2016
%

%GAME START
function creation1;
tic;
disp('Welcome to CREATION.');
promptName = 'Please enter your name\n$ ';
name = input(promptName, 's');
fprintf('Hello %s. YOU awaken in a strange room...',name);
fprintf('\nWords in all caps are things you can interact with.');
fprintf('\nI should take a LOOK AROUND');
fprintf('\nWhen stuck, type HELP or COMMANDS functions');
global killCount;
killCount = 0;
global candleLit;
candleLit = false;
global combatMulti;
combatMulti = 1.0;
global health;
health = 100;
global inventory;
inventory = [];
global invenCount;
invenCount = 1;
CRooms = load('CData.mat','-mat'); %Make sure this file has been generated
global whereAmI;
whereAmI = CRooms.roomData(1).room1;
global location;
location = CRooms.roomData(2).room1;
global locNum;
locNum = 1;
global inCombat;
inCombat = false;
global cntns;
global door1Solved;
global keyInDoor;
keyInDoor = false;
door1Solved = false;
global incantLevel;
incantLevel = 0;
cntns = CRooms.roomData(3).room1;
global newLine;
newLine = sprintf('\n<%s> $ ',whereAmI);
Cinput;

    function Cinput;
        %CREATION input creator
        %script to take input
        %called whenever input is taken
        %Ken Varghese
        
        %newLine = '\n$ ';
        if inCombat
            newLine = sprintf('\n<%s> !! ',whereAmI);
        else newLine = sprintf('\n<%s> $ ',whereAmI);
        end
        received = input(newLine, 's');
        Cparser(received);
    end

    function Cparser(inputUser);
        %CREATION main parser program
        %takes data from Cinput and parses
        %it for commands and then
        %pipes commands to appropriate responses
        
        global linebreak;
        linebreak = '__________________';
        inputUser = lower(inputUser);
        if inCombat
            disp('YOU ARE IN COMBAT');
            CCombat;
        elseif health < 1
            disp(linebreak);
            disp('EXITING...');
            disp(linebreak);
            return;
        elseif strcmpi('help',inputUser)
            disp(linebreak);
            disp('CREATION is a text adventure game');
            disp('Enter commands into the terminal to play');
            disp('Use COMMANDS to show a list of common (not all) commands');
            disp('Pay attention to your HEALTH and your INVENTORY');
            disp('When stuck, remember to ask for HELP');
            disp(linebreak);
        elseif strcmpi('COMMANDS',inputUser)
            disp(linebreak);
            disp('LOOK AROUND- recieve information about the environment');
            disp('LOOK <input>- recieve information about something');
            disp('TAKE <input>- add object to inventory');
            disp('GO <direction>- go from room to room, assuming not in combat');
            disp('HEALTH - check player hit points and stamina');
            disp('INVENTORY - display the items in the users inventory');
            disp('QUIT - Exit the game');
            disp('USE <input> - Use object from inventory');
            disp('WHERE - Display current location');
            disp('Where <input> is specified, enter the desired word');
            disp(linebreak);
        elseif strcmpi('quit',inputUser)
            disp(linebreak);
            disp('EXITING...');
            disp(linebreak);
            return;
        elseif strcmpi('where',inputUser)
            disp(whereAmI);
        elseif strcmpi('',inputUser)
            disp('Please input a command')
        elseif strcmpi(inputUser,'look')
            disp('Syntax: look <something>');
        elseif strncmp(inputUser,'look',4) && inputUser(5) == ' '
            Clook(inputUser);
        elseif strncmp(inputUser,'use',3) && inputUser(4) == ' '
            CUse(inputUser);
        elseif strcmpi(inputUser,'incant') ||strcmpi(inputUser,'attack')...
                || strcmpi(inputUser,'defend')
            disp('You are not in combat.');
        elseif strcmpi(inputUser,'take')
            disp('Syntax: take <something>');
        elseif strncmp(inputUser,'take',4) && inputUser(5) == ' '
            Ctake(inputUser);
        elseif strcmpi('health',inputUser) || strcmpi('YOU',inputUser)
            disp(linebreak);
            fprintf('Health: %d\n',health);
            disp(linebreak);
        elseif strcmpi('Inventory',inputUser)
            disp(linebreak);
            %disp('INVENTORY:');
            inventory
            disp(linebreak);
        elseif strcmpi('qqq',inputUser)
            return;
        elseif strcmpi('whos',inputUser)
            whos;
        elseif strcmpi('credits',inputUser)
            disp('Made by Ken Varghese');
            disp('Do not distribute without permission');
            disp('November 29, 2016');
        elseif strcmpi('go',inputUser)
            disp('Syntax: go <cardinal direction>');
        elseif strncmp(inputUser,'go',2) && inputUser(3) == ' '
            inputCat = inputUser(4:length(inputUser));
            if length(inputCat) < 2
                disp('Need a direction to go');
            else
                CGo(inputCat);
            end
        else
            fprintf('I don''t know how to %s',inputUser);
        end
        if ~door1Solved
            Cinput;
        else
            toc;
        end
    end

    function Clook(inputUser)
        inputCat = inputUser(6:length(inputUser));
        if strcmpi('around',inputCat)
            disp(location);
        elseif findstr(cntns,upper(inputCat)) > 0
            CitemDesc(inputCat);
            return;
        elseif find(strcmpi([inventory{:}],inputCat)) > 0
            CitemDesc(inputCat);
        else disp(sprintf('Can''t see %s',inputCat));
        end
    end
%CTake
%Written for CREATION
%By Ken Varghese
    function Ctake(inputUser)
         inputCat = inputUser(6:length(inputUser));
    for i=1:length(inventory)
        if strcmpi(inventory{i},inputCat)
            disp('Already in inventory');
            return;
        end
    end
    if locNum == 1
          if strcmpi(inputCat,'book')
              disp('Added book to inventory');
              
              addToInven(inputCat);
          elseif strcmpi(inputCat,'window')
              disp('Can''t add that to inventory.');
          elseif strcmpi(inputCat,'candle');
              candleLit = true;
              addToInven(inputCat);
              disp('Added candle to inventory. The room ahead is lit');
          else disp('Can''t do that');
          end
    elseif locNum == 4
        if strcmpi(inputCat, 'Northeast Key')
            disp('Added Northeast Key to inventory');
            addToInven(inputCat);
        else disp('Can''t do that');
        end
    elseif locNum == 6
        if strcmpi(inputCat,'Apple')
            disp('Added apple to inventory');
            addToInven(inputCat);
        else disp('Can''t do that');
        end
    end
    end
    function addToInven(inputUser)
        inventory{invenCount} = inputUser;
        invenCount = invenCount+1;
    end
    %Creation
    %Item Descriptions
    %Ken Varghese
    function CitemDesc(itemName)
        if strcmpi(itemName,'Candle')
            disp('Enchanted to burn forever. You will need this on your journey.');
        elseif strcmpi(itemName,'Book')
            disp('This book contains spells you can use in combat.');
        elseif strcmpi(itemName,'Window')
            disp('The entire landscape is lit by a distant fire. The forest around the jail is a safe');
            disp('haven from some distant cataclysm. You can''t stray too far from the jail.');
        elseif strcmpi(itemName,'Northeast Key')
            disp('Definitely need this. This key will fit the main door to the southwest.');
        elseif strcmpi(itemName,'apple')
            disp('Use this to regain health(+!5). Red and juicy.');
        elseif strcmpi(itemName,'wall')
            disp('These numbers will come in handy. YOU should remember them.');
        end
        
    end
%CCombat
%Written for Creation
%By Ken Varghese
    function CCombat
        enemyHealth = round(rand(1)*15)+10;
        rounds = 0;
        while inCombat
            if inCombat
            newLine = sprintf('\n<%s> !! ',whereAmI);
        else newLine = sprintf('\n<%s> $ ',whereAmI);
        end
            rounds = rounds+1;
            disp('_________________________');
            disp('COMBAT');
            disp('Enemy Health:');
            enemyHealth
            disp('Your health:');
            health
            %disp(linebreak);
            disp('Use ATTACK, DEFEND, or INCANT');
            disp('Use HELP for more information');
            %disp(newLine);
            randFive = round(rand(1)*5);
            randThree = round(rand(1)*3);
            resp = input(newLine,'s');
            if strcmpi(resp,'attack')
                fprintf('\nDid %d damage.',randFive);
                fprintf('\nTook %d damage. \n',combatMulti*randThree);
                enemyHealth = enemyHealth - randFive;
                health = health - combatMulti*randThree;
            elseif strcmpi(resp,'defend')
                fprintf('\nDid %d damage.\n',randThree);
                enemyHealth = enemyHealth - randThree;
                health = health + combatMulti*randThree;
                %health stays
            elseif strcmpi(resp,'incant')
                fprintf('\nDid %d damage.',randFive+incantLevel);
                fprintf('\nTook %d damage.\n',combatMulti*randThree);
                enemyHealth = enemyHealth - (randFive+incantLevel);
                health = health - combatMulti*randThree;
            elseif strcmpi(resp,'qqq')
                disp('Exiting combat');
                return;
            elseif strcmpi(resp,'help')
                disp('Attacking will do from 0-5 damage.');
                disp('Defending will do from 0-3 damage and heal you.');
                disp('Incanting will do varied damage depending on skill.');
                disp('You take no damage when defending.');
                disp('Combat ends when someone dies. No escaping.');
            else health = health - combatMulti*randFive;
            end
            if health < 1
                disp('YOU HAVE DIED');
                inCombat = false;
                return;
            elseif enemyHealth < 3
                disp('Enemy Vanquished');
                inCombat = false;
                killCount = killCount + 1;
                combatMulti = combatMulti + 0.2;
            elseif rounds > 20
                disp('Enemy ran away');
                inCombat = false;
            
        end
        end
    end
%CUse.m
%Written for CREATION
%by Ken Varghese
    function CUse(inputUser)
        inputCat = inputUser(5:length(inputUser));
        %disp(inputCat);
        found = false;
        if locNum == 7
        if strcmpi('door',inputCat)
            if keyInDoor
            promptttt = 'Enter three digits into the combination lock: ';
            sequence = input(promptttt);
            if sequence == 756
                door1Solved = true;
                disp('YOU HAVE ESCAPED');
                return;
            else disp('That wasn''t right. ');
                return;
            end
            else
                disp('The lock won''t move unless the key is in the door.');
            end
        end
        end
        for i2=1:length(inventory)
            if strcmpi(inventory{i2},inputCat)
                found = true;
                if strcmpi(inputCat,'apple')
                    health = health+5;
                    disp('Ate the apple');
                    inventory{i2} = '';
                    break;
                elseif strcmpi(inputCat,'candle')
                    disp('The candle is used automatically.');
                    break;
                elseif strcmpi(inputCat,'book')
                    disp('You read the book. Your INCANT damage increases!');
                    incantLevel = incantLevel + 5;
                    inventory{i2} = '';
                    break;
                elseif strcmpi(inputCat,'NORTHEAST KEY')
                    if locNum == 7
                        disp('The Key went into the door.');
                        keyInDoor = true;
                        inventory{i2} = '';
                        break;
                    else disp('Can''t use that here');
                        break;
                    end
                end
            end
        end
        if ~found
            fprintf('%s isn''t in your inventory',inputCat);
        end
        
        
    end
%Cgo.m
%Written for CREATION
%By Ken Varghese

    function CGo(loc)
        if locNum == 1
            if strcmpi(loc,'north')
                if ~candleLit
                    disp('The room ahead is pitch black. You need the candle.');
                elseif killCount == 0
                    inCombat = true;
                    locNum = 2;
                    whereAmI = CRooms.roomData(1).room2;
                    location = CRooms.roomData(2).room2;
                    cntns = CRooms.roomData(3).room2;
                else
                    locNum = 2;
                    whereAmI = CRooms.roomData(1).room2;
                    location = CRooms.roomData(2).room2;
                    cntns = CRooms.roomData(3).room2;
                end
            else
                disp('Can''t go there');
            end
        elseif locNum == 2
            if strcmpi(loc,'north')
                locNum = 4;
                whereAmI = CRooms.roomData(1).room4;
                location = CRooms.roomData(2).room4;
                cntns = CRooms.roomData(3).room4;
            elseif strcmpi(loc,'west')
                locNum = 3;
                whereAmI = CRooms.roomData(1).room3;
                location = CRooms.roomData(2).room3;
                cntns = CRooms.roomData(3).room3;
            elseif strcmpi(loc,'south')
                locNum = 1;
                whereAmI = CRooms.roomData(1).room1;
                location = CRooms.roomData(2).room1;
                cntns = CRooms.roomData(3).room1;
            else
                disp('Can''t go there');
            end
        elseif locNum == 3
            if strcmpi(loc,'east')
                locNum = 2;
                whereAmI = CRooms.roomData(1).room2;
                location = CRooms.roomData(2).room2;
                cntns = CRooms.roomData(3).room2;
            elseif strcmpi(loc,'north')
                locNum = 5;
                whereAmI = CRooms.roomData(1).room5;
                location = CRooms.roomData(2).room5;
                cntns = CRooms.roomData(3).room5;
            elseif strcmpi(loc,'south')
                locNum = 6;
                whereAmI = CRooms.roomData(1).room6;
                location = CRooms.roomData(2).room6;
                cntns = CRooms.roomData(3).room6;
            elseif strcmpi(loc,'west')
                if killCount == 1
                inCombat = true;
                end
                locNum = 7;
                whereAmI = CRooms.roomData(1).room7;
                location = CRooms.roomData(2).room7;
                cntns = CRooms.roomData(3).room7;
            else
                disp('Can''t go there');
            end
        elseif locNum == 4
            if strcmpi(loc,'south')
                locNum = 2;
                whereAmI = CRooms.roomData(1).room2;
                location = CRooms.roomData(2).room2;
                cntns = CRooms.roomData(3).room2;
            else
                disp('Can''t go there');
            end
        elseif locNum == 5
            if strcmpi(loc,'south')
                locNum = 3;
                whereAmI = CRooms.roomData(1).room3;
                location = CRooms.roomData(2).room3;
                cntns = CRooms.roomData(3).room3;
            else
                disp('Can''t go there');
            end
        elseif locNum == 6
            if strcmpi(loc,'north')
                locNum = 3;
                whereAmI = CRooms.roomData(1).room3;
                location = CRooms.roomData(2).room3;
                cntns = CRooms.roomData(3).room3;
            else disp('Can''t go there');
            end
        elseif locNum == 7
            if strcmpi(loc,'east')
                locNum = 3;
                whereAmI = CRooms.roomData(1).room3;
                location = CRooms.roomData(2).room3;
                cntns = CRooms.roomData(3).room3;
            elseif strcmpi(loc,'west')
                if door1Solved
                    disp('YOU HAVE ESCAPED');
                    return;
                else disp('The door is locked');
                end
            end
        end
        newLine = sprintf('\n<%s> $ ',whereAmI);
        CCombat;
    end

end