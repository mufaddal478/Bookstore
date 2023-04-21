const web3 = new Web3(Web3.givenProvider);
const contractAddress = 'CONTRACT_ADDRESS';
const contractAbi = CONTRACT_ABI;
const bookstore = new web3.eth.Contract(contractAbi, contractAddress);

const bookTable = document.getElementById('books');
const addBookForm = document.querySelector('form');
const titleInput = document.getElementById('title');
const authorInput = document.getElementById('author');
const priceInput = document.getElementById('price');
const stockInput = document.getElementById('stock');

// Load books from the contract and display them in the table
async function loadBooks() {
    bookTable.innerHTML = '';
    const bookCount = await bookstore.methods
