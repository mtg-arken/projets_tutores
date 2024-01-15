const express = require("express");
const router = express.Router();
const DossierControllers = require("../Controllers/DossierController");

router.post("/CreateDossier/:userID", DossierControllers.CreateDossier);
router.post("/FixDateJ/:dossierID", DossierControllers.FixDateJ);

module.exports = router;