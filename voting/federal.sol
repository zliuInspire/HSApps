pragma solidity 0.4.22;

contract Federal {
    
    address public manager;
    mapping (string => uint256) public collectedVotes;
    uint256 public totalVotes;

    uint constant public MAX_OWNER_COUNT = 50;
    uint constant public MAX_VALUE_PROPOSAL_COUNT = 5;
    
    // The authorative ouput provided by this Broker contracts.
    uint public genuineValue;
    
    // The Broker contract is owned by multple entities to ensure security. 
    mapping (address => bool) public isOwner;
    address[] public owners;
    uint public requiredOwnerCount;
    
    // Votes by the owners for a specific price value.
    mapping (uint => mapping (address => bool)) public valueVotes;
    uint[] public valueProposals;
    
    // Maps used for adding and removing owners. 
    mapping (address => mapping (address => bool)) public addingOwnerProposal;
    mapping (address => mapping (address => bool)) public removingOwnerProposal;
    
    modifier managerOnly(address _sender) {
        require(_sender == manager);
        _;
    }
    
    modifier validRequirement(uint ownerCount, uint _requiredOwner) {
        require(ownerCount < MAX_OWNER_COUNT);
        require(_requiredOwner <= ownerCount);
        require(_requiredOwner != 0);
        require(ownerCount != 0);
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
