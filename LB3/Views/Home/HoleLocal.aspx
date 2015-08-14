<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Holes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
    <h1>Enter Scores (Offline mode)</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<script  type="text/javascript">
    $(document).bind("pageinit", function () {
        //$(document).ready(function () {
        //alert(groupName);
        $.mobile.loadPage('#page-id');

        function isOnLine() {
            return navigator.onLine;
        }

        function reportOnlineStatus() {
            var status = $("#onlineStatus");

            if (isOnLine()) {
                status.text("Online");
                status.
                        removeClass("offline").
                        addClass("online");
             
            }
            else {
                status.text("Offline");
                status.
                        removeClass("online").
                        addClass("offline");
               
            }
        }

        window.applicationCache.onupdateready = function (e) {
            applicationCache.swapCache();
            window.location.reload();
        }

        window.addEventListener("online", function (e) {
            reportOnlineStatus();
            loadLiveView();
        }, true);

        window.addEventListener("offline", function (e) {
            reportOnlineStatus();
        }, true);

        if (isOnLine()) {
            // saveToServer();
        }
        // showCustomer();
        //reportOnlineStatus();

        // $.mobile.loadPage('#page-id');
        var modelChk = holeModelCheck();
        reportOnlineStatus();
        if (modelChk.length == 0) {
            //
            saveHoleToLocal(96);
        }
        var status = document.getElementById('onlineStatus').innerHTML;

       
        drawList(96);
        //checkSync();

    });

    function loadLiveView() {
      
        var YID = getYID();
        var CID = getCID();
        var GID = getGID();
        window.location.href = "/Home/Hole?YID=" + YID + "&GID=" + GID + "&course=Beaconsfield&CID=" + CID;
       
    }

    function scoreModelCheck() {
        var index = "96";
        var model = getHoleModel(index);
        var HoleData = "";
        if (model == null) {
            return null;
        }
        else {

            HoleData = model.HoleData;
            return HoleData;
        }

    }

    function checkSync() {
        var HoleData = holeModelCheck();
        var holes = eval('(' + HoleData + ')');
        var GroupData = getGroupdata();
        var users = eval('(' + GroupData + ')');
        var syncCt = 0;
        var syncBtnHtml = "";
        var syncMsg = "";
        //alert(ScoreData);
        $.each(holes, function (i, result) {
            $.each(users, function (i, item) {
                var local = getSavedstatus(result.HoleID, item.UserID);
                var server = getSavedServerstatus(result.HoleID, item.UserID);
                if (local == true && server == false) {
                    syncCt++
                }
            });
        });
        if (syncCt > 0) {
            syncBtnHtml = "<form id=\"syncBtnID\"><input type=\"button\" data-theme=\"e\" data-inline=\"true\" value=\"Synchronize scores now\" onclick=\"syncHoles(" + syncCt + ")\"></form>";
            syncMsg = syncCt + " scores to synchronize";
        } else {
            //syncBtnHtml = "<form><input type=\"button\" data-theme=\"e\" data-inline=\"true\" value=\"Synchronize scores now\" onclick=\"syncHoles(" + syncCt + ")\"></form>";
            syncMsg = "All scores saved to the server";
        }
        $('#syncBtn').html(syncBtnHtml).trigger('create');
        $('#syncStatus').html(syncMsg).trigger('create');
        //"All scores saved to the server";

    }


    function NewScoreFor(userid, score, HID, YID, GID, ct) {
        var Saved = 0;
        var notSaved = 0;
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
                scoreSavedtoServer("H_" + HID + "_" + userid);
                $('#syncStatus').html("Score(s) saved to server").trigger('create');
                drawList(96);
                checkSync();
            },
            error: function (xhr, error) {
                console.debug(xhr); console.debug(error);
                $('#syncStatus').html("Sync failed").trigger('create');

            }
        });

    }

    function scoreSavedtoServer(HID) {

        var model = getScoreModel(HID);
        model.IsSavedServer = true;


        localStorage.setItem(HID,
            JSON.stringify(model));
        //alert("new score '" + Score + "' saved locally.");
    }

    function syncHoles(ct) {

        var HoleData = holeModelCheck();
        var holes = eval('(' + HoleData + ')');
        var GroupData = getGroupdata();
        var users = eval('(' + GroupData + ')');
        var syncCt = 0;
        var syncBtnHtml = "Saving local scores to the server ... standby";
        $('#syncStatus').html(syncBtnHtml).trigger('create');

        $.each(holes, function (i, result) {
            $.each(users, function (i, item) {
                var local = getSavedstatus(result.HoleID, item.UserID);
                var server = getSavedServerstatus(result.HoleID, item.UserID);
                if (local == true && server == false) {

                    var score = getLocalScore(result.HoleID, item.UserID);
                    var GID = getGID();
                    var YID = getYID();
                    NewScoreFor(item.UserID, score, result.HoleID, YID, GID, ct);
                    syncCt++;

                }
            });
        });

        if (syncCt > 0) {
            drawList(96);
            checkSync();
        } else {

        }

        //$('#syncBtn').html(syncBtnHtml).trigger('create');
    }



    function holeModelCheck() {
        var index = "96";
        var model = getHoleModel(index);
        var HoleData = "";
        if (model == null) {
            return null;
        }
        else {

            HoleData = model.HoleData;
            return HoleData;
        }

    }


    function writeHoleDataToScores(index) {
        var HoleData = "";
        var GroupData = "";
        var GroupSize = "";
        var model = getHoleModel(index);
        if (model == null) {

        }
        else {
            HoleData = model.HoleData;
            GroupData = model.GroupMembers;
            GroupSize = model.GroupSize;
            ScoreData = model.ScoreData;
            //alert(HoleData);
        }

        var scores = eval('(' + HoleData + ')'); //potential scores , userid, hole combos
        var users = eval('(' + GroupData + ')');
        var scoredata = eval('(' + ScoreData + ')');

        $.each(scoredata, function (i, ss) {
            saveServerScore(ss.Score, ss.UserID, ss.HID, ss.ScoreID);
        });
        //NewScoreFor: userid, score, HID, YID, GID
        $.each(scores, function (i, result) {
            $.each(users, function (i, item) {

                var savedScore = getSavedScore(result.HoleID, item.UserID);

                if (savedScore > 0) {
                    saveScoresToLocalS("H_" + result.HoleID + "_" + item.UserID, result.HoleNum, result.HolePin, result.HoleLD, GroupSize, savedScore, item.UserID, result.Par)
                } else {
                    saveScoresToLocal("H_" + result.HoleID + "_" + item.UserID, result.HoleNum, result.HolePin, result.HoleLD, GroupSize, item.UserID, result.Par)
                }
            });
        });

        //add scores to savedScores


        // drawList(96);

    }

    function gotoLocalCard(HID, HoleNum) {
        //location.load
        var index = 96
        var model = getHoleModel(index);
        model.NextHole = HoleNum,
         model.NextHoleID = HID,
         localStorage.setItem(index,
                    JSON.stringify(model));
        window.location.href = "/Home/LocalHoleCard";
    }

    function drawList(index) {
        var HoleData = "";
        var model = getHoleModel(index);
        if (model == null) {
        }
        else {
            HoleData = model.HoleData;
        }
        var scores = eval('(' + HoleData + ')');

        var htmlList_top = "<ul data-role=\"listview\" data-inset=\"true\" data-theme=\"c\" data-dividertheme=\"b\" data-count-theme=\"b\">";
        var htmlList_item = "";
        var comptxt = "";
        var servertxt = "";
        var holeComp = 0;
        $.each(scores, function (i, result) {
            //alert(result.HoleID);
            if (compChk(result.HoleID) == true) {
                comptxt = "<span class=\"ui-li-count\">Completed</span>";
            } else {
                comptxt = "";
            }

            if (comptxt.length > 0) {

                if (serverChk(result.HoleID) == true) {
                    htmlList_item = htmlList_item + "<li data-theme=\"b\" onClick=\"gotoLocalCard(" + result.HoleID + "," + result.HoleNum + ")\"><a href=\"#\">" + result.HoleNum + "</a>" + comptxt + "</li>";
                } else {
                    htmlList_item = htmlList_item + "<li data-theme=\"e\" onClick=\"gotoLocalCard(" + result.HoleID + "," + result.HoleNum + ")\"><a href=\"#\">" + result.HoleNum + "</a>" + comptxt + "</li>";
                }

            } else {

                htmlList_item = htmlList_item + "<li data-theme=\"c\" onClick=\"gotoLocalCard(" + result.HoleID + "," + result.HoleNum + ")\"><a href=\"#\">" + result.HoleNum + "</a></li>";

            }
            //alert(servertxt);


            //htmlList_item = htmlList_item + "<li data-theme=\"e\"><a href=\"#\">" + result.HoleNum + "</a>" + comptxt + "</li>";
        });
        // alert(htmlList_item + " ... " + htmlList_top);
        //htmlList_top + htmlList_item +
        $('#HoleList').html(htmlList_top + htmlList_item + "</ul>").trigger("create"); ;
        //(htmlList_top + htmlList_item + "</ul>").appendTo('#HoleList');
        //data.appendTo( "#recentReportsText" ).trigger( "create" );
        //.trigger('create');
        // "<li data-theme=\"c\" onClick=\"gotoLocalCard()\"><a href=\"#\">55</a></li></ul>").trigger('create');
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

    function getScoreData() {
        var index = "96";
        var model = getHoleModel(index);
        var ScoreData = "";
        if (model == null) {
            ScoreData = null;
        }
        else {
            ScoreData = model.HoleData;
        }
        return ScoreData;
    }

    function getGroupdata() {
        var index = "96";
        var model = getHoleModel(index);
        var GroupData = "";
        if (model == null) {
            return null;
        }
        else {

            GroupData = model.GroupMembers;
            return GroupData;
        }

    }

    function compChk(HID) {
        var GroupData = getGroupdata();
        var users = eval('(' + GroupData + ')');
        var GroupSize = parseInt(getGroupSize(HID));
        var comp = false;

        $.each(users, function (i, item) {
            var saved = false;
            saved = getSavedstatus(HID, item.UserID);

            if (saved == true) {
                GroupSize--;
            }
        });

        if (GroupSize == 0) {
            comp = true;

        }

        return comp;

    }

    function serverChk(HID) {
        var GroupData = getGroupdata();
        var users = eval('(' + GroupData + ')');
        var GroupSize = parseInt(getGroupSize(HID));
        var comp = false;

        $.each(users, function (i, item) {
            var saved = false;
            saved = getSavedServerstatus(HID, item.UserID);

            if (saved == true) {
                GroupSize--;
            }
        });

        if (GroupSize == 0) {
            comp = true;
            //alert("hole sav"); //save to a new hole model
        }

        return comp;

    }

    function getSavedstatus(HID, UserID) {
        var model = getScoreModel("H_" + HID + "_" + UserID);
        var IsSaved = false;
        //alert("H_" + HID + "_" + UserID);
        if (model == null) {
            //return "0";
        }
        else {
            IsSaved = model.IsSaved;
        }

        return IsSaved;

    }

    function getSavedServerstatus(HID, UserID) {
        var model = getScoreModel("H_" + HID + "_" + UserID);
        var IsSaved = false;
        //alert("H_" + HID + "_" + UserID);
        if (model == null) {
            //return "0";
        }
        else {
            IsSaved = model.IsSavedServer;
        }

        return IsSaved;

    }

    function getSavedScore(HID, UserID) {
        var index = "S_" + HID + "_" + UserID;
        var model = getSavedScoreModel(index);
        var Score = 0;
        //alert("H_" + HID + "_" + UserID);
        if (model == null) {
            //return "0";
        }
        else {
            Score = model.Score;
        }

        return Score;

    }

    function getLocalScore(HID, UserID) {
        var index = "H_" + HID + "_" + UserID;
        var model = getScoreModel(index);
        var Score = 0;
        //alert("H_" + HID + "_" + UserID);
        if (model == null) {
            //return "0";
        }
        else {
            Score = model.Score;
        }

        return Score;

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


    function saveServerScore(Score, UserID, HID, ScoreID) {
        var index = "S_" + HID + "_" + UserID;
        var model = getSavedScoreModel(index);

        //alert("H_" + HID + "_" + UserID);
        if (model == null) {
            //return "0";
        }
        else {
            model.Score = Score;
            model.UserID = UserID;
            model.HID = HID
            model.ScoreID = ScoreID;
        }

        localStorage.setItem(index,
                    JSON.stringify(model));

    }

    function saveScoresToLocalS(HID, HoleNum, HolePin, HoleLD, GroupSize, Score, UserID, Par) {

        var model = getScoreModel(HID);

        if (model != null) {

            model.IsSaved = true;
            model.IsSavedServer = true;
            model.Score = Score;
            model.UserID = UserID;
            model.HoleNum = HoleNum;
            model.HolePin = HolePin;
            model.HoleLD = HoleLD;
            model.HID = HID;
            model.GroupSize = GroupSize;
            model.Par = Par;
            localStorage.setItem(HID,
                    JSON.stringify(model));
        }

    }

    function saveScoresToLocal(HID, HoleNum, HolePin, HoleLD, GroupSize, UserID, Par) {

        var model = getScoreModel(HID);
        if (model != null) {
            model.IsSaved = false;
            model.IsSavedServer = false;
            model.HoleNum = HoleNum;
            model.HolePin = HolePin;
            model.HoleLD = HoleLD;
            model.UserID = UserID;
            model.HID = HID;
            model.GroupSize = GroupSize;
            model.Par = Par;
            localStorage.setItem(HID,
                    JSON.stringify(model));
        }
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

    function getScoreModel(HID) {
        var model = {
            HolePin: "",
            HoleLD: "",
            HoleNum: "",
            Par: "",
            Score: "",
            UserID: "",
            IsSaved: false,
            IsSavedServer: false,
            GroupSize: "",
            Key: "",
            ID: ""
        };

        if (localStorage[HID] != null) {
            model = JSON.parse(localStorage[HID]);
        }
        model.Key = HID;
        return model;
    }

    function getSavedScoreModel(index) {
        var model = {
            Score: "",
            UserID: "",
            HID: "",
            ScoreID: "",
            Key: "",
            ID: ""
        };

        if (localStorage[index] != null) {
            model = JSON.parse(localStorage[index]);
        }
        model.Key = index;
        return model;
    }


</script>
 <div id="HoleList">list here</div>
 <div id="syncBtn"></div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
<div data-role="footer" style="overflow:hidden;">
<div><ul data-role="listview" data-theme="a"><li><div class="sync" id="syncStatus">Sync when back online</div></li></ul></div>
<div><ul data-role="listview" data-theme="a"><li><div class="status" id="onlineStatus"></div></li></ul></div>
</div>
</asp:Content>