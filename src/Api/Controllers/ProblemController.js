const bcrypt = require("bcrypt");
const { FindDossierById } = require("../Services/DossierService");
const {} = require("../Services/UserService");
const { FindProblemById } = require("../Services/ProblemService");

const DeclareProblem = async (req, res) => {
  try {
    const { problemType, description, date_prob } = req.body;
    const dossierID = req.params.dossierID;

    const ExistingDossier = await FindDossierById(dossierID);
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
    console.log("problemType:", problemType);
    problemType === "audiance"
      ? (ExistingProblem.date_audiance = new Date(date_prob))
      
      : (ExistingProblem.date_negociation = new Date(date_prob));

    await ExistingProblem.save();
    return res.json(ExistingProblem);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};
module.exports = {
  DeclareProblem,
};
