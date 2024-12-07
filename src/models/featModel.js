var db = require('../database/config');

function getFeatsAtivos(id){
    var instrucao = `SELECT idProdutor, alias, aplicativo, pontoForte, pathFotoPerfil as foto, g.nome as genero FROM produtor JOIN genero_produtor as gp ON gp.fkProdutor = idProdutor 
JOIN genero as g ON gp.fkGenero = g.idGenero
JOIN feat ON idProdutor = fkProdutorAceita OR idProdutor = fkProdutorSolicita
WHERE idProdutor <> ${id} AND statusFeat = 1  AND (fkProdutorAceita = ${id} or fkProdutorSolicita= ${id});`;
    return db.executar(instrucao);
};

function getConvites(id){
    var instrucao = `SELECT idProdutor, alias, aplicativo, pontoForte, pathFotoPerfil as foto, g.nome as genero FROM produtor JOIN genero_produtor as gp ON gp.fkProdutor = idProdutor JOIN genero as g ON gp.fkGenero = g.idGenero JOIN feat ON idProdutor = feat.fkProdutorSolicita WHERE feat.statusFeat = 0 AND fkProdutorAceita = ${id}`
    return db.executar(instrucao);
};

function getFeatsTotais(){
    var instrucao = 'SELECT COUNT(idFeat) as resultado FROM feat';

    return db.executar(instrucao);
};

function getStatusFeats(){
    var instrucao = `SELECT COUNT(statusFeat) as total, CASE WHEN statusFeat = 0 THEN 'Pendente' WHEN statusFeat = 1 THEN 'Aceito' ELSE 'Recusado' END AS nome FROM feat GROUP BY statusFeat`;

    return db.executar(instrucao);
};

function postFeat(idSolicita, idAceita){
    var instrucao = `INSERT INTO feat (dtFeat, fkProdutorSolicita, fkProdutorAceita) VALUES (now(), '${idSolicita}', '${idAceita}')`;

    return db.executar(instrucao);
};

function putStatusFeat(idSolicita, idAceita, status){
    var instrucao = `UPDATE feat SET statusFeat = ${status} WHERE fkProdutorAceita = ${idAceita} AND fkProdutorSolicita = ${idSolicita}`;

    return db.executar(instrucao);
};

module.exports = {getFeatsTotais, getStatusFeats, getConvites, getFeatsAtivos, putStatusFeat, postFeat};