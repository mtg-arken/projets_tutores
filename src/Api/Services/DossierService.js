const Dossier = require("../Models/DossierModel");

const mongoose = require("mongoose");

const CreateNewDossier = (reference, userID, JugeID) => {
  return Dossier.create({
    reference: reference,
    juge1: userID,
    juge2: JugeID,
  });
};
const FindDossierById = (id) => {
  return Dossier.findById(id)
};

const FindDossierByIdJuge = (id) => {
  return Dossier.find({juge2:id})
};
module.exports = {
  CreateNewDossier,
  FindDossierById,
  FindDossierByIdJuge
};
