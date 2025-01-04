function obterDadosGrafico() {
  loading();
  document.getElementById("fotoPerfil").src = sessionStorage.PATH_FOTO;
  Chart.defaults.color = "#fff";
  fetch(`/dashboard`, { cache: 'no-store' })
  .then((response) =>  {
      if (response.ok) {
          response.json()
          .then((resposta) =>  {
              console.log(resposta);
              plotarKPI(resposta.usuariosTotais, resposta.usuariosAtivos, resposta.featsTotais);
              plotarGeneros(resposta.generosRecorrentes);
              plotarStatusFeats(resposta.statusFeats);
              plotarAplicativos(resposta.appsRecorrentes);
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

function plotarKPI(totUser, actUser, totFeats){
  var kpiTotalUsuarios = document.getElementById("usuariosTotal");
  var kpiUsuariosAtivos = document.getElementById("usuariosAtivos");
  var kpiFeats = document.getElementById("featsTotais");

  kpiTotalUsuarios.innerText = totUser;
  kpiUsuariosAtivos.innerText = actUser;
  kpiFeats.innerText = totFeats;
}

function plotarGeneros(data){
  var genero = document.getElementById("generos");

  var dataChart = {
    labels: [],
      datasets: [
        {
          data: [],
          backgroundColor: "#BE0000",
        },
      ],
  };

  data.forEach((genero) =>  {
    dataChart.labels.push(genero.nome);
    dataChart.datasets[0].data.push(genero.total);
  });

  new Chart(genero, {
    type: "bar",
    data: dataChart,
    options: {
      plugins: {
        legend: {
          display: false,
        },
        title: {
          display: true,
          text: "Gêneros Musicais mais Produzidos",
        },
      },
      scales: {
        x: {
          grid: {
            display: false,
          },
        },
        y: {
          beginAtZero: true,
          grid: {
            color: "#fff",
          },
        },
      },
    },
  });
}

function plotarStatusFeats(data){
  var feat = document.getElementById("feats");
  var totalFeats = 0;

  var dataChart = {
    labels: [],
    datasets: [
      {
        data: [],
        backgroundColor: ["#ada210", "#006400","#BE0000"],
        borderWidth: [0, 0],
      },
    ],
  };

  data.forEach((status) =>  {
    dataChart.labels.push(status.nome);
    dataChart.datasets[0].data.push(status.total);
    totalFeats += status.total;
  });

  new Chart(feat, {
    type: "pie",
    data: dataChart,
    options: {
      plugins: {
        title: {
          display: true,
          text: "Status dos Feats",
        },
        tooltip: {
          callbacks: {
            label: function (item) {
              var valor = dataChart.datasets[0].data[item.dataIndex];
              var porcentagem = ((valor / totalFeats) * 100).toFixed(2); // Calcula o percentual arredondado
              return `${porcentagem}% (${value})`;
            },
          },
        },
        datalabels: {
          formatter: (valor, ctx) => {
            var porcentagem = ((valor / totalFeats) * 100).toFixed(2);
            return `${porcentagem}%`; // Mostra o percentual dentro da fatia
          },
          color: "#fff",
          font: {
            weight: "bold",
          },
        },
      },
    },
    plugins: [ChartDataLabels], 
  });
}

function plotarAplicativos(data){
  var aplicativo = document.getElementById("aplicativos");


  var dataChart = {
    labels: [],
    datasets: [
      {
        data: [],
        backgroundColor: "#BE0000",
      },
    ],
  };

  data.forEach((app) =>  {
    dataChart.labels.push(app.nome);
    dataChart.datasets[0].data.push(app.total);
  });

  new Chart(aplicativo, {
    type: "bar",
    data: dataChart,
    options: {
      plugins: {
        legend: {
          display: false,
        },
        title: {
          display: true,
          text: "Aplicativos de Produção mais Utilizados",
        },
      },
      scales: {
        x: {
          grid: {
            display: false,
          },
        },
        y: {
          beginAtZero: true,
          grid: {
            color: "#fff",
          },
        },
      },
    },
  });
}