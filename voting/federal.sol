pragma solidity 0.4.22;

contract Federal {
    
    address public manager;
    uint256 public collectedVotes;
    
    mapping (string => uint256) collectedVotesPerDistinct;

    
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
        collectedVotesPerDistinct[_district] = safeAdd(collectedVotesPerDistinct[_district], _votes);
        collectedVotes = safeAdd(collectedVotes, _votes);
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
