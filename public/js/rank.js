// Criação prévia do JS do ranking
//Criar a primeira função para a coleta dos dados - 30/01
function obterDadosRanking() {
    loading();
    document.getElementById("fotoPerfil").src = sessionStorage.PATH_FOTO;
    fetch(`/rank`, { cache: 'no-store' })
    .then((response) =>  {
        if (response.ok) {
            response.json()
            .then((resposta) =>  {
                plotarDados(resposta);
                // Corrigir bug loading "infinito"
                finalizarLoading();
            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
            finalizarLoading();
        }
    })
    .catch((error) =>  {
        console.error(`Erro na obtenção dos dados p/ gráfico: ${error.message}`);
        finalizarLoading();
    });
}

// função para plotar os dados coletados anteriormente - 30/01
function plotarDados(data){
    var usuarioMenos = data.infoUsuariosKPI[0];
    var usuarioMais = data.infoUsuariosKPI[1];

    feats_menos.innerText = `${usuarioMenos.totalFeats} feats`;
    fotoPerfilMenos.src = usuarioMenos.caminhoFoto;
    apelido_menos.innerText = usuarioMenos.alias;
    ta_menos.innerText = `${Number(usuarioMenos.taxaAceitacao).toFixed(2)}%`;
    ts_menos.innerText = `${Number(usuarioMenos.taxaSolicitacao).toFixed(2)}%`;

    feats_mais.innerText = `${usuarioMais.totalFeats} feats`;
    fotoPerfilMais.src = usuarioMais.caminhoFoto;
    apelido_mais.innerText = usuarioMais.alias;
    ta_mais.innerText = `${Number(usuarioMais.taxaAceitacao).toFixed(2)}%`;
    ts_mais.innerText = `${Number(usuarioMais.taxaSolicitacao).toFixed(2)}%`;

    var conteudoRankingMais = '';
    var conteudoRankingMenos = '';

    for(var i=0; i<data.usuariosMais.length;i++){
        var apelidoAtualMais = data.usuariosMais[i].alias;
        var featsAtualMais = data.usuariosMais[i].totalFeats;
        var taxaAceitacaoAtualMais = `${Number(data.usuariosMais[i].taxaAceitacao).toFixed(2)}%`;

        var apelidoAtualMenos = data.usuariosMenos[i].alias;
        var featsAtualMenos = data.usuariosMenos[i].totalFeats;
        var taxaAceitacaoAtualMenos = `${Number(data.usuariosMenos[i].taxaAceitacao).toFixed(2)}%`;

        var contentMais = `<div class="linha">
                        <span>${apelidoAtualMais} - <b class="vermelho">${featsAtualMais}</b> feats - TA: <b class="vermelho">${taxaAceitacaoAtualMais}</b></span>
                    </div>`;

        var contentMenos = `<div class="linha">
                    <span>${apelidoAtualMenos} - <b class="vermelho">${featsAtualMenos}</b> feats - TA: <b class="vermelho">${taxaAceitacaoAtualMenos}</b></span>
                </div>`;

        if(i+1 != data.usuariosMais.length){
            contentMais = `<div class="linha borda-inferior">
                        <span>${apelidoAtualMais} - <b class="vermelho">${featsAtualMais}</b> feats - TA: <b class="vermelho">${taxaAceitacaoAtualMais}</b></span>
                    </div>`;

            contentMenos = `<div class="linha borda-inferior">
                    <span>${apelidoAtualMenos} - <b class="vermelho">${featsAtualMenos}</b> feats - TA: <b class="vermelho">${taxaAceitacaoAtualMenos}</b></span>
                </div>`;
        }

        conteudoRankingMais += contentMais;
        conteudoRankingMenos += contentMenos;
    }

    restoMais.innerHTML = conteudoRankingMais;
    restoMenos.innerHTML = conteudoRankingMenos;
}