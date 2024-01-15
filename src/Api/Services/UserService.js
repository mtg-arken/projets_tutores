const User = require("../Models/UserModel");

const mongoose = require("mongoose");

const FindUserById = (id) => {
  return User.findById(id).select("-password");
};
const FindUserByCin = (cin) => {
  return User.findOne({ cin: cin });
};
const CreateNewUser = (Password,Email,UserName,Cin,Role,telephone) => {
  
  return User.create({
    userName:UserName,
    password:Password,
    email:Email,
    cin:Cin,
    role:Role,
    telephone:telephone
  });
};

module.exports = {
  FindUserByCin,
  FindUserById,
  CreateNewUser
};
