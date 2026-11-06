#!/bin/bash
#dbname: number_guess table: ng
# sudo -iu postgres psql -d number_guess
PSQL="psql --username=postgres --dbname number_guess -t --no-align -c"
echo Enter your username:
read NAME

echo Which No.?
NUMBER=$((RANDOM % 10 + 1))
echo $NUMBER
ATTEMPT=0
#USER_NAME=$($PSQL "SELECT name FROM ng WHERE name = '$NAME';")
USER_EXISTS=$($PSQL "SELECT EXISTS(SELECT 1 FROM ng WHERE name = '$NAME');")
SCORE=$($PSQL "SELECT score FROM ng WHERE name = '$NAME'")
GAMES_PLAYED=$($PSQL "SELECT games_played FROM ng WHERE name = '$NAME'")
if [[ $USER_EXISTS == 'f' ]]; then
  NEW_NAME=$($PSQL "INSERT INTO ng(name, games_played) VALUES('$NAME', 0)")
  echo Welcome, $NAME! It looks like this is your first time here.
else
  echo "Welcome back, $NAME! You have played <games_played> games, and your best game took <best_game> guesses."
fi

GAME() {
  read GUESS
  if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
    echo That is not an integer, guess again:
    GAME
    return 0
  else
    ATTEMPT=$((ATTEMPT + 1))
    echo $ATTEMPT
    if [[ $GUESS -lt $NUMBER ]]; then
      echo Try higher
      GAME
      return 0
    elif [[ $GUESS -gt $NUMBER ]]; then
      echo Try lower
      GAME
      return 0
    else
      echo ~~YOU WON~~
      # if [[ -z $GAMES_PLAYED ]]; then
      #   NEW_GAME_UPDATE=$($PSQL "UPDATE ng SET games_played = 1 WHERE name = '$NAME'")
      # else
        GAMES_UPDATE=$($PSQL "UPDATE ng SET games_played = ($GAMES_PLAYED + 1) WHERE name = '$NAME'")
    fi
    if [[ -z $SCORE || $ATTEMPT -lt $SCORE ]]; then
      BEST_GAME=$($PSQL "UPDATE ng SET score = $ATTEMPT WHERE name = '$NAME'")
      echo new highscore
    fi
  fi
}
GAME
