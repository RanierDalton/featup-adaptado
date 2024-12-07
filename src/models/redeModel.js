const db = require('../database/config');

function getRedes() {
    const instrucao = 'SELECT idRede as id, nome FROM rede_social ORDER BY nome';

    return db.executar(instrucao);
}

function postRedeProdutor(values)  {
    const instrucao = `INSERT INTO rede_produtor (fkProdutor, fkRede, usuario) VALUES ${values}`;
    return db.executar(instrucao);
}

module.exports = {getRedes, postRedeProdutor};