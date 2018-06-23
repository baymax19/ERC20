// This is the Version V1
contract version1{
    
    mapping(address=>uint256) balanceOf;
     string public name;
    string public symbol;
    uint8 public decimals;
    
    
    event Transfer(address indexed from, address indexed to, uint256 value);

    
    function version1(uint256 iS, string tName, string tSymbol,uint8 decimal) public
      {
          balanceOf[msg.sender]=iS;
          name=tName;
          symbol=tSymbol;
          decimals=decimal;
      }
      function transfer(address _to,uint256 _value)public{
        require(balanceOf[msg.sender] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender]-=_value;
        balanceOf[_to]+=_value;

      }
}
