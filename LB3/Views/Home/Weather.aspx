<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Weather
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">

    <h2>Weather</h2>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

  <script type="text/javascript">
      $(function () {

          var loc = "51.601364,-0.636234";

          var data_success = 0;
          $.ajax({
              url: "http://api.wunderground.com/api/bf45926a1b878028/hourly/geolookup/q/" + loc + ".json",
              dataType: "jsonp",
              success: function (json) {
                  //var jsontext = JSON.stringify(json);

                  var location = json['location']['city'];

                  //alert("got data " + location);

                  var cutoff = parseInt("16");
                  //var parsed_json = json;
                 
                  var timenow = new Date();
                  var hour_now = timenow.getHours();
                  var today = timenow.getDate();
                  
                  //alert("saved= " + json_data);
                  var posy = 14;
                  var posyt = 25;
                  var example = document.getElementById('wcanvas');
                  var ctx2d = example.getContext('2d');
                  var ni = 1;
                  var done_dt = 0;
                  var hour_bg_bk = "8695B7";
                  ctx2d.fillStyle = hour_bg_bk;
                  ctx2d.fillRect(2, 0, 50, 14);
                  ctx2d.font = '9px Arial';
                  ctx2d.fillStyle = '#FFF';
                  ctx2d.fillText("Hour", 5, 10);

                  ctx2d.fillStyle = "51D251";
                  ctx2d.fillRect(54, 0, 80, 14);
                  ctx2d.font = '9px Arial';
                  ctx2d.fillStyle = 'FFF';
                  ctx2d.fillText("Wind speed (mph)", 58, 10);


                  ctx2d.fillStyle = "FFB336";
                  ctx2d.fillRect(136, 0, 48, 14);
                  ctx2d.font = '9px Arial';
                  ctx2d.fillStyle = 'FFF';
                  ctx2d.fillText("Temp (c)", 140, 10);


                  ctx2d.fillStyle = "FFB336";
                  ctx2d.fillRect(316, 0, 52, 14);
                  ctx2d.font = '9px Arial';
                  ctx2d.fillStyle = 'FFF';
                  ctx2d.fillText("Drying time", 318, 10);

                  var dt = parseInt(0);
                  var dt_ct = parseInt(0);
                  var total_score = parseInt(0);

                  $.each(json.hourly_forecast, function (i, zone) {

                      var ws = (parseInt(zone.wspd.english) * 6) + 10;
                      var temp = (parseInt(zone.temp.metric) * 3) + 10;
                      var hour = zone.FCTTIME.civil;
                      var sky = parseInt(zone.sky);
                      var rain = parseInt(zone.qpf.metric);
                      var hour_bg_bk = "9F9F9F";
                      var wind_bg = "51D251";
                      var temp_bg = "FFB336";
                      var wind_txt = "FFF";
                      var temp_txt = "FFF";
                      var cond = zone.condition;
                      var humid = parseInt(zone.humidity);
                      var score = Math.round(((parseInt(zone.wspd.english) * 2) + (parseInt(zone.temp.metric) * 2) + (((100 - sky) / 5) * 4) + (((100 - humid) / 10) * 15)) / 2);


                      var yday = parseInt(zone.FCTTIME.yday);
                      var hour_padded = parseInt(zone.FCTTIME.hour);
                      var civil = parseInt(zone.FCTTIME.civil);

                      if (hour_padded > cutoff || hour_padded < 8) {

                          dt_ct = dt_ct + 1;

                          if (ni == 1) {



                              hour_bg_bk = "8695B7";
                              ctx2d.fillStyle = hour_bg_bk;
                              ctx2d.fillRect(2, posy, 50, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = '#FFF';
                              ctx2d.fillText(hour, 5, posyt);


                              ctx2d.fillStyle = "7DA77D";
                              ctx2d.fillRect(52, posy, ws, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = wind_txt;
                              ctx2d.fillText(zone.wspd.english, 40 + ws, posyt);

                              ctx2d.fillStyle = "B8A27D";
                              ctx2d.fillRect(52 + ws, posy, temp, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = temp_txt;
                              ctx2d.fillText(zone.temp.metric, 40 + ws + (temp - 2), posyt);

                              ctx2d.fillStyle = "FFF";
                              ctx2d.fillRect(52 + ws + temp, posy, 20, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = "#868686";
                              ctx2d.fillText(cond, 52 + ws + temp + 3, posyt);

                              ctx2d.fillStyle = hour_bg_bk;
                              ctx2d.fillRect(318, posy, 50, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = '#FFF';
                              ctx2d.fillText("Past cutoff", 320, posyt);


                              posy = posy + 15;
                              posyt = posyt + 15;
                              ni = ni + 1;

                          } else {

                              hour_bg_bk = "8695B7";
                              ctx2d.fillStyle = hour_bg_bk;
                              ctx2d.fillRect(2, posy, 50, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = '#FFF';
                              ctx2d.fillText(hour, 5, posyt);


                              ctx2d.fillStyle = "7DA77D";
                              ctx2d.fillRect(52, posy, ws, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = wind_txt;
                              ctx2d.fillText(zone.wspd.english, 42 + ws, posyt);

                              ctx2d.fillStyle = "B8A27D";
                              ctx2d.fillRect(52 + ws, posy, temp, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = temp_txt;
                              ctx2d.fillText(zone.temp.metric, 40 + ws + (temp - 2), posyt);

                              ctx2d.fillStyle = "FFF";
                              ctx2d.fillRect(52 + ws + temp, posy, 20, 14);
                              ctx2d.font = '9px Arial';
                              ctx2d.fillStyle = "#868686";
                              ctx2d.fillText(cond, 52 + ws + temp + 3, posyt);
                              posy = posy + 15;
                              posyt = posyt + 15;
                              dt_ct = 0;

                          }

                      } else {

                          ctx2d.restore();

                          if (rain >= 1 && rain < 5) {
                              wind_bg = "67BC67";
                              temp_bg = "D7AA5F";

                          } else if (rain > 4) {
                              wind_bg = "7DA77D";
                              temp_bg = "B8A27D";

                          } else {
                              if (sky < 25) {
                                  hour_bg_bk = "437AFA";
                              }

                              if (sky < 50 && sky > 26) {
                                  hour_bg_bk = "5682E7";
                              }

                              if (sky < 75 && sky > 51) {
                                  hour_bg_bk = "6A8AD4";
                              }

                              if (sky < 101 && sky > 76) {
                                  hour_bg_bk = "8695B7";
                              }

                          }

                          var userhtml = " ";

                          ctx2d.fillStyle = hour_bg_bk;
                          ctx2d.fillRect(2, posy, 50, 14);
                          ctx2d.font = '9px Arial';
                          ctx2d.fillStyle = '#FFF';
                          ctx2d.fillText(hour, 5, posyt);


                          ctx2d.fillStyle = wind_bg;
                          ctx2d.fillRect(52, posy, ws, 14);
                          ctx2d.font = '9px Arial';
                          ctx2d.fillStyle = wind_txt;
                          ctx2d.fillText(zone.wspd.metric, 40 + ws, posyt);

                          ctx2d.fillStyle = temp_bg;
                          ctx2d.fillRect(52 + ws, posy, temp, 14);
                          ctx2d.font = '9px Arial';
                          ctx2d.fillStyle = temp_txt;
                          ctx2d.fillText(zone.temp.metric, 40 + ws + (temp - 2), posyt);



                          total_score = total_score + score;

                          dt_ct = dt_ct + 1;

                          ctx2d.fillStyle = "FFF";
                          ctx2d.fillRect(52 + ws + temp, posy, 20, 14);
                          ctx2d.font = '9px Arial';
                          ctx2d.fillStyle = "#868686";
                          ctx2d.fillText(cond, 52 + ws + temp + 3, posyt);

                          ctx2d.fillStyle = temp_bg;
                          ctx2d.fillRect(350, posy, 18, 14);
                          ctx2d.font = '9px Arial';
                          ctx2d.fillStyle = temp_txt;
                          //alert(dt_ct);

                          if (total_score > 120) {
                              var res = dt_ct;
                              if (done_dt == 0) {

                                  $('#calc').html(" time: " + res + " hours");
                                  //alert("dt = " + res);
                              }
                              done_dt = 1;
                              //ctx2d.fillText(dt_ct, 352, posyt - (dt_ct * 15) + 15);
                              while (dt_ct > 0) {
                                  //alert(dt_ct);
                                  ctx2d.fillText(res, 352, posyt - (dt_ct * 15) + 15);
                                  dt_ct = dt_ct - 1;
                              }



                              total_score = 0;
                          }



                          ctx2d.save();

                          ni = 1;


                      }

                      if (ni == 1) {

                          posy = posy + 15;
                          posyt = posyt + 15;

                      }

                      // moveBox();

                  });
    
  
            
           

              },
              error: function (xhr, error) {
                  console.debug(xhr); console.debug(error);
              },
              complete: function () {

              }
          });

      });
 //              
           


   </script>
 <h4>Beaconsfied next 24 Hours</h4>
<canvas width="300px" height="600px" id="wcanvas">Canvas is not supported</canvas>

</asp:Content>
