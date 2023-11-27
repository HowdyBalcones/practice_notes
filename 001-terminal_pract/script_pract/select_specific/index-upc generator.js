//Mini test - Construct array of Item #'s as strings
//create variable for UPC constants
//concatenate the two, return in new array
//make an object from an item #
//success

// let advilRegArr = ["01786","01790","01791","11794","21794"]
// let advilRegArr2 = [];
// let upcConstants = "655708"

// // let "01786" = {
// // name:"Advil Regular"
// // packType:"Dispenser"
// // count:50
// // }

// function addUpcConstants(){
// 	for (let i = 0;i<advilRegArr.length;i++)
// 		advilRegArr2.push(upcConstants+advilRegArr[i])
// 	console.log(advilRegArr2)
// }

// addUpcConstants()


//big test - create check digit >:(
//using charAt(), check if 
//return each odd index in a string, return each even index in a string

// let string1 = "65570821794"
// let stringArrEven = [];
// let stringArrOdd = [];

// // console.log(string1)

// // console.log(string1[3])

// // console.log(string1.charAt(0))

// //now to add the even and odd piles together somehow

// function checkString(){
// 	for (let i = 0;i<string1.length;i++)
// 	{ let stringNum = string1[i]
// if (stringNum%2==0){ //this tests if the value in the array is even or odd
// stringArrEven.push(stringNum)} else {
// 	stringArrOdd.push(stringNum)
// }

// }

// }



// checkString()
// console.log(stringArrEven)
// console.log(stringArrOdd)

//Obvious use Cases that prove this is worth the time

let string1 = "65570821794"
let stringArrEven = []
let stringArrOdd = []
let evenConstants = [1,3,5,7,9]
let oddConstants = [0,2,4,6,8,10]


function checkStringEven(){

	for (let i = 0;i<5;i++)

	stringArrEven.push(string1[evenConstants[i]])
}

function checkStringOdd(){
	for (let i = 0;i<6;i++)
	stringArrOdd.push(string1[oddConstants[i]])
}

// using the reduce method add up the even and odd arrays, multiply the odd array sum by 3,
//add it to the sum of the even array, that number is the check digit

checkStringEven()
sumEven = stringArrEven.reduce(function(passedIn,item){
	return passedIn+item
},0);
console.log(sumEven)


stringArrEven.forEach(function(item,index,array){
	parsed = parseInt(item,10);
	console.log(parsed)
})







// console.log(stringArrEven.reduce(addStringBucketEven,1))

// function addStringBucketEven(total,num){
// 	return total+num
// }


checkStringOdd()
console.log(stringArrEven)
console.log(stringArrOdd)


































