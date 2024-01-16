const mongoose = require("mongoose");
const { Schema } = mongoose;
const Problem = require("../Models/ProblemModel");
const Rapport = require("../Models/RapportModel");


const DossierSchema = new Schema(
  {
    reference: {
      type: String,
      required: [true, "reference is required "],
      unique: true,
    },                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

    juge1: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    juge2: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    problem: { type: mongoose.Types.ObjectId, ref: "Problem" },
    rapport: { type: mongoose.Types.ObjectId, ref: "Rapport" },
    date_debut: { type: Date, default: Date.now, required: true },
    date_fin: { type: Date },
    date_j :{ type: Date },
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
    next();
  } catch (error) {
    next(error);
  }
});

module.exports = Dossier = mongoose.model("Dossier", DossierSchema);
