const express = require("express");
const router = express.Router();
const ProblemControllers = require("../Controllers/ProblemController");

router.post("/DeclareProblem/:dossierID", ProblemControllers.DeclareProblem);

module.exports = router;