<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.UserGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Local HoleCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<div id="backLink"></div>
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

        //alert(groupName);
        var holecount = getHolecount(); ;
        var nextHole = getNexthole();
        nextHole = parseInt(nextHole);
        var nextHoleID = getNextholeID(nextHole, holecount);
        //alert(nextHoleID);
        drawRadios(nextHoleID, nextHole);
        //draw hole list button
        //draw next/prev buttons
    });

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

    function drawRadios(thisHoleID, thisHole) {
        var index = "96";
        var GPname = "";
        var GPmembers = "";
        var YID = "";
        var GID = "";
        var HoleCount = 0;
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
                    HoleCount = model.HoleCount;
                    //alert(GPmembers);
                }

       
            var users = eval('(' + GPmembers + ')');
         //NewScoreFor: userid, score, HID, YID, GID
            var html = "";
            var html_score = "";
            var score = 1;
            var html_top = "<h2>No. " + thisHole + ", Par 3, NB Links</h2><table>";
            $.each(users, function (i, result) {
                var html_score = "";
                var score_info = "";
                var score = 0;
                var i = 1;
                while (i < 10) {
                    var checkScore1 = checkScore("H_" + HID + "_" + result.UserID);
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
            });

            $('#scoreinput').html(html_top + html + "</table>").trigger('create');
            drawButtons(thisHole,HoleCount);

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

    function drawButtons(nextHole, HoleCount) {
        var prevHole = parseInt(nextHole) - 1;
        nextHole = parseInt(nextHole) + 1;
        var btnTable = "<table><tr>";
        var nextHoleID = getNextholeID(nextHole, HoleCount);
        var prevHoleID = getNextholeID(prevHole, HoleCount);
        //alert(nextHoleID);

        //<div onclick=\"drawRadios(" + nextHoleID + "," + nextHole + ")\">next
        //var htmlnextBtn = "<td><ul data-role=\"listview\" data-inset=\"true\" data-theme=\"c\">" +
        //"<li data-theme=\"e\" onclick=\"drawRadios(" + nextHoleID + "," + nextHole + ")\"><a href=\"#\">Next Hole</a><span class=\"ui-li-count\">4</span></li></ul></td>";
        var htmlnextBtn = "<form><input type=\"button\" data-theme=\"b\" data-inline=\"true\" value=\"Next Hole\" onclick=\"drawRadios(" + nextHoleID + "," + nextHole + ")\"></form>";
        var htmlprevBtn = "<form><input type=\"button\" data-theme=\"b\" data-inline=\"true\" value=\"Previous Hole\" onclick=\"drawRadios(" + prevHoleID + "," + prevHole + ")\"></form>";      
        //"<a href=\"#\" class=\"ui-btn ui-shadow ui-corner-all ui-icon-delete ui-btn-icon-notext\" onclick=\"drawRadios(" + nextHoleID + "," + nextHole + ")\">Next</a>";
        //class=\"ui-btn ui-btn-inline ui-icon-delete ui-btn-icon-right\"
       // var htmlprevBtn = "<td><ul data-role=\"listview\">" +
       // "<li data-theme=\"e\" onclick=\"drawRadios(" + prevHoleID + "," + prevHole + ")\"><a href=\"#\">Next Hole</a><span class=\"ui-li-count\">4</span></li></ul></td>";
    
        //var htmlprevBtn = "<div onclick=\"drawRadios(" + prevHoleID + "," + prevHole + ")\">prev</div>";
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

    //save score update for server;
    function scoreSavedtoServer(HID) {
       
        var model = getScoreModel(HID);
        model.IsSavedServer = true;


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
       // alert(GroupSize);
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

  
     function getHoleModel(index) {
        var model = {
            GroupName: "",
            GroupMembers: "",
            YID: "",
            GID: "",
            NextHole: "",
            NextHoleID: "",
            PrevHole: "",
            GroupSize: "",
            IsDirty: false,
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
                   $.each(json.winners.reverse(), function (i, result) {
                       var nickname = result.nickname;
                       $('#scoretxt_' + userid + '_' + HID).html("Nice one " + nickname).trigger('refresh');
                   });

                   $.each(json.members.reverse(), function (i, result) {
                       var id = result.UserID;
                       $('#flip-a' + id).val('off').slider('refresh');
                       $('#scoretxt_' + id + '_' + HID).html("Better luck next time.").trigger('refresh');
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
                   $.each(json.winners.reverse(), function (i, result) {
                       var nickname = result.nickname;
                       $('#scoretxt_' + userid + '_' + HID).html("Nice one " + nickname).trigger("create").fadeIn();
                   });

                   $.each(json.members.reverse(), function (i, result) {
                       var id = result.UserID;
                       $('#flip-a' + id).val('off').slider('refresh');
                       $('#scoretxt_' + id + '_' + HID).html("Better luck next time.").trigger("create").fadeIn();
                   });


               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
               }
           });
           return false;
       }

       function NewScoreFor(userid, score, HID, YID, GID) {
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
                   $('#scoretxt_' + userid + '_' + HID).html(type ).trigger("create");
                   //getscores
                   getMiniLB(YID, GID, HID);
                   scoreSavedtoServer("H_" + HID + "_" + userid);
               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
                   $('#scoretxt_' + userid + '_' + HID).html("Saved locally").trigger("create");
               }
           });
           return false;
       }

</script>
 <h2><div id="HoleTitle">No. x on course y, par n</div></h2>
  <div id="scoreinput"></div>
  <table><tr><td>
  <div id="prevBtn"></div></td>
  <td>
  <div id="nextBtn"></div></td></tr></table>
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
<div data-role="footer" style="overflow:hidden;">
<div data-theme="a" id="onlineStatus"></div>
<div data-role="navbar">
<ul><li><a href="#">Home</a></li> <li><a onclick="refresh_feed()" href="#">Refresh Events Feed</a></li> <li><a href="#">Check Connection</a></li></ul>
</div></div>
</asp:Content>

 