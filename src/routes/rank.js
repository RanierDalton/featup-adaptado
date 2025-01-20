// criação do arquivo de rotas - 20/01
var rankController = require('../controllers/rankController');
var express = require("express");
var router = express.Router();

router.get("/rank", (req, res) => {
    return rankController.getData(req, res);
});

module.exports = router;