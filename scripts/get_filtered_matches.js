const hre = require("hardhat");


async function main() {
    const signers = await ethers.getSigners();
    const deployed = await hre.deployments.all();

    const Manager = await hre.ethers.getContractFactory("Manager");
    const manager = await Manager.attach(deployed.Manager.address);

    const Soulbound = await hre.ethers.getContractFactory("Soulbound");
    const soulbound = await Soulbound.attach(await manager.soulbound());

    // Query Historic Events
    // https://docs.ethers.io/v5/getting-started/#getting-started--history
    const filterMatched = manager.filters.Matched(
        null,
        signers[0].address,
        null,
    );
    const matchedEvents = await manager.queryFilter(filterMatched);

    console.log(`Total Matched Result: ${matchedEvents.length}`);
    matchedEvents.forEach(async (matchedEvent) => {
        console.log(`Matched with ${matchedEvent.args.accountB} via Match#${matchedEvent.args.matchId}`);
    });
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
