const bcrypt = require("bcrypt");
const { FindDossierByRef } = require("../Services/DossierService");
const {} = require("../Services/UserService");
const { FindProblemById } = require("../Services/ProblemService");

const DeclareProblem = async (req, res) => {
  try {
    const { dossierID,problemType, description, date_prob,lieu } = req.body;

    console.log(dossierID,problemType, description, date_prob,lieu)
    const ExistingDossier = await FindDossierByRef(dossierID);

    if (!ExistingDossier) {
      throw new Error("Dossier not found ");
    }
    const ExistingProblem = await FindProblemById(ExistingDossier.problem);
    if (!ExistingProblem) {
      throw new Error("Problem not found ");
    }
    ExistingProblem.problem = true;
    ExistingProblem.problemType = problemType;
    ExistingProblem.description = description;
    ExistingProblem.date_Prob = new Date(date_prob)
    if (lieu.length > 0) {
      ExistingProblem.lieu = lieu;
    }

    

    await ExistingProblem.save();
    return res.json(ExistingProblem);
  } catch (error) {
    console.log(error.message )
    return res.status(400).json({ error: error.message });
  }
};
const AddDateNegotiation =async (req, res) => {
  try {
    const { Ref, date_negotiation } = req.body;

    console.log(Ref, date_negotiation)
    const ExistingDossier = await FindDossierByRef(Ref);

    if (!ExistingDossier) {
      throw new Error("Dossier not found ");
    }
    const ExistingProblem = await FindProblemById(ExistingDossier.problem);
    if (!ExistingProblem) {
      throw new Error("Problem not found ");
    }
    console.log(ExistingProblem,'aaaa')
    ExistingProblem.date_negotiation = date_negotiation;
    await ExistingProblem.save();
    console.log(ExistingProblem,'bbbbb')

    return res.json(ExistingProblem);
  } catch (error) {
    console.log(error.message )
    return res.status(400).json({ error: error.message });
  }
};
const AddDescriptionNegotiation =async (req, res) => {
  try {
    const { dossierID, description } = req.body;

    console.log(dossierID, description)
    const ExistingDossier = await FindDossierByRef(dossierID);

    if (!ExistingDossier) {
      throw new Error("Dossier not found ");
    }
    const ExistingProblem = await FindProblemById(ExistingDossier.problem);
    if (!ExistingProblem) {
      throw new Error("Problem not found ");
    }
    ExistingProblem.DescriptionNegotiation = description;
    await ExistingProblem.save();
    return res.json(ExistingProblem);
  } catch (error) {
    console.log(error.message )
    return res.status(400).json({ error: error.message });
  }
};
module.exports = {
  DeclareProblem,
  AddDateNegotiation,
  AddDescriptionNegotiation
};
