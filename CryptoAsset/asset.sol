pragma solidity 0.4.22;

contract CryptoAsset {
    uint256 public balance;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function deposit(uint256 _value) 
        public 
        payable 
        onlyOwner
    {
        if (_value > 0) {
            balance = safeAdd(balance, _value);
        }
    }

    function safeAdd(uint256 a, uint256 b) 
        internal 
        pure 
        returns (uint256 ) 
    {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}
