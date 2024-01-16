const mongoose = require("mongoose");
const { isEmail, contains } = require("validator");
const { Schema } = mongoose;
const bcrypt = require("bcrypt");

const UserSchema = new Schema(
  {
    userName: {
      type: String,
      required: [true, "user name is required"],
      unique: true,
      //minlength: [4, "Must be at least 6 characters long"],
      maxlength: [12, "Must be no more than 12 characters long"],
      validate: {
        validator: (val) => !contains(val, " "),
        message: "Must contain no spaces",
      },
    },
    cin: {
      type: String,
      required: true,
      unique: true,
      validate: {
        validator: function (v) {
          return /^\d+$/.test(v) && v.length === 8
        },
        message: (props) =>
          `${props.value} is not a valid cin number , it must be 8  long!`,
      },
    },
    email: {
      type: String,
      required: [true, "email is required"],
      //unique: true,
      validate: [isEmail, "Must be valid email address"],
    },
    password: {
      type: String,
      required: true,
      minLength: [8, "Must be at least 8 characters long"],
    },
    telephone: {
      type: String,
      validate: {
        validator: function (v) {
          // Check if the phone number is at least 8 characters and contains only digits
          return /^\d{8}$/.test(v);
        },
        message: (props) =>
          `${props.value} is not a valid phone number. It must be 8 digits long.`,
      },
      required: [true, "Phone number is required"],
    },
    role: {
      type: String,
      enum: ["juge", "President juge"],
      required: true,
    },
    //region: {},
  },
  { timestamps: true }
);


UserSchema.pre("save", async function (next) {
  const salt = await bcrypt.genSalt();
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

module.exports = User = mongoose.model("User", UserSchema);
