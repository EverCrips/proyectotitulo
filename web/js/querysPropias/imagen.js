document.getElementById("imagenPerfilUser").onchange = function (e) {
    let reader = new FileReader();

    reader.onload = function () {

        var preview = document.getElementById("preview");
        preview.src = reader.result;

        preview.innerHTML = '';

    };

    reader.readAsDataURL(e.target.files[0]);
}

