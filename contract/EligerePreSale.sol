pragma solidity ^0.4.11;

import "./Eligere.sol";

contract EligerePreSale {
    Eligere public token;
    address public beneficiary;
    address public eligetokenteam;
    
    uint public amountRaised;
    
    uint public bonus;
    uint public price;    
    uint public minSaleAmount;

    function EligerePreSale(
        Eligere _token,
        address _beneficiary,
        address _eligetokenteam
    ) {
        token = Eligere(_token);
        beneficiary = _beneficiary;
        eligetokenteam = _eligetokenteam;
        bonus = 20;
        price = 0.001;
        minSaleAmount = 100000000;
    }

    function () payable {
        uint amount = msg.value;
        uint tokenAmount = amount * price;
        if (tokenAmount < minSaleAmount) throw;
        amountRaised += amount;
        token.transfer(msg.sender, tokenAmount * (100 + bonus) / 100);
    }

    function TransferETH(address _to, uint _amount) {
        require(msg.sender == beneficiary || msg.sender == eligetokenteam);
        _to.transfer(_amount);
    }

    function TransferTokens(address _to, uint _amount) {
        require(msg.sender == beneficiary || msg.sender == eligetokenteam);
        token.transfer(_to, _amount);
    }

    function ChangeBonus(uint _bonus) {
        require(msg.sender == beneficiary || msg.sender == eligetokenteam);
        bonus = _bonus;
    }
    
    function ChangePrice(uint _price) {
        require(msg.sender == beneficiary || msg.sender == eligetokenteam);
        price = _price;
    }
    
    function ChangeMinSaleAmount(uint _minSaleAmount) {
        require(msg.sender == beneficiary || msg.sender == eligetokenteam);
        minSaleAmount = _minSaleAmount;
    }
}
