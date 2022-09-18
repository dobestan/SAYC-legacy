const hre = require("hardhat");


async function main() {
    const deployed = await hre.deployments.all();

    const Manager = await hre.ethers.getContractFactory("Manager");
    const manager = await Manager.attach(deployed.Manager.address);

    const Soulbound = await hre.ethers.getContractFactory("Soulbound");
    const soulbound = await Soulbound.attach(await manager.soulbound());

    console.log(`Manager contract deployed to: ${manager.address}`);
    console.log(`Soulbound contract deployed to: ${soulbound.address}`);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
