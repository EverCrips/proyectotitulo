// FUNCIONES VALIDAR FORMULARIOS
$(document).ready(function () {
    $('#rutUs').mask('99.999.999-9');
    $('#telefonocelularUs').mask('+(000) 00000000');
    $('#fonofijoUs').mask('00 000000');

//USUARIOS
    $(".deleteUsTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("correoUsuarioEliminar").value = valores[3];
        document.getElementById("nombreUsuarioEliminar").value = valores[0];

    });   
    $(".reactUsTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("correoUsuarioReactivar").value = valores[3];
        document.getElementById("nombreUsuarioReactivar").value = valores[0];
    });
    $(".visuaUsTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("correoUsPagNew").value = valores[3];
        document.mostrarDatosUsuarioPagNew.submit();
    });

//FUNCION VALIDAR CONTRASAEÑAS IGUALES
    $('#pass2Us').blur(function () {
        var pass1 = document.getElementById("pass1Us").value;
        var pass2 = document.getElementById("pass2Us").value;

        if (pass1 != pass2) {
            document.getElementById("pass2Us").value = "";
            document.getElementById("pass1Us").value = "";
            document.getElementById("pass2Us").placeholder = "Contraseñas no coinciden";
            document.getElementById("pass1Us").placeholder = "Contraseñas no coinciden";
            document.getElementById("nocheckPass1").style.display = "block";
            document.getElementById("nocheckPass2").style.display = "block";
            document.getElementById("checkPass1").style.display = "none";
            document.getElementById("checkPass2").style.display = "none";
        } else {
            document.getElementById("nocheckPass1").style.display = "none";
            document.getElementById("nocheckPass2").style.display = "none";
            document.getElementById("checkPass1").style.display = "block";
            document.getElementById("checkPass2").style.display = "block";
        }

    });

//EQUIPOS
    $(".agregarTraEq").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });


        document.getElementById("correoTra").value = valores[2];
        document.agregarTrabajadorEquipo.submit();
    });
    $(".editEqTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("codigoEq").value = valores[0];
        document.editarEquiSelec.submit();
    });
    $(".deleteTraTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("correoQuiTraEq").value = valores[2];
        document.getElementById("nombreUsuarioEliminar").value = valores[0];

    });
    $(".deleteEquiTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("nombreEquipoBorrar").value = valores[1];
        document.getElementById("codigoEquipoBorrar").value = valores[0];

    });

//OPERACIONES
    $(".editRMSTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("codigoOpeSele").value = valores[0];
        document.editarFormularioOpe.submit();
    });
    $(".closeOpeTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("nombreOperacionCerrar").value = valores[1];
        document.getElementById("codigoCerrarOperacion").value = valores[0];
    });
    $(".aceptOpeTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("nombreOperacionAceptar").value = valores[1];
        document.getElementById("codigoAceptarOperacion").value = valores[0];
    });
    $(".cancelOpeTable").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("nombreOperacionRechazar").value = valores[1];
        document.getElementById("codigoRechazarOperacion").value = valores[0];
    });
    $(".deleteRmsOpe").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("nombreRmsOperacionRemover").value = valores[1];
        document.getElementById("numeroRmsRemoverOperacion").value = valores[0];

    });
    $(".descaPlanOpe").click(function () {

        var valores = new Array();
        i = 0;

        $(this).parents("tr").find("td").each(function () {
            valores[i] = $(this).html();
            i++;
        });

        document.getElementById("numOpeDesca").value = valores[0];
        document.descaPlaniOpe.submit();
       
    });


});

//FUNCION MODAL EXITO ERROR
function ejecutarModalFun() {
    var valor = document.getElementById("modalShowJs").value;
    if (valor == "1") {
        $("#modalExitoError").modal("show");
    }
}


