const redeModel = require('../models/redeModel');

function getRedes(req, res)  {
    const redes = redeModel.getRedes();
    redes.then((data) => {
        return res.status(200).json(data);
    });    
}

module.exports = {getRedes};