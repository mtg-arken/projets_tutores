const express = require("express");
const router = express.Router();
const RapportControllers = require("../Controllers/RapportController");

router.post("/CreateRapport/:dossierID", RapportControllers.CreateRapport);

module.exports = router;