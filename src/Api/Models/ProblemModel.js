const mongoose = require("mongoose");
const { Schema } = mongoose;

const ProblemSchema = new Schema(
  {
    dossier: { type: mongoose.Types.ObjectId, ref: "Dossier", required: true },
    problem: { type: Boolean, default: false },
    problemType: {
      type: String,
      enum: ["audiance", "negociation"],
      required: function () {
        return this.problem === true;
      },
    },
    description: {
      type: String,
      required:true
    },
    date_audiance: {
      type: Date,
      required: function () {
        return this.problemType === "audiance";
      },
    },
    date_negociation: {
      type: Date,
      required: function () {
        return this.problemType === "negociation";
      },
    },
    lieu: {
      type: String,
    },
  },
  { timestamps: true }
);

module.exports = Problem = mongoose.model("Problem", ProblemSchema);
