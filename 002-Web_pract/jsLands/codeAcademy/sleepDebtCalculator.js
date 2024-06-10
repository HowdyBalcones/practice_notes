const getSleepHours = day => 
{
  switch (day) {
    case 'monday':
      return 8;
      break;
    case 'tuesday':
      return 6;
      break;
    case 'wednesday':
      return 10;
      break;
    case 'thursday':
      return 5;
      break;
    case 'friday':
      return 6;
      break;
    case 'saturday':
      return 12;
      break;
    case 'sunday':
      return 10;
      break;
    default:
      return 'invalid day!';
      break;
  }
}

const getActualSleepHours = () =>
  getSleepHours('monday') + getSleepHours('tuesday') +
  getSleepHours('wednesday') +
  getSleepHours('thursday') +
  getSleepHours('friday') + 
  getSleepHours('saturday') +
  getSleepHours('sunday');
 
const getIdealSleepHours = (hoursPerNight) => 
{
  let idealHours = 7*hoursPerNight;
  return idealHours;
}
const calculateSleepDebt = () => 
{
  let actualSleepHours = getActualSleepHours();
  let idealSleepHours = getIdealSleepHours(6);
  let sleepDebt = idealSleepHours - actualSleepHours;
  if (actualSleepHours === idealSleepHours) {
    console.log(`Hours slept = ${actualSleepHours}\nSleep Goal = ${idealSleepHours}\nHours needed to match Sleep Goal = ${sleepDebt}\n User has gotten a perfect amount of sleep!`)
  } else if (actualSleepHours >= idealSleepHours) {
    console.log(`Hours slept = ${actualSleepHours}\nSleep Goal = ${idealSleepHours}\nHours needed to match Sleep Goal = ${sleepDebt}\nUser has slept more than is needed!`)
  } else if (actualSleepHours <= idealSleepHours) {
    console.log(`Hours slept = ${actualSleepHours}\nSleep Goal = ${idealSleepHours}\nHours needed to match Sleep Goal = ${sleepDebt}\nUser should get some more rest!`)
  }
}

// console.log(getSleepHours('friday'))
// console.log(getActualSleepHours())
calculateSleepDebt(10);
