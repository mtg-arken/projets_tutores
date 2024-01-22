const {
  CreateNewDossier,
  FindDossierById,
  FindDossierByIdJuge,
  FindDossierByRef,
  FindDossierByIdPresident
} = require("../Services/DossierService");
const { FindUserById } = require("../Services/UserService");

const CreateDossier = async (req, res) => {
  try {
    const { reference, description, jury, dateAudience, president } = req.body;
    const ExistingUser = await FindUserById(president);
    if (!ExistingUser) {
      throw new Error("president de chambre not found ");
    }
    if (ExistingUser.role != "President de chambre") {
      throw new Error("User not allowed to create dossier ");
    }
    const ExistingJuge = await FindUserById(jury);
    if (!ExistingJuge) {
      throw new Error("juge not found ");
    }
    const dossier = await CreateNewDossier(
      reference,
      description,
      jury,
      dateAudience,
      president
    );
    console.log(dossier);
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
    console.log("aaaaa", JudgeId);
    const ExistingDossiers = await FindDossierByIdJuge(JudgeId);
    console.log(ExistingDossiers);

    // Transform the data before sending it to the client
    const transformedData = ExistingDossiers.map((dossier) => ({
      Refs: dossier.reference,
      Description: dossier.description,
      // Add more fields as needed
    }));

    return res.json(transformedData);
  } catch (error) {
    console.log(error.message);
    return res.status(400).json({ error: error.message });
  }
};
const GetPresidentDossiers = async (req, res) => {
  try {
    const { PresidentId } = req.body;
    const ExistingDossiers = await FindDossierByIdPresident(PresidentId);

    const transformedData = ExistingDossiers.map((dossier) => {
      console.log(dossier.problem.date_negotiation !== undefined); // Log each dossier
      return {
        Ref: dossier.reference,
        Problem: dossier.problem.problemType,
        status: dossier.problem.date_negotiation !== undefined ? true : false,
      };
    });

    return res.json(transformedData);
  } catch (error) {
    console.log(error.message);
    return res.status(400).json({ error: error.message });
  }
}


const GetDossierByRef = async (req, res) => {
  try {
    const { Ref } = req.body;
    console.log('reffff ',Ref)
    const ExistingDossier = await FindDossierByRef(Ref);
    if (!ExistingDossier) {
      throw new Error("Dossier not found");
    }
    console.log('zzzzzzzz ',ExistingDossier)

    if (ExistingDossier.problem.problem) {
      res.json({
        reference: ExistingDossier.reference,
        descriptionDossier: ExistingDossier.description,
        President_Chambre: ExistingDossier.juge1.userName,
        Juge: ExistingDossier.juge2.userName,
        Problem: ExistingDossier.problem.problem,
        problemType: ExistingDossier.problem.problemType,
        date_Prob: ExistingDossier.problem.date_Prob,
        lieu: ExistingDossier.problem.lieu,
        date_negotiation: ExistingDossier.problem.date_negotiation,
        status: ExistingDossier.valide,
      });
    } else {
      res.status(200).json({
        reference: ExistingDossier.reference,
        President_Chambre: ExistingDossier.juge1.userName,
        Juge: ExistingDossier.juge2.userName,
        Problem: ExistingDossier.problem.problem,
        descriptionDossier: ExistingDossier.description,
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
  GetPresidentDossiers
};
