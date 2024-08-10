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
    address public withdrawalOwner;

    constructor(address _token, address initialOwner, address withdrawalInitialOwner) {
        owner = initialOwner;
        token = IERC20(_token); // Se inicializa variable Token (direción del contrato).
        withdrawalOwner = withdrawalInitialOwner; // Solo este usuario puede retirar saldo.
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner");
        _;
    }

    modifier onlyWithdrawalOwner(){
        require(msg.sender == withdrawalOwner, "Only withdrawal owner");
        _;
    }

    mapping (string => uint256) public transfers;
    mapping (string => string) public signatures;

    function deposit (
        address _sender,
        uint256 _amount,
        string calldata _idTrx, // Id de transacción.
        string calldata _signature // Firma de usuario.
    ) external onlyOwner {
        bool transferSuccess = token.transferFrom(
            _sender,
            address(this), // Dirección de este contrato.
            _amount
        );
    require(transferSuccess, "Transfer to contract failed");
        transfers[_idTrx] = _amount;
        signatures[_idTrx] = _signature;
    }

    function withdraw (address _receiver, uint256 _amount) public onlyWithdrawalOwner {
        bool transferSuccess = token.transfer(_receiver, _amount);
        require(transferSuccess, "Transfer to user failed");
    }
}
