const { ethers } = require("ethers");

async function monitorBridgeEvents(portalContract) {
    console.log("Listening for L1 deposit events...");
    
    portalContract.on("DepositInitiated", (sender, l2Address, amount, event) => {
        console.log(`
            --- New Deposit ---
            From L1: ${sender}
            To L2: ${l2Address.toString(16)}
            Amount: ${ethers.formatEther(amount)} ETH
            Tx Hash: ${event.log.transactionHash}
        `);
    });
}

module.exports = { monitorBridgeEvents };
