HTMLWidgets.widget({

  name: 'scatterplot',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      width: width,
      height: height,
    };

  },

  renderValue: function(el, bindings, instance) {
    console.log(bindings);

    var boundaries = new epiviz.datatypes.GenomicRange(
      bindings.range.seqname,
      bindings.range.start,
      bindings.range.width
    );

    var se = new epiviz.datatypes.PartialSummarizedExperiment();
    var ms = new epiviz.measurements.MeasurementSet();
    var chartDataHash = new epiviz.measurements.MeasurementHashtable();

    var rawMeasurements = JSON.parse(bindings.ms);
    for (var i = 0; i < rawMeasurements.length; ++i) {
      var measurement = new epiviz.measurements.Measurement(
        rawMeasurements[i]['id'],
        rawMeasurements[i]['name'],
        rawMeasurements[i]['type'],
        rawMeasurements[i]['datasourceId'],
        rawMeasurements[i]['datasourceGroup'],
        "some_provider_id_1",
        null,
        rawMeasurements[i]['defaultChartType'],
        rawMeasurements[i]['annotation'],
        rawMeasurements[i]['minValue'],
        rawMeasurements[i]['maxValue'],
        rawMeasurements[i]['metadata']
      );
      ms.add(measurement);

      feature_vals = new epiviz.datatypes.FeatureValueArray(
        measurement,
        boundaries,
        bindings.values[i].globalStartIndex,
        bindings.values[i].values
      );

      se.addValues(feature_vals);
      chartDataHash.put(measurement, new epiviz.datatypes.MeasurementGenomicDataWrapper(measurement, se));
    }

    var chartData = new epiviz.datatypes.MapGenomicData(chartDataHash);
    var config = new epiviz.ui.controls.VisConfigSelection(ms);

    var chartType = new epiviz.plugins.charts.ScatterPlotType();
    var chartProperties = new epiviz.ui.charts.VisualizationProperties(
      instance.width,
      instance.height,
      chartType.defaultMargins(),
      config,
      chartType.defaultColors(),
      null,
      chartType.customSettingsValues(),
      chartType.customSettingsDefs(),
      [],
      null
    );

    chart = new epiviz.plugins.charts.ScatterPlot("someid2", el, chartProperties);
    chart.draw(undefined, chartData);
  },

  resize: function(el, width, height, instance) {

  }

});
