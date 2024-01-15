const mongoose = require("mongoose");
const { Schema } = mongoose;

const RapportSchema = new Schema(
  {
    dossier: { type: mongoose.Types.ObjectId, ref: "Dossier", required: true },
    description: { type: String },
    date_debut: { type: Date },
    date_fin: { type: Date },
  },
  { timestamps: true }
);

module.exports = Rapport = mongoose.model("Rapport", RapportSchema);
