// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface QazmanTokenInterface {
    


    function totalSupply() external view returns (uint256);
    function balanceOf(address owner) external view returns (uint256 balance);
    function allowance(address owner, address spender) external returns (uint256 remaining);
    function transfer(address recipient, uint256 amount) external returns (bool success);
    function approve(address spender, uint256 amount) external returns (bool success);
    function transferFrom(address spender, address recipient, uint256 amount) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 value); 
    event Approval(address indexed owner, address indexed spender, uint256 value);

}


contract QazToken is QazmanTokenInterface {

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public _totalSupply;
    
    // mapping address to the balance of the minted token
    mapping(address => uint256) balances;

    // mapping each user addresses to the address of the token owner
    mapping(address => mapping(address => uint256)) allowed;

    // Initiallizing all variable needed for the token
    constructor() {
        name = "Qazman Token";
        symbol = "QAZ";
        decimals = 18;
        _totalSupply = 1_500_000_000 * 10 ** 18; // minting 1.5 billion tokens
        balances[0xf7590697cd789BFfE8A0a585aBc8074005aC4De1] = _totalSupply;
        emit Transfer(address(0), 0xf7590697cd789BFfE8A0a585aBc8074005aC4De1, _totalSupply);
    }

    // Declaring functions to perform a task

    // Declaring and printing the total supply to be view outside
    function totalSupply () public view returns (uint256) {
        return _totalSupply - balances[address(0)];
    }

    // Declaring balances of array of accounts
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) public returns (bool success) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender,recipient, amount);
        return true;


    }

    
    function approve(address spender, uint256 amount) public returns (bool success) {
        allowed[msg.sender][spender] = amount;
        emit Transfer(msg.sender, spender, amount);
        return true;
    }

    
    function transferFrom(address spender, address recipient, uint256 amount) public returns (bool success) {
        require(balances[spender] >= amount, "Insufficient balance");
        balances[spender] -= amount;
        allowed[spender][msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(spender, recipient, amount);
        return true;        

    }

    function allowance(address owner, address spender) public view returns (uint256 remaining) {
        return allowed[owner][spender];
        
    }

}
