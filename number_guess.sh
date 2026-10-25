#!/bin/bash
#dbname: number_guess table: ng
# sudo -iu postgres psql -d number_guess
PSQL="psql --username=postgres --dbname number_guess -t --no-align -c"
# echo Enter your username:
# read NAME
# USER_NAME=$($PSQL "SELECT name FROM ng WHERE name = '$NAME';")
# if [[ -z $USER_NAME ]]; then
#   NEW_NAME=$($PSQL "INSERT INTO ng(name) VALUES('$NAME')")
#   echo Welcome, $NAME! It looks like this is your first time here.
# else
#   echo "Welcome back, $USER_NAME! You have played <games_played> games, and your best game took <best_game> guesses."
# fi

NUMBER=$((RANDOM % 10 + 1))
echo $NUMBER
ATTEMPT=0
GAME() {
  echo Which No.?
  read GUESS
  ATTEMPT=$ATTEMPT+1
  echo $ATTEMPT
  if [[ $GUESS -lt $NUMBER ]]; then
    echo Try higher
    GAME
  elif [[ $GUESS -gt $NUMBER ]]; then
    echo Try lower
    GAME
  else
    echo ~~YOU WON~~
  fi
}
ATTEMPT
