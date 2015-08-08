<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.UserGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Local HoleCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "Hole", "Home", new { onclick = "goBack();"}) %>
 <h1>Enter Scores</h1>
   
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
<script type="text/javascript">

    //get all details from local
    //iterate thru users to render radio boxes

    $(document).bind("pageinit", function () {
        //$(document).ready(function () {
        //alert(groupName);
        $.mobile.loadPage('#page-id');
        var holecount = getHolecount(); ;
        var nextHole = getNexthole();
        //if refresh calc nextHole - 1
        nextHole = parseInt(nextHole);
        var nextHoleID = getNextholeID(nextHole, holecount);

        drawRadios(nextHoleID, nextHole);

        $('#syncStatus').html("&nbsp;").trigger('create');
        //draw hole list button
        //draw next/prev buttons

        if (status == "Online") {
            $('#eventsfeed').html("Loading Events Feed").trigger('create');
            getEventsPopup();
        } else {
            $('#eventsfeed').html("Loading Events Feed").trigger('create');
            getEventsPopup();
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
        alert(online);
        if (online == true) {
            window.location.href = "/Home/Hole?YID=" + YID + "&GID=" + GID + "&course=Beaconsfield&CID=" + CID;
        } else {
            window.location.href = "/Home/HoleLocal";
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
            var score = 1;
            var Par = "";
            $.each(users, function (i, result) {
                var html_score = "";
                var score_info = "";
                var score = 0;
                var i = 1;
                while (i < 10) {
                    var checkScore1 = checkScore("H_" + HID + "_" + result.UserID);
                    Par = getPar("H_" + HID + "_" + result.UserID);
                    score = checkScore1;
                    //alert("H_" + HID + "_" + result.UserID + " " + checkScore1);
                    if (checkScore1 == i) {
                        html_score = html_score + "<input type=\"radio\"  onclick=\"NewLocalScoreFor(" + result.UserID + "," + i + "," + HID + "," + GID + "," + YID + ")\" name=\"radio-choice-" + result.UserID + "\" id=\"radio" + i + "\" value=\"" + i + "\" checked=\"checked\" />" +
                          "<label for=\"radio" + i + "\">" + i + "</label>";
                    } else {
                        html_score = html_score + "<input type=\"radio\"  onclick=\"NewLocalScoreFor(" + result.UserID + "," + i + "," + HID + "," + GID + "," + YID + ")\" name=\"radio-choice-" + result.UserID + "\" id=\"radio" + i + "\" value=\"" + i + "\" />" +
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
                } else if (checkScore1 > 0) {
                    score_info = "Saved (locally)";
                } else {
                    score_info = "Select Score";
                }
                html = html + "<tr><td><div class=\"H1thin\">" + result.Nickname + "</div></td><td><div class=\"thin\" id=\"scoretxt_" + result.UserID + "_" + HID + "\">" + score_info + "</div></td></tr>" +
                            "<tr><td colspan=\"2\"><fieldset data-role=\"controlgroup\" data-type=\"horizontal\" data-mini=\"true\">";

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
                    //$('#extrainput').html(PinHtml).trigger('create');
                }

            });
            var html_top = "<h2>" + CourseName + ", hole No. " + thisHole + ", par " + Par + "</h2><table>";
            $('#scoreinput').html(html_top + html + "</table>").trigger('create');
            //$('#CourseName').html(CourseName).trigger('create');
            drawButtons(thisHole, HoleCount);
            getMiniLB(CID, thisHole);
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
        if (prevHole == 0) {
            htmlprevBtn = " ";
        }
        if (nextHole > holecount) {
            htmlnextBtn = " ";
        } 
        $('#nextBtn').html(htmlnextBtn).trigger('create');
        $('#prevBtn').html(htmlprevBtn).trigger('create');
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
               data: "GID=" + GID + "&HID=" + HID + "&YID=" + YID + "&score=0&UserID=" + userid + "&Pin=0&LD=1",
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
               data: "GID=" + GID + "&HID=" + HID + "&YID=" + YID + "&score=0&UserID=" + userid + "&Pin=1&LD=0",
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
                   $('#syncStatus').html("Click Back to Sync scores when next online").trigger('create');
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
                   $('#scoretxt_' + userid + '_' + HID).html(type).trigger("create");
                   //getscores
                   getMiniLB(json.CID, json.HoleNum);
                   scoreSavedtoServer("H_" + HID + "_" + userid,false); //for testing
               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
                   $('#scoretxt_' + userid + '_' + HID).html("Saved locally").trigger("create");
                   $('#syncStatus').html("Click Back to Sync scores when next online").trigger('create');
               }
           });
           return false;
       }

</script>

  <div id="scoreinput"></div>
  <div id="extrainput"></div>
  <table><tr><td>
  <div id="prevBtn"></div></td>
  <td>
  <div id="nextBtn"></div></td></tr></table>
  <div id="EIDxy" style="display: none"></div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
<div data-role="footer" style="overflow:hidden;">
<table><tr><td><div id="miniLB"></div></td><td class="rightAlign"><div id="evticker"></div></td></tr></table>

<div><ul data-role="listview" data-theme="a"><li><div class="sync" id="syncStatus"></div></li></ul></div>
<div><ul data-role="listview" data-theme="a"><li><div class="status" id="onlineStatus"></div></li></ul></div>
</div>
</asp:Content>

 