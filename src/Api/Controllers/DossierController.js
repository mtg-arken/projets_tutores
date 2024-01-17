const {
  CreateNewDossier,
  FindDossierById,
  FindDossierByIdJuge,
  FindDossierByRef,
} = require("../Services/DossierService");
const { FindUserById } = require("../Services/UserService");

const CreateDossier = async (req, res) => {
  try {
    const { reference, JugeID } = req.body;
    const userID = req.params.userID;
    const ExistingUser = await FindUserById(userID);
    if (!ExistingUser) {
      throw new Error("president de chambre not found ");
    }
    if (ExistingUser.role != "President de chambre") {
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
const GetJudgeDossiers = async (req, res) => {
  try {
    const { JudgeId } = req.body;
    const ExistingDossiers = await FindDossierByIdJuge(JudgeId);
    console.log(ExistingDossiers)

    return res.json(ExistingDossiers);
  } catch (error) {
    console.log(error.message);
    return res.status(400).json({ error: error.message });
  }
};
const GetDossierByRef = async (req, res) => {
  try {
    const { Ref } = req.body;

    const ExistingDossier = await FindDossierByRef(Ref);
    if (!ExistingDossier) {
      throw new Error("Dossier not found ");
    }
    
    if (ExistingDossier.problem.problem) {
      res.json({
        President_Chambre: ExistingDossier.juge1.userName,
        Juge: ExistingDossier.juge2.userName,
        Problem: ExistingDossier.problem.problem,
        problemType: ExistingDossier.problem.problemType,
        Date_Debut: ExistingDossier.date_debut,
        status: ExistingDossier.valide,
      });
    } else {
      res.status(200).json({
        President_Chambre: ExistingDossier.juge1.userName,
        Juge: ExistingDossier.juge2.userName,
        Problem: ExistingDossier.problem.problem,
        Date_Debut: ExistingDossier.date_debut,
        status: ExistingDossier.valide,
      });
    }
  } catch (error) {
    console.log(error.message);
    return res.status(400).json({ error: error.message });
  }
};
module.exports = {
  CreateDossier,
  FixDateJ,
  GetJudgeDossiers,
  GetDossierByRef,
};
