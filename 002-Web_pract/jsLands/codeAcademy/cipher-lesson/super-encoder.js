// Import the encryptors functions here.
 const encryptors = require('./encryptors.js');
const caesarCipher = encryptors.caesarCipher;
const symbolCipher = encryptors.symbolCipher;
const reverseCipher = encryptors.reverseCipher;
const pseudoRandom = Math.floor(Math.random() * 26);

const encodeMessage = (str) => {
  // Use the encryptor functions here.
  const cipherKey = 4;
  const lvl1 = caesarCipher(str, cipherKey);
  const lvl2 = reverseCipher(lvl1);
  const lvl3 = symbolCipher(lvl2);
  return lvl3;
}

const decodeMessage = (str) => {
  // Use the encryptor functions here.
  const reverseCipherKey = -4;
  const lvl6 = symbolCipher(str);
  const lvl5 = reverseCipher(lvl6);
  const lvl4 = caesarCipher(lvl5, -4);
  return lvl4;
}

// User input / output.

const handleInput = (userInput) => {
  const str = userInput.toString().trim();
  let output;
  if (process.argv[2] === 'encode') {
    output = encodeMessage(str);
  } 
  if (process.argv[2] === 'decode') {
    output = decodeMessage(str);
  } 
  
  process.stdout.write(output + '\n');
  process.exit();
}

// Run the program.
process.stdout.write('Enter the message you would like to encrypt...\n> ');
process.stdin.on('data', handleInput);
