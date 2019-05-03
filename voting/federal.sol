pragma solidity 0.4.22;

contract Federal {
    
    address public manager;
    mapping (string => uint256) public collectedVotes;
    uint256 public totalVotes;
    
    modifier managerOnly(address _sender) {
        require(_sender == manager);
        _;
    }
    
    constructor() public
    {
        manager = msg.sender;
    }
    
    function submitVotes(string _district, uint256 _votes)
        public
        managerOnly(msg.sender)
    {
        assert(_votes > 0);
        collectedVotes[_district] = safeAdd(collectedVotes[_district], _votes);
        totalVotes = safeAdd(totalVotes, _votes);
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
