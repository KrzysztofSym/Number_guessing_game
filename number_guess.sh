#!/bin/bash
#dbname: number_guess table: ng
# sudo -iu postgres psql -d number_guess
PSQL="psql --username=postgres --dbname number_guess -t --no-align -c"
echo Enter your username:
read NAME
USER_NAME=$($PSQL "SELECT name FROM ng WHERE name = '$NAME';")
if [[ -z $USER_NAME ]]; then
  NEW_NAME=$($PSQL "INSERT INTO ng(name) VALUES('$NAME')")
  echo Welcome, $NAME! It looks like this is your first time here.
else
  echo "Welcome back, $USER_NAME! You have played <games_played> games, and your best game took <best_game> guesses."
fi
TEST=$($PSQL "SELECT name FROM ng")
echo $TEST
