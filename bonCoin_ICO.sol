// Initial ICO

pragma solidity ^0.6.6;

contract BonCoin_ico {
    
    uint256 constant public max_bonCoins = 1000000; //Maximum num of coins available for sell
    uint256 constant public gbp_to_bonCoins = 1000; //GBP to BonCoins conversion rate
    uint256 public total_bonCoins_bought = 0;

    //Mapping from the investor address to its equity in BonCoins and GBP
    mapping(address => uint) equity_bonCoins;
    mapping(address => uint) equity_gbp;

    modifier can_buy_boncoins(uint gbp_invested){     // Checking to see whether an investor can buy boncoins
        require (gbp_invested * gbp_to_bonCoins + total_bonCoins_bought <= max_bonCoins);
        _;
    }
    
    //Equity in bonCoins of an investor
    function get_equity_in_bonCoins(address investor) external view returns (uint) {
        return equity_bonCoins[investor];
    }
    
    //Eauity in GBP of an investor
    function get_equity_in_gbp(address investor) external view returns (uint) {
        return equity_gbp[investor];
    }
    
    function buy_bonCoins(address investor, uint gbp_invested) external
    can_buy_boncoins(gbp_invested) {
        uint bonCoins_bought = gbp_invested * gbp_to_bonCoins;
        equity_bonCoins[investor] += bonCoins_bought;
        equity_gbp[investor] = equity_bonCoins[investor] / gbp_to_bonCoins;
        total_bonCoins_bought += bonCoins_bought;
    }
    
    function sell_bonCoins(address investor, uint bonCoins_sold) external {
        equity_bonCoins[investor] -= bonCoins_sold;
        equity_gbp[investor] = equity_bonCoins[investor] / gbp_to_bonCoins;
        total_bonCoins_bought -= bonCoins_sold;
    }
    
    
}