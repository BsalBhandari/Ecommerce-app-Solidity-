// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ecommerce {


    // struct Laptop{
    //     uint productid;
    //     uint price;
    //     uint stock;
    // }

    uint256 public revenue;
    
    struct Product{
        uint product_price;
        uint product_stock;
    }

    Product[] public Products;


    constructor (
        uint laptop_price, uint laptop_stock , uint watch_price, 
        uint watch_stock, uint tv_price, uint tv_stock
        ){
        Products.push(Product(laptop_price,laptop_stock));
        Products.push(Product(watch_price,  watch_stock));
        Products.push(Product(tv_price, tv_stock));
    }

    function purchase (uint prod_id) public {
        if(prod_id == 1){
            Products[prod_id].product_price += revenue;
        } else if (prod_id ==2){
            Products[prod_id].product_price += revenue;
        }else {
            Products[prod_id].product_price += revenue;
        } 
    }

    function addItem(uint256 productId, uint256 quantity) public  {
        Products[productId].product_stock += quantity;
    }

    function increasePrice(uint256 productId, uint256 amount) public  {
        Products[productId].product_price += amount;
    }
}