var redeController = require('../controllers/redeController');
var express = require("express");
var router = express.Router();

router.get("/redes", (req, res) => {
    return redeController.getRedes(req, res);
});

module.exports = router;