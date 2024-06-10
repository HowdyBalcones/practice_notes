// this is a game of rock paper scissors I coded alongside instructions from codeacademy. 
// it is much more concise than my version in c++, which is worth revisiting. 
// rock paper scissors
console.log('hi');

const getUserChoice = userInput => 
{
  userInput = userInput.toLowerCase();
  if (userInput === 'rock' || userInput === 'paper' || userInput === 'scissors' || userInput === 'bomb') {
    return userInput;
  } else {
    console.log('Invalid play.')
    return 0;
  }
}

const getComputerChoice = () => 
{
  number = Math.floor(Math.random() * 3)
  switch (number) {
    case 0:
      return 'rock';
      break;
    case 1:
      return 'paper';
      break;
    case 2: 
      return 'scissors';
      break;
    default:
      return 'Invalid Input!'
      break;
  }
}

const determineWinner = (userChoice, computerChoice) => 
{
  if (userChoice === 'bomb') {
    return 'Cheat code enabled! You win by default, do not feel proud!';
  }
  if (computerChoice === userChoice) {
    return 'There has been a tie!';
  } 
if (userChoice === 'rock') {
    if (computerChoice === 'paper'){
      return 'Paper covers rock! Loser!';
    } else {
      return 'Rock smashes scissors, Victory!';
    }
  } else if (userChoice === 'paper') {
    if (computerChoice === 'scissors') {
      return 'Scissors cuts paper! You lose!'
    } else {
      return 'Paper covers rock! The player won something!';
    }
  } else if (userChoice === 'scissors'){
    if (computerChoice === 'rock') {
      return 'Rock smashes scissors, you have been crushed.';
    } else {
      return 'Scissors cuts paper, so you win this time!';
    }
  }
}

const playGame = () =>
{
  let userChoice = getUserChoice('scissors');
  let computerChoice = getComputerChoice();
  console.log(`The computer has played: ${computerChoice} \nThe player has played: ${userChoice}`)
  console.log(determineWinner(userChoice, computerChoice));
}

playGame();
