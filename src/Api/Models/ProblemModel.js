const mongoose = require("mongoose");
const { Schema } = mongoose;

const ProblemSchema = new Schema(
  {
    dossier: { type: mongoose.Types.ObjectId, ref: "Dossier", required: true },
    problem: { type: Boolean, default: false },
    problemType: {
      type: String,
      enum: ["visite", "temoignage"],
      required: function () {
        return this.problem === true;
      },
    },
    description: {
      type: String,
      /*required: function () {
        return this.problem === true
      },*/
    },
    /*date_visite: {
      type: Date,
      required: function () {
        return this.problemType === "visite";
      },
    },
    date_temoignage: {
      type: Date,
      required: function () {
        return this.problemType === "temoignage";
      },
    },*/
    date_Prob: {
      type: Date,
    
    },
    date_negotiation: {
      type: Date,
    
    },
    lieu: {
      type: String,
    },
  },
  { timestamps: true }
);

module.exports = Problem = mongoose.model("Problem", ProblemSchema);
