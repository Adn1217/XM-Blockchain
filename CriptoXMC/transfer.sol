// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract MainXM {
    IERC20 public token;
    constructor(address _token) {
        token = IERC20(_token);
    }

    mapping (uint256 => uint256) public transfers;
    function deposit(
        address _sender,
        uint256 _amount,
        uint256 _idTrx
    ) external {
        bool transferSuccess = token.transferFrom(
            _sender,
            address(this),
            _amount
        );
        transfers[_idTrx] = _amount;
        require(transferSuccess, "Transfer to contract failed");
    }
}
