<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.UserGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Local HoleCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<a href="#" onclick = "goBack();">Back</a>
 <h1 id="topHeader">Enter Scores</h1>
   
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
<script type="text/javascript">

    //get all details from local
    //iterate thru users to render radio boxes

    $(document).bind("pageinit", function () {
        //$(document).ready(function () {
        //alert(groupName);
        $.mobile.loadPage('#page-id');
        var holecount = getHolecount();
        var nextHole = getNexthole();
        document.getElementById('topHeader').innerHTML = "Enter Scores";
        //if refresh calc nextHole - 1
        nextHole = parseInt(nextHole);
        var nextHoleID = getNextholeID(nextHole, holecount);
        var status = isOnLine();
        drawRadios(nextHoleID, nextHole);

        //$('#syncStatus').html("&nbsp;").trigger('create');
        //draw hole list button
        //draw next/prev buttons
        
        if (status == true) {
            $('#evticker').html("Loading Events Feed").trigger('create');
            getEventsPopup();
        } else {
            // $('#evticker').html("Loading Events Feed").trigger('create');
            // getEventsPopup();
        }

    });

    function isOnLine() {
        return navigator.onLine;
    }
   
    function getNexthole() {
        var index = "96";
        var model = getHoleModel(index);
        var NextHole = 0;
        if (model == null) {
            return null;
        }
        else {
           
            NextHole = model.NextHole;
            return NextHole;
        }

    }

    function getHolecount() {
        var index = "96";
        var model = getHoleModel(index);
        var HoleCount = 0;
        if (model == null) {
            return null;
        }
        else {

            HoleCount = model.HoleCount;
            return HoleCount;
        }

    }

    

  

    function getNextholeID(nextHole, holecount) {
        var index = "96";
        var model = getHoleModel(index);
        var NextHoleID = 0;
      
        if (model == null) {
            return null;
        }
        else {

            var HoleData = model.HoleData;
            var holes = eval('(' + HoleData + ')');

            $.each(holes, function (i, result) {
                
                if (result.HoleNum == nextHole) {
                    //alert(result.HoleID);
                    NextHoleID = result.HoleID;
                }
            });

            return NextHoleID;
        }

    }
    function goBack() {
        var YID = getYID();
        var CID = getCID();
        var GID = getGID();
        var online = isOnLine();
     
        if (online == true) {
            window.location.href = "/Home/Hole?YID=" + YID + "&GID=" + GID + "&CID=" + CID;
            //$.mobile.changePage("/Home/Hole?YID=" + YID + "&GID=" + GID + "&CID=" + CID, { reloadPage: true, transition: "none" });
        } else {
            window.location.href = "/Home/HoleLocal";
            //$.mobile.changePage('/Home/HoleLocal', { reloadPage: true, transition: "none" });
        }
    }
    function drawRadios(thisHoleID, thisHole) {
        var index = "96";
        var GPname = "";
        var GPmembers = "";
        var YID = "";
        var GID = "";
        var CID = "";
        var HoleCount = 0;
        var CourseName = "";
        var NextHole = thisHole;
        var HID = thisHoleID;
        var model = getHoleModel(index);    
                if (model == null) {                  
                }
                else {
                    GPname = model.GroupName;
                    GPmembers = model.GroupMembers;
                    //HID = model.NextHoleID;                   
                    GID = model.GID;
                    YID = model.YID;
                    CID = model.CID;
                    CourseName = model.CourseName;
                    HoleCount = model.HoleCount;                 
                }
                //var backbtn = "<a href=\"/Home/Hole?YID=" + YID + "&GID=" + GID + "&course=Beaconsfield&CID=" + CID + "\"  class=\"ui-btn ui-btn-inline ui-btn-up\">Back<\a>";
                var backntn = "<ul><li onClick=\"goBack(" + YID + "," + GID + "," + CID + ")\"</li></ul>";
                $('#backlink').html(backntn).trigger('create');
            var users = eval('(' + GPmembers + ')');
         //NewScoreFor: userid, score, HID, YID, GID
            var html = "";
            var html_score = "";
            var spacer = "";
            var score = 1;
            var Par = "";
            var SI = "";
            $.each(users, function (i, result) {
                var html_score = "";
                var score_info = "";
                var score_class = "";
                var score = 0;
                var i = 1;
                while (i < 10) {
                    var checkScore1 = checkScore("H_" + HID + "_" + result.UserID);
                    Par = getPar("H_" + HID + "_" + result.UserID);
                    SI = 5;
                    score = checkScore1;
                    //alert("H_" + HID + "_" + result.UserID + " " + checkScore1);
                    if (checkScore1 == i) {
                        html_score = html_score + "<input type=\"radio\" onclick=\"NewLocalScoreFor(" + result.UserID + "," + i + "," + HID + "," + YID + "," + GID + ")\" name=\"radio-choice-" + result.UserID + "\" id=\"radio" + i + "\" value=\"" + i + "\" checked=\"checked\" />" +
                          "<label for=\"radio" + i + "\">" + i + "</label>";
                    } else {
                        html_score = html_score + "<input type=\"radio\"  onclick=\"NewLocalScoreFor(" + result.UserID + "," + i + "," + HID + "," + YID + "," + GID + ")\" name=\"radio-choice-" + result.UserID + "\" id=\"radio" + i + "\" value=\"" + i + "\" />" +
                          "<label for=\"radio" + i + "\">" + i + "</label>";
                    }

                    //<input type=\"radio\"  onclick=\"NewScoreFor(2,2,1,1,1)\" name=\"radio-choice-2\" id=\"radio-mini-0\" value=\"2\" />" +
                    //"<label for=\"radio-mini-0\">2</label>";
                    i++;
                }
                var checkScore2 = checkScoreState("H_" + HID + "_" + result.UserID);
                var HolePin = getPinVal("H_" + HID + "_" + result.UserID);
                var HoleLD = getLDVal("H_" + HID + "_" + result.UserID);
                if (checkScore2 == true) {
                    score_info = "Saved (server)";
                    score_class = "score_txt_g"
                } else if (checkScore1 > 0) {
                    score_info = "Saved (locally)";
                    score_class = "score_txt_o"
                } else {
                    score_info = "Select Score";
                    score_class = "score_txt_b"
                }
                html = html + "<tr><td><div class=\"H1thin\">" + result.Nickname + "</div></td><td><div class=\"" + score_class + "\" id=\"scoretxt_" + result.UserID + "_" + HID + "\">" + score_info + "</div></td></tr>" +
                            "<tr><td colspan=\"2\"><fieldset data-role=\"controlgroup\" data-theme=\"c\" data-type=\"horizontal\" data-mini=\"true\">";

                html = html + html_score + "</fieldset></td></tr>";

                if (HolePin > 0) {
                    if (HolePin == result.UserID) {
                        var PinHtml = "<tr><td><div class=\"sliderforpin\"><select data-mini=\"true\" name=\"slider" + result.UserID + "\" id=\"flip-a" + result.UserID + "\" data-role=\"slider\"  data-theme=\"e\"" +
                                "onchange=\"NewLocalScoreForPin(this.value," + result.UserID + "," + HID + "," + YID + "," + GID + ")\" ><option value=\"no\">Nearest the pin?</option>" +
                                "<option value=\"yes\" selected=\"selected\">Yes</option></select></div></td></tr>";
                        html = html + PinHtml;
                    } else {
                        var PinHtml = "<tr><td><div class=\"sliderforpin\"><select data-mini=\"true\" name=\"slider" + result.UserID + "\" id=\"flip-a" + result.UserID + "\" data-role=\"slider\"  data-theme=\"e\"" +
                                "onchange=\"NewLocalScoreForPin(this.value," + result.UserID + "," + HID + "," + YID + "," + GID + ")\" ><option value=\"no\">Nearest the pin?</option>" +
                                "<option value=\"yes\" >Yes</option></select></div></td></tr>";
                        html = html + PinHtml;
                    }
                    //$('#extrainput').html(PinHtml).trigger('create');

                }

                if (HoleLD > 0) {
                    if (HoleLD == result.UserID) {
                        var PinHtml = "<tr><td><div class=\"sliderforLD\"><select data-mini=\"true\" name=\"slider" + result.UserID + "\" id=\"flip-a" + result.UserID + "\" data-role=\"slider\"  data-theme=\"e\"" +
                                "onchange=\"NewLocalScoreForLD(this.value," + result.UserID + "," + HID + "," + YID + "," + GID + ")\" ><option value=\"no\">Longest drive?</option>" +
                                "<option value=\"yes\" selected=\"selected\">Yes</option></select></div></td></tr>";
                        html = html + PinHtml;
                    } else {
                        var PinHtml = "<tr><td><div class=\"sliderforpin\"><select data-mini=\"true\" name=\"slider" + result.UserID + "\" id=\"flip-a" + result.UserID + "\" data-role=\"slider\"  data-theme=\"e\"" +
                                "onchange=\"NewLocalScoreForLD(this.value," + result.UserID + "," + HID + "," + YID + "," + GID + ")\" ><option value=\"no\">Longest drive?</option>" +
                                "<option value=\"yes\" >Yes</option></select></div></td></tr>";
                        html = html + PinHtml;
                    }

                }

                if (HoleLD == 0 && HolePin == 0) {
                    spacer = "<tr><td><div style=\"height:40px\"></div></td></tr>";
                    html = html + spacer;
                }

            });

            var partd = Par;
            var SItd = SI;
            var html_top = "<table>";
            $('#holeNumval').html(thisHole).trigger('create');
            $('#parVal').html(partd);
            $('#SIVal').html(partd);
            $('#scoreinput').html(html_top + html + "</table>").trigger('create');
            //$('#CourseName').html(CourseName).trigger('create');
            drawButtons(thisHole, HoleCount);
           //    refresh_miniLB_feed(CID, YID, thisHole)
            getMiniLB(CID, YID, thisHole);
        }

        function checkScoreState(HID) {
            
            var model = getScoreModel(HID);
            var IsSavedServer = false;

            if (model == null) {
                //return "0";
            }
            else {
                IsSavedServer = model.IsSavedServer;            
            }

            return IsSavedServer;

        }

         function getPar(HID) {
            
            var model = getScoreModel(HID);
            var par = "";

            if (model == null) {
                //return "0";
            }
            else {
                par = model.Par;            
            }

            return par;

        }

        function getCID() {
            var model = getHoleModel("96");
            var CID = "";
            if (model == null) {
            }
            else {
                CID = model.CID;
            }
            return CID;
        }

        function getGID() {
            var model = getHoleModel("96");
            var GID = "";
            if (model == null) {
            }
            else {
                GID = model.GID;
            }
            return GID;
        }

        function getYID() {
            var model = getHoleModel("96");
            var YID = "";
            if (model == null) {
            }
            else {
                YID = model.YID;
           
            }
            return YID;
        }

        function checkScore(HID) {

            var model = getScoreModel(HID);
            var Score = 0;
            //also check server score
            if (model == null) {
                //return "0";
            }
            else {
                Score = model.Score;
            }

            return Score;

        }

        function getPinVal(HID) {

            var model = getScoreModel(HID);
            var HolePin = 0;
            //also check server score
            if (model == null) {
                //return "0";
            }
            else {
                HolePin = model.HolePin;
            }

            return HolePin;

        }

        function getLDVal(HID) {

            var model = getScoreModel(HID);
            var HoleLD = 0;
            //also check server score
            if (model == null) {
                //return "0";
            }
            else {
                HoleLD = model.HoleLD;
            }

            return HoleLD;

        }

        function drawButtons(nextHole, HoleCount) {
            var holecount = getHolecount();
        var prevHole = parseInt(nextHole) - 1;
        nextHole = parseInt(nextHole) + 1;
        var btnTable = "<table><tr>";
        var nextHoleID = getNextholeID(nextHole, HoleCount);
        var prevHoleID = getNextholeID(prevHole, HoleCount);
        var htmlnextBtn = "<form><input type=\"button\" data-theme=\"b\" data-inline=\"true\" value=\"Next Hole\" onclick=\"drawRadios(" + nextHoleID + "," + nextHole + ")\"></form>";
        var htmlprevBtn = "<form><input type=\"button\" data-theme=\"b\" data-inline=\"true\" value=\"Previous Hole\" onclick=\"drawRadios(" + prevHoleID + "," + prevHole + ")\"></form>";      
        $('#prevBtn').html(htmlprevBtn).trigger('create');
        $('#nextBtn').html(htmlnextBtn).trigger('create');
        if (prevHole == 0) {        
            $("#prevBtn").removeClass("ui-enabled");
            $("#prevBtn").addClass("ui-disabled");            
        } else if (prevHole > 0) {
            $("#prevBtn").removeClass("ui-disabled");
            $("#prevBtn").addClass("ui-enabled");            
        }

        if (nextHole > holecount) {           
            $("#nextBtn").removeClass("ui-enabled");
            $("#nextBtn").addClass("ui-disabled");         
        } else if (nextHole <= holecount) {
            $("#nextBtn").removeClass("ui-disabled");
            $("#nextBtn").addClass("ui-enabled");     
        }
        
        //$('#prevBtn').html(htmlprevBtn).trigger('create');
        updateHoleModel(nextHole,HoleCount);
    }

    function updateHoleModel(nextHole,HoleCount) {
        var index = "96";
        var model = getHoleModel(index);
        model.NextHole = nextHole;
        model.NextHoleID = getNextholeID(nextHole, HoleCount); 
        localStorage.setItem(index,
                    JSON.stringify(model));
        // alert("'" + GroupMembers + "' saved locally.");
    }

    function NewLocalScoreFor(userid, score, HID, YID, GID) {
        $('#scoretxt_' + userid + '_' + HID).html("Saving ...").trigger("create").fadeIn('slow');
        saveScoreToLocal("H_" + HID + "_" + userid, score, userid);
        //use HoleID and list of users, iterate tru and check all are saved
 
        NewScoreFor(userid, score, HID, YID, GID);

    }

    function NewLocalScoreForPin(sldval, userid, HID, YID, GID) {
        $('#scoretxt_' + userid + '_' + HID).html("Saving pin ...").trigger("create").fadeIn('slow');
        saveScoreToLocalPin("H_" + HID + "_" + userid, userid);
        SliderForPin(sldval, userid, HID, YID, GID);
    }

    function NewLocalScoreForLD(sldval, userid, HID, YID, GID) {
        $('#scoretxt_' + userid + '_' + HID).html("Saving drive ...").trigger("create").fadeIn('slow');
        saveScoreToLocalLD("H_" + HID + "_" + userid, userid);
        SliderForLD(sldval, userid, HID, YID, GID);
    }

    //save score update for server;
    function scoreSavedtoServer(HID,state) {
       
        var model = getScoreModel(HID);
        model.IsSavedServer = state;


        localStorage.setItem(HID,
            JSON.stringify(model));
        //alert("new score '" + Score + "' saved locally.");
    }

    function getGroupSize(HID) {
        var index = "96";
        var model = getHoleModel(index);
        var GroupSize = 0;
        if (model == null) {
            GroupSize = null;
        }
        else {

            GroupSize = model.GroupSize;

        }

        return GroupSize;
    }


    function saveScoreToLocal(HID, Score, UserID) {
        var GroupSize = getGroupSize(HID);      
        var model = getScoreModel(HID);
        //model.HoleNum = HoleNum;
        //model.HolePin = HolePin;
        model.UserID = UserID;
        model.Score = Score;
        model.IsSaved = true;
        localStorage.setItem(HID,
            JSON.stringify(model));
        //alert("new score '" + Score + "' saved locally.");
    }

    function saveScoreToLocalPin(HID, UserID) {
        var GroupSize = getGroupSize(HID);
        var model = getScoreModel(HID);
        model.HolePin = UserID;
        localStorage.setItem(HID,
            JSON.stringify(model));
    }


    function saveScoreToLocalLD(HID, UserID) {
        var model = getScoreModel(HID);
        model.HoleLD = UserID;
        localStorage.setItem(HID,
            JSON.stringify(model));
    }

  
    function getHoleModel(index) {
        var model = {
            GroupName: "",
            GroupMembers: "",
            HoleData: "",
            ScoreData: "",
            HoleCount: "",
            CourseName: "",
            YID: "",
            HID: "",
            GID: "",
            CID: "",
            NextHole: "",
            PrevHole: "",
            IsDirty: false,
            HDwritten: false,
            Key: "",
            ID: ""
        };

        if (localStorage[index] != null) {
            model = JSON.parse(localStorage[index]);
        }
        model.Key = index;
        return model;
    }


    function getScoreModel(index) {
        var model = {
            HolePin: "",
            HoleLD: "",
            HoleNum: "",
            UserID: "",          
            Score: "",
            IsSaved: false,
            IsSavedServer: false,
            GroupSize: "",
            Key: "",
            ID: ""
        };

        if (localStorage[index] != null) {
            model = JSON.parse(localStorage[index]);
        }
        model.Key = index;
        return model;
    }           

       function SliderForLD(slval, userid, HID, YID, GID) {
           $.ajax({
               type: "POST",
               url: "/Home/newScore",
               data: "GID=" + GID + "&YID=" + YID + "&HID=" + HID + "&score=0&UserID=" + userid + "&Pin=0&LD=1",
               dataType: "html",
               success: function (data) {
                   var json = eval('(' + data + ')');
                   var winner = json.winner;
                   $('#scoretxt_' + userid + '_' + HID).html("Nice one " + winner).trigger("create").fadeIn();

                   $.each(json.members.reverse(), function (i, result) {
                       var id = result.UserID;
                       $('#flip-a' + id).val('off').slider('refresh');
                       $('#scoretxt_' + id + '_' + HID).html("Better luck next time.").trigger('refresh');
                       saveScoreToLocalLD("H_" + HID + "_" + id, 1);
                   });


               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
               }
           });
           return false;
       }

       function SliderForPin(slval, userid, HID, YID, GID) {
           //alert(userid + " " + HID + " " + YID + " " + GID);
           $.ajax({
               type: "POST",
               url: "/Home/newScore",
               data: "GID=" + GID + "&YID=" + YID + "&HID=" + HID + "&score=0&UserID=" + userid + "&Pin=1&LD=0",
               dataType: "html",
               success: function (data) {
                   var json = eval('(' + data + ')');
                   var winner = json.winner;
                   $('#scoretxt_' + userid + '_' + HID).html("Nice one " + winner).trigger("create").fadeIn();

                   $.each(json.members.reverse(), function (i, result) {
                       var id = result.UserID;
                       $('#flip-a' + id).val('off').slider('refresh');
                       $('#scoretxt_' + id + '_' + HID).html("Better luck next time.").trigger("create").fadeIn();
                       saveScoreToLocalPin("H_" + HID + "_" + id, 1);
                   });


               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
                   $('#scoretxt_' + userid + '_' + HID).html("Saved locally").trigger("create");
                   $('#evticker').html("Click Back to Sync scores when next online").trigger('create');
               }
           });
           return false;
       }
      
       function NewScoreFor(userid, score, HID, YID, GID) {
           scoreSavedtoServer("H_" + HID + "_" + userid,false);
           $('#scoretxt_' + userid + '_' + HID).html("Saving ...").trigger("create").fadeIn('slow');
           //alert(HID);
           $.ajax({
               type: "POST",
               url: "/Home/newScore",
               data: "GID=" + GID + "&YID=" + YID + "&HID=" + HID + "&score=" + score + "&Pin=0&LD=0&UserID=" + userid,
               dataType: "html",
               timeout: 5000,
               success: function (data) {
                   var json = eval('(' + data + ')');
                   var type = json.type;
                   var winner = json.winner; // ['winners']['nickname'];
                   $('#scoretxt_' + userid + '_' + HID).removeClass('score_txt_b');
                   $('#scoretxt_' + userid + '_' + HID).addClass('score_txt_g');
                   $('#scoretxt_' + userid + '_' + HID).html(type).trigger("create");
                   //getscores
                   getMiniLB(json.CID, json.YID, json.HoleNum);
                   scoreSavedtoServer("H_" + HID + "_" + userid, true); //for testing
               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
                   $('#scoretxt_' + userid + '_' + HID).removeClass('score_txt_b');
                   $('#scoretxt_' + userid + '_' + HID).addClass('score_txt_o');
                   $('#scoretxt_' + userid + '_' + HID).html("Saved locally").trigger("create");
                   $('#evticker').html("Click Back to Sync scores when next online").trigger('create');
               }
           });
           return false;
       }

</script>
<div style="text-align: right">
<table>
<tr>
<td><div class="Header2">Hole</div></td>
<td><div class="tdspace">&nbsp;</div></td>
<td><div class="Header2">Par</div></td>
<td><div class="tdspace">&nbsp;</div></td>
<td><div class="Header2">SI</div></td>
</tr>
<tr>
<td class="tdcentre"><div class="Header1" id="holeNumval"></div></td>
<td><div class="tdspace">&nbsp;</div></td>
<td class="tdcentre"><div class="Header1" id="parVal"></div></td>
<td><div class="tdspace">&nbsp;</div></td>
<td class="tdcentre"><div class="Header1" id="SIVal"></div></td>
</tr>
</table>
</div>
  <div id="scoreinput"></div>
  <div id="extrainput"></div>
  <table><tr><td>
  <div id="prevBtn"></div></td>
  <td>
  <div id="nextBtn"></div></td></tr>
  </table>
<div style="text-align:center;padding-top:30px">
  <form>
<fieldset data-role="controlgroup" data-type="horizontal">
<input type="radio" name="radio-choice-h-2" id="radio-choice-h-2a" value="on" onclick="showEvents()">
<label for="radio-choice-h-2a">Events Feed</label>
<input type="radio" name="radio-choice-h-2" id="radio-choice-h-2b" value="on" checked="checked" onclick="showMiniLB()">
<label for="radio-choice-h-2b">Leaderboard</label>
</fieldset>
</form>
</div>
<div id="evticker" class="ticker" style="display:none;width:auto">
</div>
<div id="miniLB"></div>
  <div id="EIDxy" style="display: none"></div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">

<div data-role="footer" style="overflow:hidden;">
<div><ul data-role="listview" data-theme="a"><li><div class="status" id="onlineStatus"></div></li></ul></div>
</div>
</asp:Content>

 