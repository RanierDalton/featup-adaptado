var form = document.getElementById('uploadForm');

form.addEventListener('submit', async (e) =>  {
    e.preventDefault();

    var fileInput = document.getElementById('image');
    var file = fileInput.files[0];
    var formData = new FormData();
    formData.append('image', file);
    console.log(formData);

    fetch(`/produtor/uploadFoto/${sessionStorage.APELIDO_USUARIO}`, {
        method: 'POST',
        body: formData,
    })
    .then((res) =>  {
        res.json()
        .then((e) =>  {
            sessionStorage.PATH_FOTO = e.path;
            fotoPerfil.src = sessionStorage.PATH_FOTO;
            imgPerfil.src = sessionStorage.PATH_FOTO;
        })
    })
    .catch((err) =>  {
        console.log(`#ERRO: ${err}`);
    });
});