var produtorModel = require('../models/produtorModel');
var generoModel = require('../models/generoModel');
var featModel = require('../models/featModel');

function getData(req, res)  {
    var dados = {
        usuariosTotais: 0,
        usuariosAtivos: 0,
        featsTotais: 0,
        generosRecorrentes:{},
        statusFeats:{},
        appsRecorrentes:{},
    }

    Promise.all([produtorModel.getProdutoresTotais(), produtorModel.getProdutoresAtivos(), featModel.getFeatsTotais(), generoModel.getGenerosRecorrentes(), featModel.getStatusFeats(), produtorModel.getAplicativosUsados()])
    .then((resultados) => {
 
        dados.usuariosTotais = resultados[0][0].resultado;
        dados.usuariosAtivos = resultados[1][0].resultado;
        dados.featsTotais = resultados[2][0].resultado;
        dados.generosRecorrentes = filtrarPodio(resultados[3]);
        dados.statusFeats = resultados[4];
        dados.appsRecorrentes = filtrarPodio(resultados[5]);
        res.status(200).json(dados);

    })
    .catch((err) => {
        console.log(err);
        res.status(503).json(err.sqlMessage);
    });
}

function filtrarPodio(dados) {
    var resposta = [];

    var i = 0;
    var contador = 0;
    dados.forEach(function (item)  {
        if(i < 3){
            resposta.push(item);
        } else {
            contador += item.total;
        }
        i++;
    });

    var objOutros = {nome: 'Outros', total: contador};

    resposta.push(objOutros);

    return resposta;
}

module.exports = {getData};