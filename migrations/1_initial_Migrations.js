const Migrations = artifacts.require("Migrations");

module.exports = async function (deployer) {
    console.log("Deploying Migrations contract...");
    await deployer.deploy(Migrations);
    console.log("Migrations contract deployed!");
};
