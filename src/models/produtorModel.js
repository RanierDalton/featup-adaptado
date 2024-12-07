var db = require('../database/config');

function postProdutor(nome, alias, email, descricao, aplicativo, pontoForte, senha)  {
    var instrucao = `INSERT INTO produtor (nome, alias, senha, email, descricao, pontoForte, aplicativo) VALUES ('${nome}', '${alias}', '${senha}', '${email}', '${descricao}', '${pontoForte}', '${aplicativo}')`;
    
    return db.executar(instrucao);
}

function getProdutor(alias)  {
    var instrucao = `SELECT idProdutor FROM produtor WHERE alias = '${alias}'`;

    return db.executar(instrucao);
}

function auth(alias, senha) {
    var instrucao = `SELECT COUNT(idProdutor) as auth, idProdutor, alias, email, pathFotoPerfil as foto FROM produtor WHERE alias = '${alias}' AND senha = '${senha}'`;

    return db.executar(instrucao);
}

function getProdutoresTotais()  {
    var instrucao = `SELECT COUNT(idProdutor) as resultado FROM produtor`;
    return db.executar(instrucao);
}

function getProdutoresAtivos()  {
    var instrucao = `SELECT COUNT(idProdutor) as resultado FROM produtor WHERE TIMESTAMPDIFF(DAY,now(),lastLogin) <= 10`;
    return db.executar(instrucao);
}

function getAplicativosUsados()  {
    var instrucao = `SELECT COUNT(aplicativo) as total, aplicativo as nome FROM produtor GROUP BY aplicativo`;
    return db.executar(instrucao);
}

function getAcharFeats(condicoesGeneros, idProdutor)  {
    var instrucao = `SELECT p.idProdutor, p.alias, p.aplicativo, p.pontoForte, p.pathFotoPerfil as foto, g.nome as genero
        FROM produtor AS p
        JOIN genero_produtor as gp ON gp.fkProdutor = p.idProdutor 
        JOIN genero as g ON gp.fkGenero = g.idGenero 
        JOIN feat ON fkProdutorSolicita = idProdutor 
        WHERE ${condicoesGeneros} AND p.idProdutor <> ${idProdutor} and
        	isNull((
        		SELECT COUNT(feat.fkProdutorAceita) FROM produtor as prod
                JOIN feat ON prod.idProdutor = fkProdutorAceita AND fkProdutorSolicita = ${idProdutor}
                WHERE fkProdutorAceita = p.idProdutor
                GROUP BY feat.fkProdutorAceita

        	)) and 
        	isNull((
        		SELECT COUNT(feat.fkProdutorSolicita) FROM produtor as prod
                JOIN feat ON prod.idProdutor = fkProdutorSolicita AND fkProdutorAceita = ${idProdutor}
                WHERE fkProdutorSolicita = p.idProdutor
                GROUP BY feat.fkProdutorSolicita
        	));`;
    
    return db.executar(instrucao);
}

function getAcharFeatsGenericos(idProdutor)  {
    var instrucao = `SELECT p.idProdutor, p.alias, p.aplicativo, p.pontoForte, p.pathFotoPerfil as foto, g.nome as genero
        FROM produtor AS p
        JOIN genero_produtor as gp ON gp.fkProdutor = p.idProdutor 
        JOIN genero as g ON gp.fkGenero = g.idGenero 
        JOIN feat ON fkProdutorSolicita = idProdutor 
        WHERE p.idProdutor <> ${idProdutor} and
        	isNull((
        		SELECT COUNT(feat.fkProdutorAceita) FROM produtor as prod
                JOIN feat ON prod.idProdutor = fkProdutorAceita AND fkProdutorSolicita = ${idProdutor}
                WHERE fkProdutorAceita = p.idProdutor
                GROUP BY feat.fkProdutorAceita

        	)) and 
        	isNull((
        		SELECT COUNT(feat.fkProdutorSolicita) FROM produtor as prod
                JOIN feat ON prod.idProdutor = fkProdutorSolicita AND fkProdutorAceita = ${idProdutor}
                WHERE fkProdutorSolicita = p.idProdutor
                GROUP BY feat.fkProdutorSolicita
        	))
        ORDER BY p.alias
        LIMIT 60;`;

    return db.executar(instrucao);
}

function getPerfil(id)  {
    var instrucao = `
        SELECT descricao, pathFotoPerfil as pathFoto, alias, aplicativo, pontoForte, g.nome as genero,r.url as url, r.fontAwesomeTag as class, rp.usuario as 'user' 
        FROM produtor 
        JOIN genero_produtor as gp ON gp.fkProdutor = idProdutor 
        JOIN genero as g ON gp.fkGenero = g.idGenero 
        JOIN rede_produtor as rp ON rp.fkProdutor = idProdutor 
        JOIN rede_social as r ON fkRede = idRede
        WHERE idProdutor = ${id};
    `;

    return db.executar(instrucao);
}

function patchHorarioLogin(alias)  {
    var instrucao = `UPDATE produtor SET lastLogin = now() WHERE alias = '${alias}'`;

    return db.executar(instrucao);
}

function patchPathFotoPerfil(path, aliasProdutor)  {
    var instrucao = `UPDATE produtor SET pathFotoPerfil = '${path}' WHERE alias = '${aliasProdutor}'`;

    return db.executar(instrucao);
}

module.exports = {getAcharFeatsGenericos, postProdutor, getProdutor, auth, getProdutoresTotais, getProdutoresAtivos, getAplicativosUsados, getAcharFeats, getPerfil, patchHorarioLogin, patchPathFotoPerfil};