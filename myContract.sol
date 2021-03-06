pragma solidity ^0.4.24;
// import "./ERC721Receiver.sol";
// import "./AdressUtils.sol";

contract ERC721Receiver {
  /**
   * @dev Magic value to be returned upon successful reception of an NFT
   *  Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`,
   *  which can be also obtained as `ERC721Receiver(0).onERC721Received.selector`
   */
  bytes4 internal constant ERC721_RECEIVED = 0x150b7a02;

  /**
   * @notice Handle the receipt of an NFT
   * @dev The ERC721 smart contract calls this function on the recipient
   * after a `safetransfer`. This function MAY throw to revert and reject the
   * transfer. Return of other than the magic value MUST result in the 
   * transaction being reverted.
   * Note: the contract address is always the message sender.
   * @param _operator The address which called `safeTransferFrom` function
   * @param _from The address which previously owned the token
   * @param _tokenId The NFT identifier which is being transfered
   * @param _data Additional data with no specified format
   * @return `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
   */
  function onERC721Received(
    address _operator,
    address _from,
    uint256 _tokenId,
    bytes _data
  )
    public
    returns(bytes4);
}


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

    

    function create(uint256 _kn, int _kadCost) public{
        // создается новый ЗУ
        kn_list[_kn] = _kadCost;
        ownerOf[_kn] = msg.sender;
        //return _kn;
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
