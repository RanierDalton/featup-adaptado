var produtorController = require('../controllers/produtorController');
var express = require("express");
var router = express.Router();

var multer = require('multer');
var path = require('path');

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/assets/profiles/');
    },
    filename: function (req, file, cb) {
        var aliasProdutor = req.params.alias;
        aliasProdutor = aliasProdutor.replaceAll(' ', '').toLowerCase();
        cb(null, aliasProdutor + path.extname(file.originalname));
    }
});

var upload = multer({
    storage: storage,
    limits: { fileSize: 1024 * 1024 * 5 }
});

router.get("/produtores/achar/:id", (req, res) => {
    return produtorController.getAcharFeats(req, res);    
});

router.get("/produtores/convites/:id", (req, res) => {
    return produtorController.getConvites(req, res);
});

router.get("/produtores/perfil/:id", (req, res) => {
    return produtorController.getPerfil(req, res);    
})

router.get("/produtores/feats/:id", (req, res) => {
    return produtorController.getFeatsAtivos(req, res);
});

router.post("/produtor/cadastrar", (req, res) => {
    return produtorController.postProdutor(req, res);
});

router.post("/auth/produtor", (req, res) => {
    return produtorController.authProdutor(req, res);
});

router.post("/produtores/feat/cadastrar", (req, res) => {
    return produtorController.postFeat(req, res);
});

router.post('/produtor/uploadFoto/:alias', upload.single('image'), (req, res) => {
    return produtorController.patchPathFotoPerfil(req, res)
});

router.put("/produtores/feat/atualizar", (req, res) => {
    return produtorController.putStatusFeat(req, res);
});

module.exports = router;