const Dossier = require("../Models/DossierModel");
const mongoose = require("mongoose");

const CreateNewDossier = ( reference, description , jury, dateAudience, president ) => {
  return Dossier.create({
    reference: reference,
    juge1: president,
    juge2: jury,
    date_audience:dateAudience,
    description:description
  });
};
const FindDossierById = (id) => {
  return Dossier.findById(id)
};

const FindDossierByIdJuge = (id) => {
  return Dossier.find({juge2:id})
};
const FindDossierByRef = (ref) => {
  return Dossier.findOne({reference:ref}).populate('juge1').populate('juge2').populate('problem')
};

module.exports = {
  CreateNewDossier,
  FindDossierById,
  FindDossierByIdJuge,
  FindDossierByRef
};
