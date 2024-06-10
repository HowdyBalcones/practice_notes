import { toggleHiddenElement, changeToFunkyColor } from '../modules/index.js';
const buttonElement = document.getElementById('secret-button');
const pElement = document.getElementById('secret-img');

buttonElement.addEventListener('click', () => {
	toggleHiddenElement(pElement);
//	changeToFunkyColor(buttonElement);
});
