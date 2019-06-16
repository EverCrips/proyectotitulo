$(document).ready(function () {
    $('#emailUs').blur(function () {
        var email = $('#emailUs').val();
        $.ajax({
            type: 'POST',
            data: {
                email: email,
                opcionValidaciones: 'valiEmail'
            },
            url: 'generalValidaciones',
            success: function (result) {
                var resultado = result;
                if (resultado == 1) {
                    document.getElementById("emailUs").value = "";
                    document.getElementById("emailUs").placeholder = "Correo en uso, intente con otro por favor";
                    document.getElementById("nocheckEmail").style.display = "block";
                    document.getElementById("checkEmail").style.display = "none";
                } else {
                    document.getElementById("checkEmail").style.display = "block";
                    document.getElementById("nocheckEmail").style.display = "none"
                }

            }
        });
    });
    $('#rutUs').blur(function () {
        var rut = $('#rutUs').val();
        $.ajax({
            type: 'POST',
            data: {
                rut: rut,
                opcionValidaciones: 'valiRut'
            },
            url: 'generalValidaciones',
            success: function (result) {
                var resultado = result;
                if (resultado == 1) {
                    document.getElementById("rutUs").value = "";
                    document.getElementById("rutUs").placeholder = "Rut asociado a otro usuario, utilice uno correcto";
                    document.getElementById("nocheckRut").style.display = "block";
                    document.getElementById("checkRut").style.display = "none";
                } else {
                    document.getElementById("checkRut").style.display = "block";
                    document.getElementById("nocheckRut").style.display = "none"
                }

            }
        });
    });
    //RESET PASS
    $('#emailUsRP').blur(function () {
        var valor = document.getElementById("emailUsRP").value;
        $.ajax({
            type: 'POST',
            data: {
                valor: valor,
                opcionValidaciones: 'recupePass'
            },
            url: 'generalValidaciones',
            success: function (result) {
                var resultado = parseInt(result);
                switch (resultado) {
                    case 1:
                        $("#modalExitoError").modal("show");
                        document.getElementById("divNewPC").style.display = "block";
                        document.getElementById("pExitoErrorRP").innerHTML = "Se ha enviado a su casilla un código único para restablecer su cuenta";
                        document.getElementById("emailUsRP").readOnly = true;
                        document.getElementById("divcodigoUsRP").style.visibility = "visible";
                        break;
                    case 2:
                        break;
                    case 3:
                        break;
                    case 4:
                        $("#modalExitoError").modal("show");
                        document.getElementById("divNewPC").style.display = "block";
                        document.getElementById("pExitoErrorRP").innerHTML = "El correo electrónico no figura en nuestro sistema";
                        document.getElementById("emailUsRP").value = "";
                        break;
                }

            }
        });
    });
    $('#codigoUsRP').blur(function () {
        var codigo = document.getElementById("codigoUsRP").value;
        var emailUsRP = document.getElementById("emailUsRP").value;
        $.ajax({
            type: 'POST',
            data: {
                email: emailUsRP,
                codigo: codigo,
                opcionValidaciones: 'recupePassCod'
            },
            url: 'generalValidaciones',
            success: function (result) {
                var resultado = parseInt(result);
                switch (resultado) {
                    case 1:
                        $("#modalExitoError").modal("show");
                        document.getElementById("divNewPC").style.display = "block";
                        document.getElementById("pExitoErrorRP").innerHTML = "El código concuerda con la cuenta";
                        document.getElementById("emailUsRP").readOnly = true;
                        document.getElementById("codigoUsRP").readOnly = true;
                        document.getElementById("divNewPC").style.display = "block";
                        document.getElementById("buttonARP").style.display = "none";
                        document.getElementById("buttonMRP").style.display = "block";
                        document.getElementById("auxauxDiv").style.display = "block";
                        document.getElementById("auxemailUsRP").value = emailUsRP;
                        break;
                    case 2:
                        $("#modalExitoError").modal("show");
                        document.getElementById("divNewPC").style.display = "block";
                        document.getElementById("pExitoErrorRP").innerHTML = "El código no concuerda con el correo electrónico"
                        document.getElementById("codigoUsRP").value = "";
                        break;
                }

            }
        });
    });
});
//FUNCION RMS
function selectChangeRMS() {
    var valor = document.getElementById("riesCritSel").value;
    $.ajax({
        type: 'POST',
        data: {
            valor: valor,
            opcionValidaciones: 'selectChange'
        },
        url: 'generalValidaciones',
        success: function (result) {
            var resultado = result.replace("[", "").replace("]", "");
            var resultado2 = result.replace("[", "").replace("]", "");
            var temp = new Array();
            temp = resultado.split(",");
            var temp2 = new Array();
            temp2 = resultado2.split(";");
            document.getElementById("numeRMS").innerHTML = temp[1];
            document.getElementById("nombreRMS").innerHTML = temp[0];
            document.getElementById("imgRMS").src = temp[2];
            var text = "";
            var i;
            for (i = 1; i < temp2.length; i++) {
                var aux2 = temp2[i];
                var aux3 = aux2.slice(0, -2);
                text = text + "<li>" + aux3 + "</li>" + "<hr>";
            }
            document.getElementById("columRMS").innerHTML = text;
        }
    });
}

//FUNCION RMS OPERACIÓN
function selectRmsOpe() {
    var valor = document.getElementById("rmsSelec").value;
    $.ajax({
        type: 'POST',
        data: {
            valor: valor,
            opcionValidaciones: 'selectChange'
        },
        url: 'generalValidaciones',
        success: function (result) {
            var resultado = result.replace("[", "").replace("]", "");
            var resultado2 = result.replace("[", "").replace("]", "");
            var temp = new Array();
            temp = resultado.split(",");
            var temp2 = new Array();
            temp2 = resultado2.split(";");
            var text = "";
            var text2 = "";
            var i;
            for (i = 1; i < temp2.length; i++) {
                var aux2 = temp2[i];
                var aux3 = aux2.slice(0, -2);
                text = text + "<li>" + aux3 + "</li>" + "<hr>";
                text2 = text2 +
                        "<select id='rmsSelec" + i + "' name='rmsSelec" + i + "' class='form-control' style='margin-bottom: 8px;'>" +
                        "<option value='1' >1</option>" +
                        "<option value='2' >2</option>" +
                        "<option value='3' >3</option>" +
                        "</select>" + "<br>";
            }
            //VER
            document.getElementById("divRmsOpe").innerHTML = text;
            document.getElementById("divColumnaOpe").innerHTML = text2;
            //DATOS AUXILIARES
            document.getElementById("auxOpe").value = i - 1;
            document.getElementById("auxnumeroRmsOpe").value = temp[1];
        }
    });
}

$(".editRmsOpe").click(function () {

    var valores = new Array();
    i = 0;

    $(this).parents("tr").find("td").each(function () {
        valores[i] = $(this).html();
        i++;
    });

    var valor = valores[0];
    $.ajax({
        type: 'POST',
        data: {
            valor: valor,
            opcionValidaciones: 'selectChange'
        },
        url: 'generalValidaciones',
        success: function (result) {
            var resultado = result.replace("[", "").replace("]", "");
            var resultado2 = result.replace("[", "").replace("]", "");
            var temp = new Array();
            temp = resultado.split(",");
            var temp2 = new Array();
            temp2 = resultado2.split(";");
            var text = "";
            var text2 = "";
            var i;
            for (i = 1; i < temp2.length; i++) {
                var aux2 = temp2[i];
                var aux3 = aux2.slice(0, -2);
                text = text + "<li>" + aux3 + "</li>" + "<hr>";
                text2 = text2 +
                        "<select id='rmsSelecEdit" + i + "' name='rmsSelecEdit" + i + "' class='form-control' style='margin-bottom: 8px;'>" +
                        "<option value='1' >1</option>" +
                        "<option value='2' >2</option>" +
                        "<option value='3' >3</option>" +
                        "</select>" + "<br>";
            }
            //VER
            document.getElementById("divRmsOpeSelec").innerHTML = text;
            document.getElementById("divColumnaOpeSelec").innerHTML = text2;
            //DATOS AUXILIARES
            document.getElementById("auxOpeSelec").value = i - 1;
            document.getElementById("auxnumeroRmsOpeSelec").value = temp[1];
        }
    });
});

//EQUIPOS
$(".visuEquiTable").click(function () {

    var valores = new Array();
    i = 0;
    $(this).parents("tr").find("td").each(function () {
        valores[i] = $(this).html();
        i++;
    });
    document.getElementById("numEquiDescPlani").value = valores[0];
    document.getElementById("nombreEquipoEd").value = valores[1];
    document.getElementById("nombreLider").value = valores[3];
    document.getElementById("descripcionEquipoEd").value = valores[2];
    var numEq = valores[0];
    $.ajax({
        type: 'POST',
        data: {
            numEq: numEq,
            opcionValidaciones: 'selectVisuaEqui'
        },
        url: 'generalValidaciones',
        success: function (result) {

            var resultado = result.replace("[", "").replace("]", "");
            var primerSplit = new Array();
            primerSplit = resultado.split(";");
            var text = "";
            var i;
            for (i = 1; i < primerSplit.length; i++) {
                var aux = 0;
                var temp = "";
                temp = primerSplit[i];
                var segundoSplit = new Array();
                segundoSplit = temp.split("*");
                text = text + "<li>" +
                        "<h3>Trabajador " + i + "</h3>" +
                        "<ul>" +
                        "<li>Nombre: " + segundoSplit[aux] + "</li>" +
                        "<li>Rut: " + segundoSplit[aux + 1] + "</li>" +
                        "<li>Correo electrónico: " + segundoSplit[aux + 2] + "</li>" +
                        "<li>Fono celular: " + segundoSplit[aux + 3] + "</li>" +
                        "<li>Domicilio: " + segundoSplit[aux + 4] + "</li>" +
                        "</ul>" +
                        "</li>";
                aux++;
            }
            document.getElementById("traEquSelec").innerHTML = text;
        }
    });
});
//EQUIPOS OPERACION
$(".visuEquiTableOpe").click(function () {
    
    var numEq = document.getElementById("numEqOp").value;
    $.ajax({
        type: 'POST',
        data: {
            numEq: numEq,
            opcionValidaciones: 'selectVisuaEqui'
        },
        url: 'generalValidaciones',
        success: function (result) {

            var resultado = result.replace("[", "").replace("]", "");
            var primerSplit = new Array();
            primerSplit = resultado.split(";");
            var text = "";
            var i;
            for (i = 1; i < primerSplit.length; i++) {
                var aux = 0;
                var temp = "";
                temp = primerSplit[i];
                var segundoSplit = new Array();
                segundoSplit = temp.split("*");
                text = text + "<li>" +
                        "<h3>Trabajador " + i + "</h3>" +
                        "<ul>" +
                        "<li>Nombre: " + segundoSplit[aux] + "</li>" +
                        "<li>Rut: " + segundoSplit[aux + 1] + "</li>" +
                        "<li>Correo electrónico: " + segundoSplit[aux + 2] + "</li>" +
                        "<li>Fono celular: " + segundoSplit[aux + 3] + "</li>" +
                        "<li>Domicilio: " + segundoSplit[aux + 4] + "</li>" +
                        "</ul>" +
                        "</li>";
                aux++;
            }
            document.getElementById("traEquSelec").innerHTML = text;
        }
    });
});