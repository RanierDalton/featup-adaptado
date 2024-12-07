var db = require('../database/config');

function getRedes() {
    var instrucao = 'SELECT idRede as id, nome FROM rede_social ORDER BY nome';

    return db.executar(instrucao);
}

function postRedeProdutor(values)  {
    var instrucao = `INSERT INTO rede_produtor (fkProdutor, fkRede, usuario) VALUES ${values}`;
    return db.executar(instrucao);
}

module.exports = {getRedes, postRedeProdutor};