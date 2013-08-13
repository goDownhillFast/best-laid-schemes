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
//=  foundation/foundation.alerts
//=  foundation/foundation.clearing
//=  foundation/foundation.cookie
//=  foundation/foundation.dropdown
//=  foundation/foundation.forms
//=  foundation/foundation.joyride
//=  foundation/foundation.magellan
//=  foundation/foundation.orbit
//=  foundation/foundation.reveal
//=  foundation/foundation.section
//=  foundation/foundation.tooltips
//=  foundation/foundation.topbar
//=  foundation/foundation.interchange
//=  foundation/foundation.placeholder
//=  foundation/foundation.abide

$(document).foundation();
$(function () {
  $('.flot-placeholder').each(function (index) {
    var thisGraph = $(this);
    var thisRow = $(this).closest('.summary');
    var total_time_amount = parseFloat(thisGraph.attr('data-time-total')); // add this when page is fixed + parseFloat(thisRow.find('.todays-plan').attr('data-time')) - parseFloat(thisRow.find('.seven-days-ago').attr('data-time'));
    var budget_time_amount = parseFloat(thisGraph.attr('data-time-budget'));
    if(total_time_amount > budget_time_amount){
       var allotted_time_amount = budget_time_amount
    }else {
      var allotted_time_amount = total_time_amount
    }

    var allotted_time_graph = {color: '#10C579', data: [[allotted_time_amount, 0]]};


    var total_time_graph = {color: '#FFE054', data: [[total_time_amount, 0]]};
    if (thisGraph.attr('data-time-budget')) {
      var budget_time_graph = {
        color: '#FFFFFF', data: [[budget_time_amount, 0]]
      }
    } else {
      var budget_time_graph = {color: '#FFFFFF', data: [[budget_time_amount, 0]]}
    }
    thisGraph.plot([budget_time_graph, total_time_graph, allotted_time_graph], defaultGraphOptions).data('plot');
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
    fillColor: { colors: [{ brightness: 0.8 }, { brightness: 1}] },
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