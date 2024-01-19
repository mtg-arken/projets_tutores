const bcrypt = require("bcrypt");
const {
  createToken,
  createRefreshToken,
} = require("../../Config/GenerateToken");
const {  FindJurys } = require("../Services/UserService");

const getJurys = async (req, res) => {
  try {
    const ExistingJurys = await FindJurys();

    // Transform the ExistingJurys array to include only username and _id
    const simplifiedJurys = ExistingJurys.map(jury => ({
      username: jury.userName,
      _id: jury._id
    }));

    console.log(simplifiedJurys);
    res.status(200).send(simplifiedJurys);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal server error");
  }
};



module.exports = {
    getJurys
};
