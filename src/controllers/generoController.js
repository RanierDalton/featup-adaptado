const generoModel = require('../models/generoModel');

function getGeneros(req, res)  {
    const generos = generoModel.getGeneros();
    generos.then((data) => {
        return res.status(200).json(data);
    });    
}

module.exports = {getGeneros};