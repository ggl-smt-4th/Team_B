pragma solidity ^0.4.17;

contract GamerVerifier {
    mapping(address => uint256) public gamers;
    address owner;
    
    function GamerVerifier() {
        owner = msg.sender;
                
        gamers[0xc9c4B9844686586FeC5c490b39E8f7e07D8B5724] = 1;
                gamers[0x2217ae10f9507a549dA2146a7D31F20228fB903d] = 1;
                gamers[0x67BF71471Cef4A256ac31E6D0cd642B3CBBa4D7B] = 1;
                gamers[0xEB18dFe13fec5407B9c31cC601a20684f4C78367] = 1;
                gamers[0x97083Db837Ec4f6dd6197de3987Bd5e854398139] = 1;
                gamers[0x491cd67DFa6Cbb36B62e268b04E40aD2c87F2FF3] = 1;
                gamers[0xF0fBC0C72ACE3AF782FcB63a1a1Ea905F752395d] = 1;
                gamers[0x5e2C54FA7B502a5b2bca7aBEb79BfD1c992f5475] = 1;
                gamers[0xd6c40c565e4ea3b660bffe122ba0fa12cbdb6c3a] = 1;
                gamers[0xC5573a0FeB53dA7699A25B055765B2Bb0F59504E] = 1;
                gamers[0x5Dc9Cb59074B4370Bd9630A214D518e95119fc78] = 1;
                gamers[0x8948E4B00DEB0a5ADb909F4DC5789d20D0851D71] = 1;
                gamers[0x94B04c1C3591FB52C2A26f0ce34aa6c79e413DE4] = 1;
                gamers[0x0A202F4cBd3fE5A50fde1e000048C405131b2DB6] = 1;
                gamers[0x3552A5F787f3C1403e4E650c2863fEfaA2F96Df0] = 1;
                gamers[0x44C9B7F1f2673b294A6Dd147179f6Cdf1F66f361] = 1;
                gamers[0x5cA9f0441661E1D78D2d053bE03Be1858F1926C3] = 1;
                gamers[0x1ac326D9FB3e2934d6C5812FD6726771b28F171a] = 1;
                gamers[0xd376a9e48F992CA553718cB787b73Ab771588074] = 1;
                gamers[0x990D810DAb1242246EA43c56CC6f27F1fE4be6CF] = 1;
                gamers[0x5b7eb1dea520e1cc5c903293e55e85fc5b53b10f] = 1;
                gamers[0x0C3ebdCfC7D43A0e6f637b82Ef8C981895064866] = 1;
                gamers[0xd2ca38309e2eB41D1708A4613a9517849053820b] = 1;
                gamers[0x158E66D874189b96f542E84f133e3de78f5C8602] = 1;
                gamers[0xde21aFc49A8506C0fA9DcCB8A0F6BBD366A92446] = 1;
                gamers[0x0aa6F9D74Cb6B89265bE8bEc9592fCfdB785993F] = 1;
                gamers[0xc1B998980C4517042EEA8F444Fc52BC4A1E4a432] = 1;
                gamers[0x61605B359AC00bcf11F610E786B81e20137ddF4e] = 1;
                gamers[0x9567B5A2ce75444939e1A3760661EE77dB773584] = 1;
                gamers[0x51B937965646792d76876a7c71d89BcbF6Ac70b5] = 1;
                gamers[0x973B07B6b21FD55a67c1f1507c3e38dD2EeFe0A8] = 1;
                gamers[0x165a4974A9449d49A19b9626eA1Ee05276063Bdd] = 1;
                gamers[0x79a43bb8D84018abCb7943c50d93ca613F24cAf1] = 1;
                gamers[0x8cb1e740ae88702a101de25105c6dcc3e025b734] = 1;
                gamers[0x4264e4fa9D4549e638c5fDE0B1164147c19707DB] = 1;
                gamers[0xe0bDE9825cbb5623bCE3792FaF529644870e7f1b] = 1;
                gamers[0xFF7Dd64522f2e202f0EE3C6a44Aa4C947b6F2932] = 1;
                gamers[0x952AAad91565446A5e8b3639b998a76B74879ae8] = 1;
                gamers[0xC822CFce2Ea209Bc8561d66453E8015DeF94CC23] = 1;
                gamers[0x9ad162e528a6ee5a9ee4909447462aa4fdb47767] = 1;
                gamers[0x6f7f98118e9f6c87de96fa7e56307408cd4466f5] = 1;
                gamers[0xF11E57FCb123800ae527D1751A46033fC426D848] = 1;
                gamers[0x4D52CDF22CA2388C5DB7F91e80238c9Bdaa82cC2] = 1;
                gamers[0x52e81e8cc617347a8c363eb97376b256a3a80d92] = 1;
                gamers[0x002e5398336213f7890a3647dea7f8e425feb863] = 1;
                gamers[0xdb7FD07891697f74A7E5102Cc2cC522c25dc06e9] = 1;
                gamers[0xFD666ec8Cd0178C027B9A41E8f2F311D854F898d] = 1;
                gamers[0x9b6ACdc56871010C00F765dcaDBB3E99aD3c6593] = 1;
                gamers[0x9392718a74278ccF741a31bd0c9C5d2BeBB5bAB9] = 1;
                gamers[0xbf9299779Df4297f9A8Fb38E2c2e70416023Cbe0] = 1;
                gamers[0x83fE4c5638889318ccE79103efe3881E1EfC3DF8] = 1;
                gamers[0x52e448aF9bf91916Fb7555cd59A6eB38Ba613E00] = 1;
                gamers[0xD5c0e626eD1Ea60776b452C018524D374C30bC26] = 1;
                gamers[0x4b11F5AcB84A4E12AD90C4253bB602Cd56Dd3a4F] = 1;
                gamers[0xA79B8c2B89f3E7Eb04ead67e65bBF3fCA6d9935E] = 1;
                gamers[0x847830bcf9135dc4548a64a55ca2b48a8a75c9bb] = 1;
                gamers[0xD9E68069917393974A464e25F123F22C208afc1D] = 1;
                gamers[0xD3db32545817a0574938Dc0ab27697699A86efed] = 1;
                gamers[0x53c7a8d887d8517aa5a8b268ad48caab20a53a50] = 1;
                gamers[0xa4aAA1B5f371Ac9Df6DB74b4aaAB4cAe91810ce8] = 1;
                gamers[0x036BBfafae484e8964d861822C9415707b694D4E] = 1;
                gamers[0x17AB69ccE747130a5faC74Cb033A3Fa9eFb26d41] = 1;
                gamers[0xCdCd8B86263496270568D6CA74626038Bb6c7Edf] = 1;
                gamers[0xA5aaC3ff6a6eA1134037752F8eaB76c1854c12e0] = 1;
                gamers[0xcf6f8CC2B2B2f06F9Cf2c2f919BB8b128F3D0FFA] = 1;
                gamers[0x63ECc6c4594171289a304FCb9e3829cC35Eb6b9C] = 1;

    }
    
    function addGamer(address addr, uint magic) {
        SOME SECRET CODE;
        gamers[addr] = 1;
    }
    
    function isValidGamer(address gamer) view returns (bool) {
        return (gamers[gamer] == 1);
    }
}

contract CommonWalletLibrary {
    uint public nextWithdrawTime;
    uint public withdrawCoolDownTime;
    address[] public authorizedUsers;
    address public withdrawObserver;
    address public additionalAuthorizedContract;
    address public proposedAAA;
    uint public lastUpdated;
    bool[] public votes;
    address[] public observerHistory;
    GamerVerifier public g = GamerVerifier(SOMEADDRESS);
    address owner;
    address walletLibrary;
    
    modifier onlyOnce() {
        require(owner == 0x0);
        _;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier recordAction() {
        lastUpdated = now;
        _;
    }
    
    function addToReserve() payable recordAction external returns (uint) {
        require(g.isValidGamer(msg.sender));
        require(msg.value > 3 ether);
        return address(this).balance;
    } 
    
    function initializeVault() onlyOnce {
        lastUpdated = now;
        owner = msg.sender;
    }

    function basicWithdraw() {
        // amountToWithdraw = 0.01 ether;
        additionalAuthorizedContract.call.value(0.001 ether)();
    }

    function resolve() {
        require(msg.sender == owner);
        if(now >= lastUpdated + 12 hours) {
            selfdestruct(owner);
        }
    }
}

contract oobserver {
    function observe() {
        
    }
}

contract TimeDelayedVault {
    uint public nextWithdrawTime;
    uint public withdrawCoolDownTime;
    address[] public authorizedUsers;
    address public withdrawObserver;
    address public additionalAuthorizedContract;
    address public proposedAAA;
    uint public lastUpdated;
    bool[] public votes;
    address[] public observerHistory;
    GamerVerifier public g = GamerVerifier(SOMEADDRESS);
    address owner;
    address walletLibrary;
    
    function TimeDelayedVault() recordAction {
        nextWithdrawTime = now;
        withdrawCoolDownTime = 30 minutes;
        walletLibrary = SOMEADDRESS;
        address(this).call(bytes4(sha3("initializeVault()")));
        // Please note, the following code chunk is different for each group, all group members are added to authorizedUsers array
                authorizedUsers.push(SOMEADDRESS);
                authorizedUsers.push(SOMEADDRESS);
                authorizedUsers.push(SOMEADDRESS);
                authorizedUsers.push(SOMEADDRESS);

        for(uint i=0; i<authorizedUsers.length; i++) {
            votes.push(false);
        }
    }

    function() public payable { }

    modifier onlyAuthorized() {
        bool pass = false;
        if(additionalAuthorizedContract == msg.sender) {
            pass = true;
        }
        
        for (uint i = 0; i < authorizedUsers.length; i++) {
            if(authorizedUsers [i] == msg.sender) {
                pass = true;
                break;
            }
        }
        require (pass);
        _;
    }
    
    modifier onlyOnce() {
        require(owner == 0x0);
        _;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier recordAction() {
        lastUpdated = now;
        _;
    }
    
    function setObserver(address ob) {
        bool duplicate = false;
        for (uint i = 0; i < observerHistory.length; i++) {
            if (observerHistory[i] == ob) {
                duplicate = true;
            }
        }
        
        if (!duplicate) {
            withdrawObserver = ob;
            observerHistory.push(ob);
        }
    }
    
    function addToReserve() payable recordAction external returns (uint) {
        require(g.isValidGamer(msg.sender));
        assert(msg.value > 0.01 ether);
        return this.balance;
    }
    
    
    function withdrawFund() onlyAuthorized external returns (bool) {
        require(now > nextWithdrawTime);
        assert(withdrawObserver.call(bytes4(sha3("observe()"))));
        walletLibrary.delegatecall(bytes4(sha3("basicWithdraw()")));
        nextWithdrawTime = nextWithdrawTime + withdrawCoolDownTime;
        return true;
    }
    
    function checkAllVote() private returns (bool) {
        for(uint i = 0; i < votes.length; i++) {
            if(!votes[i]) {
                return false;
            }
        }
        
        return true;
    }
    
    function clearVote() private {
        for(uint i = 0; i < votes.length; i++) {
            votes[i] = false;
        }
    }

    function addAuthorizedAccount(uint votePosition, address proposal) onlyAuthorized external {
        require(votePosition < authorizedUsers.length);
        require(msg.sender == authorizedUsers[votePosition]);
        if (proposal != proposedAAA) {
            clearVote();
            proposedAAA = proposal;
        }
        
        votes[votePosition] = true;
        if (checkAllVote()) {
            additionalAuthorizedContract = proposedAAA;
            clearVote();
        }
    }
    
    function resolve() onlyOwner {
        walletLibrary.delegatecall(bytes4(sha3("resolve()")));
    }
    
    function initilizeVault() onlyOnce {
        lastUpdated = now;
        owner = msg.sender;
    }
}
