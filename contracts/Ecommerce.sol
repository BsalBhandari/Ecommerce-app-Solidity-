// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ecommerce { 


    // struct Laptop{
    //     uint productid;
    //     uint price;
    //     uint stock;
    // }

    uint256 public revenue;
    address public owner;
    uint256 public contractBalance;

    struct Product{
        uint product_price;
        uint product_stock;
        uint totalPurchase;
    }

    struct Transaction{
        address customerAddress;
        uint productPurchasedId;
        uint noItemsPurchased;
        uint unitCost;
    }

    mapping(uint => Transaction) public transactions;
    uint public transactionCount;
    Product[] public Products;


    constructor (
        uint laptop_price, uint laptop_stock , uint watch_price, 
        uint watch_stock, uint tv_price, uint tv_stock
        ){
        owner = msg.sender;
        Products.push(Product(laptop_price,laptop_stock, 0));
        Products.push(Product(watch_price,  watch_stock, 0));
        Products.push(Product(tv_price, tv_stock, 0));
    }

    modifier onlyOwner(){
        require(msg.sender == owner , "you are not authorized");
        _;
    }

    function purchase (uint prod_id , uint quantity) public {
        if(prod_id == 1){
            Products[prod_id].product_price += revenue;
            Products[prod_id].product_stock -= 1;
            Products[prod_id].totalPurchase +=1;
        } else if (prod_id ==2){
            Products[prod_id].product_price += revenue;
            Products[prod_id].product_stock -= 1;
            Products[prod_id].totalPurchase +=1;
        }else {
            Products[prod_id].product_price += revenue;
            Products[prod_id].product_stock -= 1;
            Products[prod_id].totalPurchase +=1;
        } 
        uint transationId = transactionCount++;
        transactions[transationId] = Transaction(msg.sender , prod_id , quantity,Products[prod_id].product_price);
    }


    // function returnItems(uint productId, uint quantity, address customer_address)   public onlyOwner {
    //     uint refundAmount = Products[productId].product_price * quantity; 
    //     payable(customer_address).transfer(refundAmount);
    //     delete transactions[transationId];
    // }

    function returnItems(uint transcationId) public onlyOwner{
        uint refundAmount = transactions[transcationId].noItemsPurchased * transactions[transcationId].unitCost;
        payable(transactions[transcationId].customerAddress).transfer(refundAmount);
        delete transactions[transcationId]; 
    }

    function increasePrice(uint256 productId, uint256 amount) public  {
        Products[productId].product_price += amount;
    }

    function changePrice(uint256 productId, int256 value) public  {
        int newPrice = int(Products[productId].product_price) + value;
        Products[productId].product_price = uint(newPrice);
    }


    function addItem(uint256 productId, uint256 quantity) public  {
        Products[productId].product_stock += quantity;
    }

    function mostPopularProduct() public view returns (uint) {
        uint mostPopularProductId;
        uint maxTotalPurchase = 0;

        for (uint i =0; i < Products.length; i++){
            if(Products[i].totalPurchase > maxTotalPurchase){
                maxTotalPurchase = Products[i].totalPurchase;
                mostPopularProductId =i;
            }
        }
        return mostPopularProductId;
    }

    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        contractBalance += msg.value;
    }

    
    function sendDonation(address recipient) public onlyOwner {
        require(recipient != address(0), "Invalid recipient address");
        require(contractBalance > 0, "No balance to send");
        uint256 balanceToSend = contractBalance;
        contractBalance = 0;
        payable(recipient).transfer(balanceToSend);
    }
}