var db = require('../database/config');

function getGeneros() {
    var instrucao = 'SELECT idGenero as id, nome FROM genero ORDER BY nome';

    return db.executar(instrucao);
}

function getGenerosProdutor(id) {
    var instrucao = `SELECT genero.nome as nome FROM genero_produtor JOIN genero ON genero.idGenero = fkGenero JOIN produtor ON fkProdutor = idProdutor WHERE fkProdutor = ${id}`;

    return db.executar(instrucao);
}

function postGeneroProdutor(values)  {
    var instrucao = `INSERT INTO genero_produtor (fkProdutor, fkGenero) VALUES ${values}`;
    return db.executar(instrucao);
}

function getGenerosRecorrentes()  {
    var instrucao = `SELECT COUNT(fkGenero) as total, nome FROM genero_produtor JOIN genero ON genero.idGenero = fkGenero GROUP BY fkGenero ORDER BY total DESC`;
    return db.executar(instrucao);
}

module.exports = {getGeneros, postGeneroProdutor, getGenerosRecorrentes, getGenerosProdutor};