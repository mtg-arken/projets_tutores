const express = require("express");
const router = express.Router();
const authControllers = require("../Controllers/AuthController");

router.post("/Register", authControllers.Register);
router.post("/Login", authControllers.Login);
router.get("/Logout", authControllers.Logout);

module.exports = router;
