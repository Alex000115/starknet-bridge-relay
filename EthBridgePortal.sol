// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IStarknetMessaging.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EthBridgePortal is Ownable {
    IStarknetMessaging public immutable messagingContract;
    uint256 public l2TokenBridgeAddress;
    uint256 public constant DEPOSIT_SELECTOR = uint256(keccak256("handle_deposit"));

    event DepositInitiated(address indexed sender, uint256 l2Address, uint256 amount);

    constructor(address _messagingContract) Ownable(msg.sender) {
        messagingContract = IStarknetMessaging(_messagingContract);
    }

    function setL2Bridge(uint256 _l2Address) external onlyOwner {
        l2TokenBridgeAddress = _l2Address;
    }

    function deposit(address _token, uint256 _amount, uint256 _l2Recipient) external payable {
        IERC20(_token).transferFrom(msg.sender, address(this), _amount);

        uint256[] memory payload = new uint256[](3);
        payload[0] = uint256(uint160(_token));
        payload[1] = _amount;
        payload[2] = _l2Recipient;

        messagingContract.sendMessageToL2{value: msg.value}(
            l2TokenBridgeAddress,
            DEPOSIT_SELECTOR,
            payload
        );

        emit DepositInitiated(msg.sender, _l2Recipient, _amount);
    }
}
