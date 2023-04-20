// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BookStore {
    address payable public owner;
    uint public bookCount = 0;
    uint public booksSold =0;

    struct Book {
        uint id;
        string title;
        string author;
        uint price;
        uint stock;
        
    }
    struct Purchase{
        //uint id;
        address buyer;
        bool deliver;
    }

    mapping(uint => Book) public books;
    mapping (uint => Purchase) public purchases;
    event BookAdded(uint id, string title, string author, uint price, uint stock);
    event BookPurchased(uint id, uint price, uint stock);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    function addBook(string memory _title, string memory _author, uint _price, uint _stock) public onlyOwner {
        bookCount++;
        books[bookCount] = Book(bookCount, _title, _author, _price, _stock);
        emit BookAdded(bookCount, _title, _author, _price, _stock);
    }

    function purchaseBook(uint _id) public payable {
        require(books[_id].stock > 0, "The book is out of stock.");
        require(msg.value >= books[_id].price, "Insufficient payment.");

        books[_id].stock--;
        Purchase storage purchase = purchases[booksSold];
        purchase.buyer = msg.sender;
        booksSold++;
        owner.transfer(books[_id].price);

        emit BookPurchased(_id, books[_id].price, books[_id].stock);
    }

    function isAvailable(uint _id) public view returns(bool){

        if(books[_id].stock > 0){
            return true;
        }
        else{
            return false;
        }

    }

    function deliverBook(uint _id) public onlyOwner{
        Purchase storage purchase = purchases[_id];
        purchase.deliver = true;

    }

    function isDelivered(uint _id) public view returns(bool){
        Purchase storage purchase = purchases[_id];
        return purchase.deliver;

    }
}
