

contract version2{
    
    mapping (address=>uint256) public balanceOf;
    mapping (address=>mapping(address=>uint256)) public allowance;
    string public Tname;
    string public Tsymbol;
    uint8 public decimal;
    uint256 total;
    address public owner;
    
    event Transfer(address indexed from,address indexed to,uint256 value);
    event Burn(address indexed from, uint256 value);
    
    function version2(string name, uint256 intial,string sy,uint8 d){
        Tname=name;
        Tsymbol=sy;
        decimal=d;
        total=intial;
        owner=msg.sender;
        balanceOf[msg.sender]=intial;
    }
    
    function _transfer(address _from, address _to, uint256 _value) internal{
        
        require(balanceOf[_from]>=_value);
        require(_to !=0x0);
        require(balanceOf[_to]+_value>=balanceOf[_to]);
        balanceOf[_from]-=_value;
        balanceOf[_to]+=_value;    
        emit Transfer(_from,_to,_value);
    }
    
    function transfer(address _to,uint256 _value)public returns(bool success){
        _transfer(msg.sender,_to,_value);
        return true;
    }
    
    // mint token to add the increase the total supply
    function mintToken(address _to,uint256 _mintAmount) restricted{
        balanceOf[_to]+=_mintAmount;
        total+=_mintAmount;
        emit Transfer(0,msg.sender,_mintAmount);
        emit Transfer(msg.sender,_to,_mintAmount);
    }
    function transferFrom(address _from,address _to,uint256 _value) public returns(bool success)
    {
        require(_value<=allowance[_from][_to]);
        allowance[_from][_to]-=_value;
        _transfer(_from,_to,_value);
        return true;
    }
    function approve(address _to,uint256 _value)public returns(bool success){
        allowance[msg.sender][_to]=_value;
        return true;
        
    }
    // burn the tokens that are existed more
    function burn(uint256 _value)public returns(bool success){
        require(balanceOf[msg.sender]>=_value);
        balanceOf[msg.sender]-=_value;
        total-=_value;
        emit Burn(msg.sender,_value);
        return true;
    }
    function burnFrom(address _from,uint256 _value) public returns(bool success){
        require(balanceOf[_from]>=_value);
        require(_value<=allowance[_from][msg.sender]);
        balanceOf[_from]-=_value;
        allowance[_from][msg.sender]-=_value;
        total-=_value;
        emit Burn(msg.sender,_value);
        return true;
    }
    modifier restricted{
        require(msg.sender==owner);
        _;
    }
    
}
