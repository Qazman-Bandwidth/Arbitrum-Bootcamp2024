// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20Permit {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 val,
        bytes32 r,
        bytes32 s
    ) external;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract GaslessTokenTransfer {
    
    function sendToken(
        address token,
        address sender,
        address receiver,
        uint256 amount,
        uint256 fee,
        uint256 deadline,

        // Permit signatures 
        uint8 val,
        bytes32 r,
        bytes32 s
    ) external {
        // Permit
        IERC20Permit(token).permit(
            sender,
            address(this),
            amount + fee,
            deadline,
            val,
            r,
            s
        );
        // Vulnerable to reentrancy attack
        
        (bool success, ) = receiver.call{value: amount}("");
        require(success, "Transfer failed try again!");
        
        IERC20Permit(token).transferFrom(sender, msg.sender, fee);
    }
}
