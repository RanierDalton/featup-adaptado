var modalError= document.getElementById('popUp');
var msgModalError = document.getElementById('msgPopUp');

var modalSuccess = document.getElementById("successModal");
var msgSuccess = document.getElementById("msgModalSuccess");

function errorModal(text){
    modalError.showModal();
    msgModalError.innerText = text;
}

function successModal(text){
    modalSuccess.showModal();
    msgSuccess.innerText = text;
}

function closeSuccessModal(){
    modalSuccess.close();
}