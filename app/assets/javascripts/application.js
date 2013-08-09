// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require flot/jquery.flot
//= require_tree .
//= require foundation

$(function () {
  $('.flot-placeholder').each(function (index) {
    var thisGraph = $(this);
    var total_time = {color: 'yellow', data: [[parseFloat(thisGraph.attr('data-time-total')), 0]]};
    if (thisGraph.attr('data-time-budget')) {
      var budget_time = {
        color: 'blue', data: [[thisGraph.attr('data-time-budget'), 0]]
      }
    } else {
      var budget_time = {color: 'blue', data: [[thisGraph.attr('data-time-budget'), 0]]}
    }
    thisGraph.plot([total_time,
      budget_time
    ], defaultGraphOptions).data('plot');
  });
});


var defaultGraphOptions = {
  grid: {
//    show: false,
    borderWidth: 0
  },
  bars: {
    align: "center",
    barWidth: 0.5,
    horizontal: true,
//    fillColor: { colors: [{ opacity: 0.5 }, { opacity: 1}] },
    lineWidth: 1
  },
  yaxis: {
    show: false},
  xaxis: {
    show: false},
  series: {
    bars: {show: true},
//    lines, points, bars: {
//      show: boolean
//      lineWidth: number
//      fill: boolean or number
//      fillColor: null or color/gradient
//    }

//    lines, bars: {
//      zero: boolean
//    }

//    points: {
//      radius: number
//      symbol: "circle" or function
//    }

//    bars: {
//      barWidth: number
//      align: "left", "right" or "center"
//          horizontal: boolean
//}
//
//lines: {
//  steps: boolean
//}

    shadowSize: 0
//highlightColor: color or number
  }
//  colors: []
};