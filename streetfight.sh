#!/bin/bash
{
 echo "You see a local ruffian! He wants to rumble, what's the move, daddio?:"
  read move
    
   if [ $move = "punch" ]
    then 
     echo "Pow, directly in the kisser!"
   

   elif [ $move = "kick" ]
    then
     echo "His grandkids felt that one!"
   
    else 
     echo "Try it again, boss!"
   fi

   if [ $move = "block" ]
    then
     echo "Nice try, wise guy!"
   fi
}
