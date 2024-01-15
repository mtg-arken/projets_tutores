const Dossier = require("../Models/DossierModel");
const Problem = require("../Models/ProblemModel");

const mongoose = require("mongoose");

const FindRapportById = (id) => {
  return Problem.findById(id)
};

module.exports = {
    FindRapportById
};
