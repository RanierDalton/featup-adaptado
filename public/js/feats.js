function carregarProdutoresFeats(){
    loading();
    document.getElementById("fotoPerfil").src = sessionStorage.PATH_FOTO;
    fetch(`/produtores/feats/${sessionStorage.ID_USUARIO}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        }
    })
    .then((resposta) =>  {
        resposta.json()
        .then((data)=> {
            organizarCards(data);
        });
    })
    .catch((resposta) =>  {
        console.log(`#ERRO: ${resposta}`);
    });
}

function organizarCards(data){
    var qtdLinhas = Math.floor(data.length / 3);
    var cardsSobrar = data.length - (qtdLinhas * 3);
    var contadorLinhas = 0;
    var contadorCards = 0;
    var divProdutores = document.getElementById("produtores");
    var linhaAtual;

    for(var i=1; i<=data.length;i++){
        if(contadorCards == 0 && contadorLinhas < qtdLinhas){
            linhaAtual = document.createElement("div");
            linhaAtual.classList.add("linha");
            linhaAtual.classList.add("three-boxes");
        }  else if(contadorCards == 0 && contadorLinhas == qtdLinhas){
            linhaAtual = document.createElement("div");
            linhaAtual.classList.add("linha");

            if(cardsSobrar == 2){
                linhaAtual.classList.add("two-boxes");
            }
        }

        var caixa = `
            <div class="box">
                <div class="cabecalho-box">
                    <img src="${data[i-1].foto}" alt="Foto de perfil do Produtor">
                    <span>${data[i-1].alias}</span>
                </div>
                <div class="corpo-box">
                    <span><b>Ponto Forte: </b>${data[i-1].pontoForte}</span>
                    <span><b>Aplicativo: </b>${data[i-1].aplicativo}</span>
                    <span><b>Gêneros: </b>${data[i-1].genero}</span>
                </div>
                <div class="acoes-box">
                    <button onclick="abrirPerfilProdutor(${data[i-1].idProdutor})">Ver Perfil</button>
                </div>
            </div>
        `;

        linhaAtual.innerHTML += caixa;
        contadorCards++;

        if(contadorCards == 3 || (contadorCards == cardsSobrar && contadorLinhas == qtdLinhas)){
            contadorCards = 0;
            contadorLinhas++;
            divProdutores.appendChild(linhaAtual);
        }
    }
    finalizarLoading();
}

function abrirPerfilProdutor(idProdutor){
    sessionStorage.ID_PRODUTOR_PERFIL = idProdutor;

    return window.location = "..//perfil.html";
}

