const mongoose = require("mongoose");
const { isEmail, contains } = require("validator");
const { Schema } = mongoose;
//const bcrypt = require("bcrypt");

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
      required: [true, "reference is required "],
      unique: true,
    },
    date_debut: { type: Date },
    date_fin: { type: Date },
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
module.exports = Problem = mongoose.model("Problem", ProblemSchema);
