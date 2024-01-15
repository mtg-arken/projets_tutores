const bcrypt = require("bcrypt");
const { FindDossierById } = require("../Services/DossierService");
const {} = require("../Services/UserService");
const { FindProblemById } = require("../Services/ProblemService");
const { FindRapportById } = require("../Services/RapportService");

const CreateRapport = async (req, res) => {
  try {
    const { description } = req.body;
    const dossierID = req.params.dossierID;

    const ExistingDossier = await FindDossierById(dossierID);
    if (!ExistingDossier) {
      throw new Error("Dossier not found ");
    }

    const ExistingRapport = await FindRapportById(ExistingDossier.rapport);
    if (!ExistingRapport) {
      throw new Error("rapport not found ");
    }

    ExistingRapport.description = description;
    ExistingRapport.date_debut = ExistingDossier.date_debut;
    const NowDate = Date.now;
    ExistingRapport.date_fin = NowDate;
    ExistingDossier.date_fin = NowDate;
    ExistingDossier.valide = true;
    await ExistingDossier.save();
    await ExistingRapport.save();
    return res.json(ExistingRapport);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

module.exports = {
  CreateRapport,
};
