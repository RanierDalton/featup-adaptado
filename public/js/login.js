var isVisivel = false;
var inputApelido = document.getElementById('iptApelido');
var inputSenha = document.getElementById('iptSenha');

function entrar(){
    loading();
    var apelido = inputApelido.value;
    var senha = inputSenha.value;

    if(apelido == '' || senha == ''){
        finalizarLoading();
        return errorModal("Preencha os campos corretamente");
    }

    var credenciais = {
        alias:apelido,
        senha:senha
    }

    fetch("/auth/produtor", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(credenciais)
    }).then(function (resposta) {
        console.log("ESTOU NO THEN DO entrar()!")

        if (resposta.ok) {
            console.log(resposta);

            resposta.json()
            .then(json => {
                console.log(json);
                console.log(JSON.stringify(json));

                sessionStorage.APELIDO_USUARIO = json.alias;
                sessionStorage.ID_USUARIO = json.id;
                sessionStorage.PATH_FOTO = json.foto;

                finalizarLoading();

                if(sessionStorage.APELIDO_USUARIO == "admin"){
                    return window.location = "..//dashboard.html";
                }

                return window.location = "..//achar_feats.html";
            });

        } else {
            resposta.text().then(texto => {
                finalizarLoading();
                errorModal(texto);
            });
        }

    }).catch((erro) => {
        errorModal(erro);
        finalizarLoading();
    });

    return false;
}

