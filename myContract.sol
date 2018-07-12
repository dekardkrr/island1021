pragma solidity ^0.4.24;
contract contrackZu {
    
    
    struct Prefs{
        uint256 kn; // уникальный ключ
        int kadCost; // характеристика
    }
    
    
    mapping(address => Prefs) prefs;
    mapping(uint256 => address) ownerOf;
    mapping (uint256 => int) kn_list;
    
    uint data = 0;
     event Transfer(address,address,uint);

    function create(uint256 _kn, int _kadCost) public returns (uint) {
        // создается новый ЗУ
        
        prefs[msg.sender].kn = _kn;
        prefs[msg.sender].kadCost = _kadCost;
        kn_list[prefs[msg.sender].kn] = prefs[msg.sender].kadCost;
        ownerOf[prefs[msg.sender].kn] = msg.sender;
        
        return prefs[msg.sender].kn;
    }
    

    function changeCadCost(uint256 _kn,int _newCost) public {
        // изменение характеристики
        kn_list[_kn] = _newCost;
        
    }
    
    function transfer(address _to, uint256 _kn) public{
        require(ownerOf[_kn] == msg.sender);
        ownerOf[_kn] = _to;
         emit Transfer(msg.sender, _to, _kn);
    }
    
     function demolishToken(uint256 _kn) public{
        require(ownerOf[_kn] == msg.sender);
        ownerOf[_kn] = address (0);
        
    }

}