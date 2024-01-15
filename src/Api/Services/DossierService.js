const Dossier = require("../Models/DossierModel");

const mongoose = require("mongoose");

const FindUserById = (id) => {
  return User.findById(id).select("-password");
};
const FindUserByCin = (cin) => {
  return User.findOne({ cin: cin });
};
const CreateNewUser = (Password, Email, UserName, Cin, Role, telephone) => {
  return User.create({
    userName: UserName,
    password: Password,
    email: Email,
    cin: Cin,
    role: Role,
    telephone: telephone,
  });
};

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


module.exports = {
  CreateNewDossier,
  FindDossierById
};
