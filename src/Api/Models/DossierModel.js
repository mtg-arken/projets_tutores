const mongoose = require("mongoose");
const { Schema } = mongoose;
const Problem = require("../Models/ProblemModel");
const moment = require("moment");
const date = new Date();

const DossierSchema = new Schema(
  {
    reference: {
      type: String,
      required: [true, "reference is required "],
      unique: true,
    },
    description: { type: String },
    juge1: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    juge2: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    problem: { type: mongoose.Types.ObjectId, ref: "Problem" },
    rapport: { type: mongoose.Types.ObjectId, ref: "Rapport" },
    date_audience: { type: String, required: true },
    date_fin: { type: Date },
    date_j: { type: Date },
    valide: { type: Boolean, default: false },
  },
  { timestamps: true }
);

DossierSchema.pre("save", async function (next) {
  try {
    if (!this.problem) {
      const newProblem = new Problem({
        dossier: this._id,
      });
      await newProblem.save();
      this.problem = newProblem._id;
    }
    this.date_debut = moment(date).format("YYYY-MM-DD HH-mm-ss");
    next();
  } catch (error) {
    next(error);
  }
});

module.exports = Dossier = mongoose.model("Dossier", DossierSchema);
