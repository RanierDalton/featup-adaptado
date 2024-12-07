var generoController = require('../controllers/generoController');
var express = require("express");
var router = express.Router();

router.get("/generos", (req, res) => {
    return generoController.getGeneros(req, res);
});

module.exports = router;