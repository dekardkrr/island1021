pragma solidity ^0.4.24;
// import "./AdressUtils.sol";
import "./ERC721Receiver.sol";


contract contracktZu {
    
    bytes4 private constant ERC721_RECEIVED = 0x150b7a02;
    
    struct Prefs{
        uint256 kn; // уникальный ключ
        int kadCost; // характеристика
    }
    
    
    mapping(address => Prefs) prefs;
    mapping(uint256 => address) ownerOf;
    mapping (uint256 => int) kn_list;
    
    uint data = 0;
     event Transfer(address,address,uint);
     event externalTransfer(address,address,uint);

    

    function create(uint256 _kn, int _kadCost) public returns (uint256) {
        // создается новый ЗУ
        
        prefs[msg.sender].kn = _kn;
        prefs[msg.sender].kadCost = _kadCost;
        kn_list[prefs[msg.sender].kn] = prefs[msg.sender].kadCost;
        ownerOf[prefs[msg.sender].kn] = msg.sender;
        
        return prefs[msg.sender].kn;
    }
    
    function getInfo(uint256 _kn) public view returns (int) {
        return kn_list[_kn];
        
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
    
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) 
    public
  {
    require(ownerOf[_tokenId] == _from);
    safeTransferFrom(_from, _to, _tokenId);

    require(checkAndCallSafeTransfer(_from, _to, _tokenId));
  }
  
  function isContract(address addr) internal returns (bool) {
    uint size;
    assembly { size := extcodesize(addr) }
    return size > 0;
    }
  
  function checkAndCallSafeTransfer(address _from, address _to, uint256 _tokenId) internal returns (bool){
    if ( !isContract(_to)) {
      return true;
    }
    bytes4 retval = ERC721Receiver(_to).onERC721Received(msg.sender, _from, _tokenId, "");
    return (retval == ERC721_RECEIVED);
  }

    
    
   

}
