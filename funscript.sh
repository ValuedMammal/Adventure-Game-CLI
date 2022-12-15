#!/bin/bash

# Get time of day (morning, afternoon, evening)
hour=$(date +%H)
if [ "$hour" -lt 12 ] && [ "$hour" -gt 3 ]; then
  tod=morning
elif [ "$hour" -lt 21 ] && [ "$hour" -gt 3 ]; then
  tod=afternoon
else tod=evening
fi

clear
echo "Your name please?"
read name

echo "Good $tod."
sleep 1
echo "How are you, $name? Good I hope.. (return)"
read ans

function start {
clear
echo "Anyway, what would you like to do?
1) check the weather
2) play a game
3) quit"
read strt
case $strt in
1) echo "Before continuing, you may want to look outside. (return)";
   read ans; start;;
2) echo "";;
3) echo "user quit"; exit 0;;
esac
}
start

echo "Is name $name ok? (y/n)"
read optName
case $optName in
n) echo "New name?"; read gameName; echo "Name: $gameName"; sleep 2;;
y) gameName=$name;;
esac

# Choose a char build - not yet supported
# echo "Choose character
# w) psychologist
# a) technician
# d) merchant"
# read selectChar
# case $selectChar in
# w) char=psyc;;
# a) char=tech;;
# d) char=merc;;
# esac

echo "Note: there are several instances where we pause to allow the player to read dialogue
and narration. When you see '>>' press return to continue. In other cases when presented with
options, enter one of the following keys 'w a s d y n' and hit return. Finally you may be
asked to provide your own input from the keyboard and again, press return to submit. >>"
read ans

# Ch1 Solitary
char=tech
logEgg=0
clear
sleep 1
echo "Chapter 1: Solitary
"
sleep 2
echo " You awake in a dark room. It's cold, but familiar. A ray of light comes through
a barred window high on the wall. A moment later, a flap swings open on the slot below
the window. 'Breakfast!' the guard calls from outside. You pull yourself up from the floor.
>>"; read ans

echo " Nearly eight days have passed since you were brought in for the crime of political
subversion. You approach the door slot.. one last time. You take a bite of a biscuit, 
and push the remainder of the tray back through. A loud [clang] sounds on the other side.
>>"; read ans

echo "'Hey!' The guard comes fumbling down the hall. 'You got a problem, partner?'
(obj: escape the cell)

$gameName:
w) Can you help me?
d) I was wondering the same about you"
read ans

echo " The guard waddles closer to the cell door. As he approaches, $gameName clutches the man's tie
through the door slot, pulling down hard. The man's thick neck lands on the sill. >>"
read ans

echo "$gameName: 'Open the door with the keycard, or say goodnight.' >>"
read ans

echo " The guard, audibly struggling, raises a hand to the keypad [beep]. The door cracks
open allowing $gameName to slip through. On the way out, you look at the spilt tray of
food next to the tired, kneeling guard. 'Clean that up,' you say before disappearing around
the corner of the cell block. >>"
read ans

# Ch2 - get back story, gain access to the mainframe 
clear
sleep 1
echo "Chapter 2: Under Cover
"
sleep 2
echo " You advance through a dim corridor in the belly of the giant metallic vessel. It's not an
ideal location to find yourself, neither is it an unfamiliar experience on the Victoria, a vast
labyrinth separating distinct operational sectors, the only home you've ever known. >>"
read ans

echo " Signs on the wall indicate you are on the path toward the central mainframe, but you'll
need to dodge security patrols and somehow infiltrate the unauthorized zone. >>"
read ans

echo " Conditions of society have detiorated for several years. The elite are consolidating power
while citizens continue to slide into poverty and unrest. The Chancellor has become a dictator, but 
what's worse, he apparently receives orders direct from the shipboard AI called AMY. As a result,
political discourse among humans is all but eroded. You and a growing rebel faction have decided
the last resort is to disable the AI at the mainframe, if there will be any hope of restoring justice.
>>"; read ans

echo " Spotting an open locker, you find a guard's uniform that looks worn. You quietly throw on the gear
before pushing ahead, ducking through a well-stocked chemical room. As you stroll further past
a nearby security camera, you can practically feel its watchful gaze but don't dare to look
back. Around the corner is a single sentry guarding the entrance to the mainframe.
You calmly approach. (obj: dispatch the guard) >>"; read ans

echo "$gameName: 'You're relieved. I'll take it from here.' >>"
read ans

echo "Sentry: 'I thought Frank was on duty today.' >>"
read ans

if [ "$char" == 'tech' ]; then
echo "$gameName:
w) Frank asked me to fill in
a) I didn't ask for lip, soldier
d) Frank is dead. Move, or you're next."
fi
read ans

if [ "$ans" == w ] || [ "$ans" == a ]; then
  echo "Sentry: 'You got it. I could use a break.' >>"
  read ans
elif [ "$ans" == d ]; then
  echo " The guard stiffens. He begins reaching for the electro-prod at his hip,
but $gameName swiftly sweeps the guard's arm behind his back. $gameName raises
a wet cloth over the guard's mouth and nose, the volatile fumes filling the
man's airway. He drops to the floor, silent. >>"
  read ans
fi

echo " The door requires a high security clearance. There is a biometric scanner and
a ten-digit keypad. You spot the serial number on the vest of the dispatched
sentry. >>"; read ans

function keypad {

# Initialize array, choose random element
arr=("001" "010" "011" "100" "101" "110")
t=${arr[ $RANDOM % ${#arr[@]} ]}

echo " You clearly make out part of the serial number: 4589, but the last three digits
appear faded. However you know the last three are always represented in binary - 1's
and 0's. You enter the first part into the keypad: [4..5..8..9...] (obj: finish the code)
last 3 digits?"
  for i in {5..1}; do
  read tripl
    if [ "$tripl" == "$t" ]; then
    break
    else echo "incorrect: $i tries left"
    fi
  done 
# Last try
if [ "$tripl" != "$t" ]; then
  read lastTripl
    if [ "$lastTripl" != "$t" ]; then
    echo "failed; looking for $t. try again.."
    sleep 3
    keypad
    fi
fi
}
keypad

# Success ..loading
for i in {0..2}; do
  echo -n "."
  sleep 1
done
echo "success"

# Enter mainframe
sleep 2
clear
echo " It's quiet inside the data center apart from the steady hum of machines and
equipment covering the walls. The heavy door closes behind you [click]. A sterile,
conditioned smell floats amid the cool flowing air. You pause to look around. >>"
read ans

echo " Deep in the ship's interior, the only indication of an outside world is an array
of monitors each casting sight into various city sectors. A few screens show sparse
views of the smooth outer hull set against the blackness of space. Below the screens
sits a singular terminal that glows a soft purple. Now confident this is the brain
of the AI, you approach the console. >>"; read ans

echo " There won't be much time now before the place is crawling with spooks.
At the welcome screen you hammer a few commands, and like that, you're in.
A prompt appears. >>"
read ans

function amy {
clear
echo "AMY: 'What would you like to do?'
w) activate comms
a) view system logs
s) database entry
d) manage memory"
read amyy

case $amyy in
w) echo "Unauthorized. Please log in"; sleep 2; amy;; # dummy option
a) echo "No new updates. Continue to archive? y/n";
  read log
  if [ "$log" == n ]; then amy
  elif [ "$log" == y ]; then # Easter egg
  echo " Strange, there's nothing here but a cryptic message:
  'della Costanza, Aurelia, key word: Troubador.' >>"
  read ans;
  logEgg=1; amy
  fi;;
s) echo "Enabling insert mode. Saved changes will overwrite previous progress.
Continue? y/n"
  read data
  if [ "$data" == n ]; then amy
  elif [ "$data" == y ]; then
  echo "Which db to modify?
(obj: nuke the db) >>"
  read ans
  echo " You inject a trojan allowing you to bypass authentication. In the database
you wipe everything: files, routines, and finally user credentials. You encrypt
the remaining contents with gibberish and rip the comm line from the wall.
'She's dead,' is your only thought. >>"
  read ans
  ending=a
  fi;;
d) echo "Danger: modifying contents of memory can lead to data loss.
Please ensure back up storage. Continue? y/n"
  read mem
  if [ "$mem" == n ]; then amy
  elif [ "$mem" == y ]; then
  echo "  Granting root privileges. You are responsible for command execution here forward.
  There are 3 redundant volumes here and 1 master fs. Proceed to customization? y/n"
    read mem1
    if [ "$mem1" == n ]; then amy
    elif [ "$mem1" == y ]; then
    echo "    Failsafe override: All changes are final. This operation can't be undone. Are you sure? y/n"
    read mem2
      if [ "$mem2" == n ]; then amy
      elif [ "$mem2" == y ]; then
      echo " You copy the complete data directories to the removable drive and eject the storage media.
You proceed to wipe the database, programs, and all user credentials. You encrypt the OS
with gibberish rendering it bricked. You tuck the drive into your coat pocket with a word
of encouragement - 'You're coming with me.' >>"
      read ans
      ending=b
      fi;
    fi;
  fi;;
esac
}
amy

# Begin Ch3. Two paths A-defeat the chancellor B-flee, go into exile 
clear
sleep 1
echo "Chapter 3: Judgment Day
"
sleep 2

if [ "$ending" == a ]; then
echo " $gameName turned to head for the exit when The Chancellor suddenly appeared at the
doorway. Strangely, the seasoned captain was alone rather than accompanied by the
usual entourage, hinting at some clandestine motive. >>"
read ans

echo "Chancellor: 'I didn't think you had it in you, $gameName. But alas, you've
shown true character.' >>"
read ans

echo " $gameName stood motionless, equal parts anxious and perplexed. The Chancellor stood
weak, bent slightly, forced the words through a dense haze: >>"
read ans

echo "Chancellor: 'It's finally over, is it? You can go and tell the people what you've done.' >>"
read ans

echo "$gameName: 'And what of you, sir?' >>"
read ans

echo "'It's the end of the road for me. The cancer spreads,' he said clutching his abdomen
beneath his jacket. He coughs, then 'Besides, the Council will have my head when they hear
of this.' >>"
read ans

echo "$gameName: 'We will carry on without the Council.' >>"
read ans

echo "Chancellor: 'Fool. You must know what this means. Sicily.. is gone.'

 Just then the man's arm fell to one side, an empty syringe falling from his bony hand.
'Tell K.. goodbye.' >>"
read ans

echo " The room fell silent. Time slowed to a crawl. Before $gameName knew it, the
old Chancellor was a lifeless heap on the floor. $gameName looked around briefly, heart
and breath returning to normal, finally disappearing out the way you came. >>"
read ans

# Epilogue 1 - become Cmdr, consumed by darkness
clear
sleep 1
echo "Epilogue - Vivat rex
"
sleep 2

echo " There has been no shortage of revelations to surface in the nine-twelveths of a calendar
since the incident in the control room. The AI was a black box - one that contained the only
known coordinates to Sicily; the government, a mere shell and a facade; you haven't spoken to K
since before the coup - she's all but disappeared. Now, things have never felt so grim, yet
the only path is to forge ahead in the darkness. Destiny is funny like that: you never
know what's demanded of you until you arrive at the moment when precise action is needed. >>"
read ans

echo " You struggle to maintain focus while the board room echoes with chatter:

'We must stabilize markets to restore economic order,' says one representative;

'Without a functioning gene program, supplies will be insufficient,' rebuts another.

'How do you weigh in, Commander?' All eyes fix upon you... >>"
read ans

echo " 'Let me think a moment,' you say, absently toying with the heavy, rock-clad timepiece
on your wrist before raising a hand to your chin. You swivel to face the convex window that
stretches from floor to ceiling. The mechanical shutters shift, revealing the black void of
space, faint points of light scattered in the distance.
"
sleep 3

echo "(The End)"

# Ending b(expansion) - go into hiding, gain xp, rendezvous with the architect
elif [ "$ending" == b ]; then 
echo " $gameName slips out the exit of the mainframe leaving no trace behind. As you
advance down the corridor, the comms system is already blaring with alerts of
intrusion and sabotage of the shipboard AI. You'll have to find somewhere to lay low
until the dust settles.. >>"; read ans

echo "(Later on..)

 Nearly half a calendar has passed since the day you went into hiding. The rebels
pushed on, and the ruling party was dissolved. To call the coup a success, however, is not
exactly the right word. Chaos and anarchy are widespread among the fractionated citizenry.
You hear only rumors of your perceived whereabouts: a traitor, radical, coward. Some say
you either died or faked your death. Your only link to the outside is through a sole
confidant known as Skelly. >>"; read ans

echo " Your only purpose now is to deliver the data drive to the architect. The drive is
safe, but is read/write protected. If anyone is able to extract its contents, it's
the architect. You can afford to be patient for now - secrecy is all that matters. You
work under various false identities doing system admin and security research. At
present, you're working on a task for a client which is proving particularly cumbersome. >>"
read ans

# Complete a task - need 5/5 to continue
function task5 {
  clear
  echo " 5/5. At some future date, Bitcoin block subsidy is 1.5625 btc. Therefore,
what must be true?

w) date > Jan 1, 2029
a) difficulty > 1e12
s) block size > 2MB
d) height > 1,050,000"
read str5
if [ "$str5" == d ]; then
  echo "success!"; sleep 1
else echo "incorrect"; sleep 1; task1
fi
}

function task4 {
  clear
  echo " 4/5. You login to a remote server over SSH. Before configuring the firewall to deny
incoming connections, what must you do?

w) allow port 22
a) allow port 443
s) allow port 123
d) allow port 8333"
read str4
if [ "$str4" == w ]; then
  echo "good"; sleep 1
  task5
else echo "incorrect"; sleep 1; task1
fi
}

function task3 {
  clear
  echo " 3/5. A file has permissions 644. Who can READ the file?

w) user only 
a) user and group only
s) everyone
d) no one"
read str3
if [ "$str3" == s ]; then
  echo "good"; sleep 1
  task4
else echo "incorrect"; sleep 1; task1
fi
}

function task2 {
  clear
  echo " 2/5. What is the hex code for the color CYAN ?

w) 00ffff 
a) ffff00
s) aa00bb
d) ababab"
read str2
if [ "$str2" == w ]; then
  echo "good"; sleep 1
  task3
else echo "incorrect"; sleep 1; task1
fi
}

function task1 {
  clear
  echo " Please answer the following by entering the LETTER of the corresponding
choice. You must get 5/5 correct to move on. We'll start off easy.

 1/5. What is the next term in the series {0, 1, 1, 2, 3, 5, 8...} ?

w) 11
a) 13
s) 17
d) 19"
read str1
if [ "$str1" == a ]; then
  echo "good"; sleep 1
  task2
else echo "incorrect"; sleep 1; task1
fi
}
task1

echo "
($gameName gained 1000xp for moderately complex cognition) >>"; read ans

# Easter egg
  if [ $logEgg -eq 1 ]; then
echo " It's rare that you venture out during daylight hours, but this day you felt particularly
compelled to take a walk. A vintage-looking street sign catches your eye:
'Speak to Aurelia, the Divine!' Somehow you never noticed it before. Where have I seen
that name, you think. >>"; read ans

echo " Near the sign is a stairwell leading to the basement level of the shops lining the avenue.
Stepping into the dim ally, you're met with the sound of an aged voice. 'What is it you seek from
the Great Aurelia?' >>"; read ans

echo "$gameName: '..I am curious is all - where did you come from?' >>"; read ans

echo "Aurelia: 'Questions like that, my dear, require payment. Unless you've something else with
which to tempt me, a word perhaps.' >>"; read ans

echo "$gameName: '..Troubador?'

The woman looks up slowly until her emerald eyes fix squarely upon yours, penetrating.
'It's you,' she whispers in a combination of horror and total rapture. >>"; read ans

echo " Suddenly uneasy, you are about to appologize for bothering the lady, but she continues,

'I knew you'd return. Please child, trust and remain steady. I understand you have important work,
and time wears thin. Take this gift, and speak of it to no one. You may seek my guidance again but
only once the flower of harvest wilts. Goodbye.' >>"; read ans

echo "($gameName acquired the Stone of Aurelia, a rare gem of unknown value) >>"
read ans
  fi

# Contact the architect
clear
echo " You have an avenue by which to contact the architect, but you'll need to do so discretely
so as not to blow your cover - the whole net is bugged. If successful, the architect will
detect your motive while having an alibi to play along. She's expecting you, anyways.
You deliver an email that reads simply, 

'Good day, I'm with the press. I have information I think you may be interested in regarding
potential illegal organizing against the Party. I understand you have the technical
expertise to conduct information reconnaissance. I Look forward to your response.'
>>"; read ans

echo " K receives the message. Puzzled, she reads and re-reads it. She suspects it could be
the signal she was hoping for, but she needs confirmation. She replies with an acknowledgment
and gently probes further,

'It's true I work in data science, but what makes you think I have authority in government?'
>>"; read ans

echo "To which you reply: 'I am an old student of Dr. Mortimer. Meet me near the fountain in the
commercial zone at your convenience.' >>"; read ans

echo "(Later on..)

 Though you're hardly recognizable, K is exalted to see you're alive. You get down to business:
How to retrieve the coordinates to Sicily while averting societal collapse. She tells you there is
a chance the AI can be recovered, assuming the data is intact. However, the drive is protected
by an algorithm of which she's unfamiliar. Given present capabilities, it will take a hundred 
years to crack it - unless advancements in computation improve dramatically. >>"
read ans

echo "K: 'Take me to the hard disk so I can begin running diagnostics.' >>"; read ans

echo "$gameName: 'How do I know you won't just take possession of the AI and turn it over
to the Party? You have a life there, a future.' >>"; read ans

echo "K: 'I am committed to the mission we set in motion many cycles ago. But above all,
$gameName, I'm committed.. to us.' >>"; read ans

echo " The next morning, K recommends you enlist help from someone who knows the tech. Not just anyone -
but a youthful type who's not yet entrenched in traditional academics; someone who can be
molded with arcane knowledge and able to think orthogonally: a protégé. We can even
sponsor the child's schooling, she says, give them the best. It will take time, but
there is yet hope. Humanity depends on it. >>"
read ans

# Epilogue b
clear
sleep 1
echo "Epilogue - The long axis of time
"
sleep 2

echo "Business has been quite well for the two of you. K has found success teaching
and consulting, and you both have become involved in the community, building
networks and planting seeds of a future aristocracy. One day passing through the
market, you spot a boy of maybe age 12. You observe as he haggles with a vendor,
completing mental conversions with astonishing precision. You and K turn to one
another, near telepathically.

K advances toward the boy. 'Let me help you with that. What's your name anyway?'
"
sleep 3
echo "(The End)"
fi
