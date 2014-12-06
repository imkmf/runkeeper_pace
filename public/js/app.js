function returnAxisLabel(name) {
  return {
    text: name,
    position: 'middle'
  }
}

$.getJSON("data.json").then(function(data) {
  var chart = c3.generate({
    bindto: '#chart',
    data: {
      x: 'x',
      columns: data
    },
    axis: {
      x: {
        type: 'timeseries',
        tick: {
          format: '%Y-%m-%d'
        }
      },
      y: {
        label: returnAxisLabel("Pace (m/mi)")
      }
    }
  });
});
