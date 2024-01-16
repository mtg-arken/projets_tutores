const bcrypt = require("bcrypt");
const {
  createToken,
  createRefreshToken,
} = require("../../Config/GenerateToken");
const { CreateNewDossier ,FindDossierById} = require("../Services/DossierService");
const { FindUserById } = require("../Services/UserService");

const CreateDossier = async (req, res) => {
  try {
    const { reference, JugeID } = req.body;
    const userID = req.params.userID;
    const ExistingUser = await FindUserById(userID);
    if (!ExistingUser) {
      throw new Error("User not found ");
    }
    if (ExistingUser.role != "President juge") {
      throw new Error("User not allowed to create dossier ");
    }
    const ExistingJuge = await FindUserById(JugeID);
    if (!ExistingJuge) {
      throw new Error("juge not found ");
    }
    const dossier = await CreateNewDossier(reference, userID, JugeID);
    return res.json(dossier);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};
const FixDateJ = async (req, res) => {
  try {
    const { date_j } = req.body;
    const dossierID = req.params.dossierID;
    const ExistingDossier = await FindDossierById(dossierID);
    if (!ExistingDossier) {
      throw new Error("Dossier not found ");
    }
    ExistingDossier.date_j = date_j;
    await ExistingDossier.save();
    return res.json(ExistingDossier);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};
module.exports = {
  CreateDossier,
  FixDateJ,
};
