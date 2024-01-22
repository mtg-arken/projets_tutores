const express = require("express");
const router = express.Router();
const ProblemControllers = require("../Controllers/ProblemController");

router.post("/DeclareProblem", ProblemControllers.DeclareProblem);
router.post("/AddDateNegotiation", ProblemControllers.AddDateNegotiation);
router.post(
  "/AddDescriptionNegotiation",
  ProblemControllers.AddDescriptionNegotiation
);

module.exports = router;
