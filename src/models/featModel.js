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

// Adicionar as funções e comandos para o ranking - 21/01
function getUsuariosFeatsKPI(){
    var instrucao = `
    WITH FeatsConfirmados AS (
    SELECT 
        fkProdutorAceita AS produtor,
        COUNT(*) AS totalFeatsConfirmados
    FROM feat
    WHERE statusFeat = 1
    GROUP BY fkProdutorAceita
),
FeatsSolicitados AS (
    SELECT 
        fkProdutorSolicita AS produtor,
        COUNT(*) AS totalFeatsConfirmados
    FROM feat
    WHERE statusFeat = 1
    GROUP BY fkProdutorSolicita
),
ProdutoresComFeats AS (
    SELECT 
        produtor,
        SUM(totalFeatsConfirmados) AS totalFeats
    FROM (
        SELECT produtor, totalFeatsConfirmados FROM FeatsConfirmados
        UNION ALL
        SELECT produtor, totalFeatsConfirmados FROM FeatsSolicitados
    ) AS Feats
    GROUP BY produtor
),
ProdutoresOrdenados AS (
    SELECT 
        P.idProdutor,
        P.pathFotoPerfil AS caminhoFoto,   -- Referência correta para a coluna
        P.alias,
        PF.totalFeats,
        PF.totalFeats * 100.0 / (SELECT COUNT(*) FROM feat WHERE fkProdutorAceita = PF.produtor) AS taxaAceitacao,
        PF.totalFeats * 100.0 / (SELECT COUNT(*) FROM feat WHERE fkProdutorSolicita = PF.produtor) AS taxaSolicitacao
    FROM ProdutoresComFeats PF
    INNER JOIN produtor P ON PF.produtor = P.idProdutor
),
ProdutorMaiorFeats AS (
    SELECT idProdutor, totalFeats
    FROM ProdutoresOrdenados
    ORDER BY totalFeats DESC
    LIMIT 1
),
ProdutorMenorFeats AS (
    SELECT idProdutor, totalFeats
    FROM ProdutoresOrdenados
    ORDER BY totalFeats ASC
    LIMIT 1
)
SELECT 
    P.caminhoFoto,  -- Use 'caminhoFoto' aqui, já que você fez um alias
    P.alias,
    P.totalFeats,
    P.taxaAceitacao,
    P.taxaSolicitacao
FROM ProdutoresOrdenados P
WHERE P.idProdutor IN (
    SELECT idProdutor FROM ProdutorMaiorFeats
    UNION
    SELECT idProdutor FROM ProdutorMenorFeats
);
    
    `;
    return db.executar(instrucao);
};


function getRankUsuariosMais(){
    var instrucao = `WITH FeatsConfirmados AS (
    SELECT 
        fkProdutorAceita AS produtor,
        COUNT(*) AS totalFeatsConfirmados
    FROM feat
    WHERE statusFeat = 1
    GROUP BY fkProdutorAceita
),
FeatsSolicitados AS (
    SELECT 
        fkProdutorSolicita AS produtor,
        COUNT(*) AS totalFeatsConfirmados
    FROM feat
    WHERE statusFeat = 1
    GROUP BY fkProdutorSolicita
),
ProdutoresComFeats AS (
    SELECT 
        produtor,
        SUM(totalFeatsConfirmados) AS totalFeats
    FROM (
        SELECT produtor, totalFeatsConfirmados FROM FeatsConfirmados
        UNION ALL
        SELECT produtor, totalFeatsConfirmados FROM FeatsSolicitados
    ) AS Feats
    GROUP BY produtor
),
ProdutoresOrdenados AS (
    SELECT 
        P.idProdutor,
        P.alias,
        PF.totalFeats,
        PF.totalFeats * 100.0 / (SELECT COUNT(*) FROM feat WHERE fkProdutorAceita = PF.produtor) AS taxaAceitacao
    FROM ProdutoresComFeats PF
    INNER JOIN produtor P ON PF.produtor = P.idProdutor
),
ProdutorMaiorFeats AS (
    SELECT idProdutor
    FROM ProdutoresOrdenados
    ORDER BY totalFeats DESC
    LIMIT 1
),
ProdutorMenorFeats AS (
    SELECT idProdutor
    FROM ProdutoresOrdenados
    ORDER BY totalFeats ASC
    LIMIT 1
)
SELECT 
    P.alias,
    P.totalFeats,
    P.taxaAceitacao
FROM ProdutoresOrdenados P
WHERE P.idProdutor NOT IN (SELECT idProdutor FROM ProdutorMaiorFeats)
AND P.idProdutor NOT IN (SELECT idProdutor FROM ProdutorMenorFeats)
ORDER BY P.totalFeats DESC
LIMIT 4;`;
    return db.executar(instrucao);
};

function getRankUsuariosMenos(){
    var instrucao = `
    WITH FeatsConfirmados AS (
    SELECT 
        fkProdutorAceita AS produtor,
        COUNT(*) AS totalFeatsConfirmados
    FROM feat
    WHERE statusFeat = 1
    GROUP BY fkProdutorAceita
),
FeatsSolicitados AS (
    SELECT 
        fkProdutorSolicita AS produtor,
        COUNT(*) AS totalFeatsConfirmados
    FROM feat
    WHERE statusFeat = 1
    GROUP BY fkProdutorSolicita
),
ProdutoresComFeats AS (
    SELECT 
        produtor,
        SUM(totalFeatsConfirmados) AS totalFeats
    FROM (
        SELECT produtor, totalFeatsConfirmados FROM FeatsConfirmados
        UNION ALL
        SELECT produtor, totalFeatsConfirmados FROM FeatsSolicitados
    ) AS Feats
    GROUP BY produtor
),
ProdutoresOrdenados AS (
    SELECT 
        P.idProdutor,
        P.alias,
        PF.totalFeats,
        PF.totalFeats * 100.0 / (SELECT COUNT(*) FROM feat WHERE fkProdutorAceita = PF.produtor) AS taxaAceitacao
    FROM ProdutoresComFeats PF
    INNER JOIN produtor P ON PF.produtor = P.idProdutor
),
ProdutorMaiorFeats AS (
    SELECT idProdutor
    FROM ProdutoresOrdenados
    ORDER BY totalFeats DESC
    LIMIT 1
),
ProdutorMenorFeats AS (
    SELECT idProdutor
    FROM ProdutoresOrdenados
    ORDER BY totalFeats ASC
    LIMIT 1
)
SELECT 
    P.alias,
    P.totalFeats,
    P.taxaAceitacao
FROM ProdutoresOrdenados P
WHERE P.idProdutor NOT IN (SELECT idProdutor FROM ProdutorMaiorFeats)
AND P.idProdutor NOT IN (SELECT idProdutor FROM ProdutorMenorFeats)
ORDER BY P.totalFeats ASC
LIMIT 4;
    `;
    return db.executar(instrucao);
};

module.exports = {getFeatsTotais, getStatusFeats, getConvites, getFeatsAtivos, putStatusFeat, postFeat,getUsuariosFeatsKPI,getRankUsuariosMais,getRankUsuariosMenos};