const hre = require("hardhat");


async function main() {
    const signers = await ethers.getSigners();
    const deployed = await hre.deployments.all();

    const Manager = await hre.ethers.getContractFactory("Manager");
    const manager = await Manager.attach(deployed.Manager.address);

    const Soulbound = await hre.ethers.getContractFactory("Soulbound");
    const soulbound = await Soulbound.attach(await manager.soulbound());

    console.log("[Event Listening] Manager:Matched");
    manager.on("Matched", (matchId, accountA, accountB) => {
        console.log(`[Event emitted] Manager:Matched(${matchId}, ${accountA}, ${accountB})`);
    });

    manager.createMatch(signers[0].address, signers[1].address);
    manager.createMatches(
        [signers[0].address, signers[1].address],
        [signers[2].address, signers[3].address],
    );
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
