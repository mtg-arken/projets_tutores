const mongoose = require("mongoose");
const { isEmail, contains } = require("validator");
const { Schema } = mongoose;
//const bcrypt = require("bcrypt");

const DossierSchema = new Schema(
  {
    reference: {
      type: String,
      required: [true, "reference is required "],
      unique: true,
    },
    juge1: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    juge2: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    problem: { type: mongoose.Types.ObjectId, ref: "Problem", required: true },
    rapport: { type: mongoose.Types.ObjectId, ref: "Rapport", required: true },
    date_debut: { type: Date, default: Date.now },
    date_fin: { type: Date },
    valide: { type: Boolean, default: false },
  },
  { timestamps: true }
);

/*
UserSchema.pre("save", async function (next) {
  const salt = await bcrypt.genSalt();
  this.password = await bcrypt.hash(this.password, salt);
  next();
});
*/
module.exports = Dossier = mongoose.model("Dossier", DossierSchema);
