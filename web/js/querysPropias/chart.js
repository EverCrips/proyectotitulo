
$(function () {

    Highcharts.setOptions({
        lang: {
            drillUpText: 'Volver'
        }
    });

    var valorAdmAct = parseInt(document.getElementById("cantAdmAct").value);
    var valorAdmInac = parseInt(document.getElementById("cantAdmInac").value);
    var valorSuperAct = parseInt(document.getElementById("cantSuperAct").value);
    var valorSuperInac = parseInt(document.getElementById("cantSuperInac").value);

    // Create the chart
    Highcharts.chart('containerCharUs', {
        chart: {
            height: 250,
            type: 'column'
        },
        title: {
            text: 'Usuarios actuales Tekonn'
        },
        xAxis: {
            type: 'category'
        },
        yAxis: {
            title: {
                text: 'Cantidad usuarios'
            }

        },
        legend: {
            enabled: false
        },

        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true
                }
            }
        },

        series: [{
                name: 'Total',
                colorByPoint: true,
                data: [{
                        name: 'Administradores',
                        y: valorAdmAct+valorAdmInac,
                        drilldown: 'drillAdministradores'
                    }, {
                        name: 'Supervisores',
                        y: valorSuperAct+valorSuperInac,
                        drilldown: 'drillSupervisores'
                    }]
            }],
        drilldown: {
            series: [{
                    name: "Total",
                    id: 'drillAdministradores',
                    data: [
                        ['Activos', valorAdmAct],
                        ['Inactivos', valorAdmInac]
                    ]
                }, {
                    name: "Total",
                    id: 'drillSupervisores',
                    data: [
                        ['Activos', valorSuperAct],
                        ['Inactivos', valorSuperInac]
                    ]
                }]
        }
    });
    
})


$(function () {

    Highcharts.setOptions({
        lang: {
            drillUpText: 'Volver'
        }
    });
    
    var valorCapaAct = parseInt(document.getElementById("cantCapaAct").value);
    var valorCapaInac = parseInt(document.getElementById("cantCapaInac").value);
    var valorTraAct = parseInt(document.getElementById("cantTraAct").value);
    var valorTraInac = parseInt(document.getElementById("cantTraInac").value);

    // Create the chart
    Highcharts.chart('containerCharTra', {
        chart: {
            height: 250,
            type: 'column'
        },
        title: {
            text: 'Trabajadores actuales Tekonn'
        },
        xAxis: {
            type: 'category'
        },
        yAxis: {
            title: {
                text: 'Cantidad usuarios'
            }

        },
        legend: {
            enabled: false
        },

        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true
                }
            }
        },

        series: [{
                name: 'Total',
                colorByPoint: true,
                data: [{
                        name: 'Capataces',
                        y: valorCapaAct+valorCapaInac,
                        drilldown: 'drillACapataces'
                    }, {
                        name: 'Trabajadores',
                        y: valorTraAct+valorTraInac,
                        drilldown: 'drillTrabajadores'
                    }]
            }],
        drilldown: {
            series: [{
                    name: "Total",
                    id: 'drillACapataces',
                    data: [
                        ['Activos', valorCapaAct],
                        ['Inactivos', valorCapaInac]
                    ]
                }, {
                    name: "Total",
                    id: 'drillTrabajadores',
                    data: [
                        ['Activos', valorTraAct],
                        ['Inactivos', valorTraInac]
                    ]
                }]
        }
    });


})


$(function () {

    Highcharts.setOptions({
        lang: {
            drillUpText: 'Volver'
        }
    });
    
    var valorOpeEnMarchaCapataz = parseInt(document.getElementById("cantOpeEnMarchaCapataz").value);
    var valorOpeFinalizadaCapataz = parseInt(document.getElementById("cantOpeFinalizadaCapataz").value);
    var valorOpeRechazadaCapataz = parseInt(document.getElementById("cantOpeRechazadaCapataz").value);
    var valorOpePendienteCapataz = parseInt(document.getElementById("cantOpePendienteCapataz").value);

    // Create the chart
    Highcharts.chart('containerCharOpeCapa', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: 0,
        plotShadow: false
    },
    title: {
        text: 'Operaciones',
        align: 'center',
        verticalAlign: 'middle',
        y: 40
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
        pie: {
            dataLabels: {
                enabled: true,
                distance: -50,
                style: {
                    fontWeight: 'bold',
                    color: 'white'
                }
            },
            startAngle: -90,
            endAngle: 90,
            center: ['50%', '75%'],
            size: '110%'
        }
    },
    series: [{
        type: 'pie',
        name: 'total',
        innerSize: '40%',
        data: [
            ['Pendientes', valorOpePendienteCapataz],
            ['En marcha', valorOpeEnMarchaCapataz],
            ['Finalizadas', valorOpeFinalizadaCapataz],
            ['Rechazadas', valorOpeRechazadaCapataz]           
        ]
    }]
});

})

$(function () {

    Highcharts.setOptions({
        lang: {
            drillUpText: 'Volver'
        }
    });
    
    var valorOpeEnMarcha = parseInt(document.getElementById("cantOpeEnMarcha").value);
    var valorOpeFinalizada = parseInt(document.getElementById("cantOpeFinalizada").value);
    var valorOpeRechazada = parseInt(document.getElementById("cantOpeRechazada").value);
    var valorOpePendiente = parseInt(document.getElementById("cantOpePendiente").value);

    // Create the chart
    Highcharts.chart('containerCharOpe', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: 0,
        plotShadow: false
    },
    title: {
        text: 'Operaciones',
        align: 'center',
        verticalAlign: 'middle',
        y: 40
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
        pie: {
            dataLabels: {
                enabled: true,
                distance: -50,
                style: {
                    fontWeight: 'bold',
                    color: 'white'
                }
            },
            startAngle: -90,
            endAngle: 90,
            center: ['50%', '75%'],
            size: '110%'
        }
    },
    series: [{
        type: 'pie',
        name: 'total',
        innerSize: '40%',
        data: [
            ['Pendientes', valorOpePendiente],
            ['En marcha', valorOpeEnMarcha],
            ['Finalizadas', valorOpeFinalizada],
            ['Rechazadas', valorOpeRechazada]           
        ]
    }]
});

})

