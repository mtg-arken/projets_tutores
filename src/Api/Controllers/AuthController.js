const bcrypt = require("bcrypt");
const {
  createToken,
  createRefreshToken,
} = require("../../Config/GenerateToken");
const { CreateNewUser, FindUserByCin } = require("../Services/UserService");

const Register = async (req, res) => {
  try {
    const { UserName, Cin, Email, Telephone, Password, Role } = req.body;
    console.log(Cin.length,Cin)
    if (!(Password && Email && UserName && Cin && Role && Telephone)) {
      throw new Error("All inputs required");
    }
    const ExistingUser = await FindUserByCin(Cin);
    if (ExistingUser) {
      throw new Error("Cin is already used");
    }
    const user = await CreateNewUser(
      Password,
      Email,
      UserName,
      Cin,
      Role,
      Telephone
    );
    return res.json(user);
  } catch (err) {
    return res.status(400).json({ error: err.message });
  }
};

const Login = async (req, res) => {
  try {
    const { Cin, Password } = req.body;
    console.log(Cin, Password,'data')

    const user = await FindUserByCin(Cin);
    console.log(user,'data1')

    if (!user) {
      throw new Error("Cin not found ");
    }
    console.log(user.password,Password,'data3')

    const ExistingPassword = await bcrypt.compare(Password, user.password);
    console.log(ExistingPassword,'data2')

    if (!ExistingPassword) {
      throw new Error("incorrect password");
    }

    const token = await createToken(user._id);
    const refreshToken = await createRefreshToken(user._id);

    res.cookie("token", token, {
      httpOnly: true,
      secure: true,
      sameSite: "none",
      maxAge: 60 * 60 * 1000,
    });
    res.cookie("RefreshToken", refreshToken, {
      httpOnly: true,
      secure: true,
      sameSite: "none",
      maxAge: 1 * 24 * 60 * 60 * 1000,
    });
    res.status(201).json({
      user: {
        userName: user.userName,
        email: user.email,
        cin: user.cin,
        role: user.role,
        telephone: user.telephone,
        _id: user._id,
      },
    });
    return;
  } catch (err) {
    console.log(err.message)
    return res.status(400).json({ error: err.message });
  }
};

const Logout = async (req, res) => {
  try {
    res.clearCookie("token");
    res.clearCookie("RefreshToken");

    res.status(200).send(" cookie deleted");
  } catch (error) {
    res.status(500).send("Internal server error");
  }
};

module.exports = {
  Login,
  Register,
  Logout,
};
