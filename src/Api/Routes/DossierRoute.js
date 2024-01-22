const express = require("express");
const router = express.Router();
const DossierControllers = require("../Controllers/DossierController");

router.post("/CreateDossier", DossierControllers.CreateDossier);
router.post("/FixDateJ/:dossierID", DossierControllers.FixDateJ);
router.post("/GetJudgeDossiers", DossierControllers.GetJudgeDossiers);
router.post("/GetPresidentDossiers", DossierControllers.GetPresidentDossiers);

router.post("/GetDossierByRef", DossierControllers.GetDossierByRef);

module.exports = router;