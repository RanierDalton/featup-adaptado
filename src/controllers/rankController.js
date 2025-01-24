// Criação do arquivo controller - 20/01
var featModel = require('../models/featModel'); // Usar uma query do feat model por se tratar de informações relacinados aos feats

function getData(req, res){
    // ADICIONAR CÓDIGO PARA MONTAR UM DICIONÁRIO DE DADOS PARA ENVIAR AO FRONT - 21/01 
    var dados = {
        infoUsuariosKPI:{},
        usuariosMenos:[],
        usuariosMais:[]
    }
    
    Promise.all([featModel.getUsuariosFeatsKPI(), featModel.getRankUsuariosMais(), featModel.getRankUsuariosMenos()])
    .then((resultados) => {
        // organizar o resultado das queries no dicionário - 24/01
        dados.infoUsuariosKPI = resultados[0];
        dados.usuariosMais = resultados[1];
        dados.usuariosMenos = resultados[2];
        res.status(200).json(dados);
    })
    .catch((err) => {
        console.log(err);
        res.status(503).json(err.sqlMessage);
    });
}

module.exports = {getData};