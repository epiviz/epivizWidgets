HTMLWidgets.widget({

  name: 'scatterplot',

  type: 'output',

  initialize: function(el, width, height) {

    //return epiviz.plugins.charts.ScatterPlot("someid1", el, {});

  },

  renderValue: function(el, bindings, instance) {

    console.log(bindings);

  },

  resize: function(el, width, height, instance) {

  }

});
