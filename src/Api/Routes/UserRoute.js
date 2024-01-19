const express = require("express");
const router = express.Router();
const UserControllers = require("../Controllers/UserController");


router.get("/getJurys", UserControllers.getJurys);

module.exports = router;
