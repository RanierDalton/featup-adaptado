var dashboardController = require('../controllers/dashboardController');
var express = require("express");
var router = express.Router();

router.get("/dashboard", (req, res) => {
    return dashboardController.getData(req, res);
});

module.exports = router;