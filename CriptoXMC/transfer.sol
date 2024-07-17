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
    IERC20 public token; // Token tipo IERC20, banco o "XMCOP".
    address public owner;

    constructor(address _token, address initialOwner) {
        owner = initialOwner;
        token = IERC20(_token); // Se inicializa variable Token (direción del contrato).
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner");
        _;
    }

    mapping (uint256 => uint256) public transfers;
    function deposit(
        address _sender,
        uint256 _amount,
        uint256 _idTrx // Id de transacción.
    ) external {
        bool transferSuccess = token.transferFrom(
            _sender,
            address(this), // Dirección de este contrato.
            _amount
        );
    require(transferSuccess, "Transfer to contract failed");
        transfers[_idTrx] = _amount;
    }

    function withdraw (address _receiver, uint256 _amount) public onlyOwner {
        bool transferSuccess = token.transfer(_receiver, _amount);
        require(transferSuccess, "Transfer to user failed");
    }
}
