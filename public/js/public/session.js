function validarSessao() {
    var alias = sessionStorage.APELIDO_USUARIO;
    var id = sessionStorage.ID_USUARIO;

    if ((alias == null || alias == undefined) || (id == null || id == undefined)) {
        sessionStorage.clear();
        window.location = "./login.html";
    }
}

function validarSessaoAdmin(){
    var alias = sessionStorage.APELIDO_USUARIO;

    if (alias != "admin") {
        sessionStorage.clear();
        window.location = "./login.html";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "./login.html";
}
