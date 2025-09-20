pragma solidity ^0.8.19;

interface IERC20 {
    function balanceOf(address) external view returns (uint256);
    function transfer(address to, uint256 amt) external returns (bool);
}

contract ClaimForwarder7702 {
    receive() external payable {}

    function _toEthSigned(bytes32 h) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", h));
    }

    function claimAndForward(
        address airdrop,
        bytes calldata claimCalldata,
        address token,
        address recipient,
        bytes32 salt,
        uint256 chainId,
        uint8 v, bytes32 r, bytes32 s
    ) external payable {
        bytes32 digest = _toEthSigned(
            keccak256(abi.encode(airdrop, keccak256(claimCalldata), token, recipient, salt, chainId))
        );
        require(ecrecover(digest, v, r, s) == address(this), "Bad owner sig");

        (bool ok, bytes memory ret) = airdrop.call(claimCalldata);
        require(ok, _bubble("Claim failed", ret));

        if (token == address(0)) {
            uint256 ethBal = address(this).balance;
            if (ethBal > 0) {
                (bool s2, ) = payable(recipient).call{value: ethBal}("");
                require(s2, "ETH forward failed");
            }
        } else {
            uint256 bal = IERC20(token).balanceOf(address(this));
            if (bal > 0) require(IERC20(token).transfer(recipient, bal), "ERC20 forward failed");
        }
    }

    function sweep(
        address token,
        address recipient,
        bytes32 salt,
        uint256 chainId,
        uint8 v, bytes32 r, bytes32 s
    ) external payable {
        bytes32 digest = _toEthSigned(keccak256(abi.encode(token, recipient, salt, chainId)));
        require(ecrecover(digest, v, r, s) == address(this), "Bad owner sig");

        if (token == address(0)) {
            uint256 ethBal = address(this).balance;
            if (ethBal > 0) {
                (bool ok, ) = payable(recipient).call{value: ethBal}("");
                require(ok, "ETH sweep failed");
            }
        } else {
            uint256 bal = IERC20(token).balanceOf(address(this));
            if (bal > 0) require(IERC20(token).transfer(recipient, bal), "ERC20 sweep failed");
        }
    }

    function _bubble(string memory, bytes memory ret) private pure returns (string memory) {
        if (ret.length < 4) return "execution failed";
        assembly {
            let size := mload(ret)
            revert(add(ret, 32), size)
        }
    }
}
