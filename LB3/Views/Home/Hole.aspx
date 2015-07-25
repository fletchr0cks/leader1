<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Hole>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Holes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "Groups", "Home", new { YID = ViewData["YearID"], GID = ViewData["GID"], course = ViewData["course"], CID = ViewData["CID"], target = "Hole" }, null)%>
    <h1>Enter Scores</h1>
</asp:Content>

 
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<script  type="text/javascript">
    //put this into local storage
    //?YID=1&GID=1&course=NB%20Links&CID=1
    //var YID = 1;
    //var GID = 1;
    //var CID = 1;
 
    var course = "NB Links";
    //var groupName = '<%=ViewData["Group"] %>';
  
    $(document).bind("pageinit", function () {
    //$(document).ready(function () {
        //alert(groupName);
        $.mobile.loadPage('#page-id');
        var modelChk = holeModelCheck();

        if (modelChk.length == 0) {

            saveHoleToLocal(96);

            writeHoleDataToScores(96);

        } else {

            drawList(96);

        }
    });

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


    function saveHoleToLocal(index) {

        var model = getHoleModel(index);
        model.GroupName = document.getElementById('GPName').innerHTML;
        model.GroupMembers = '<%=ViewData["JSONnames"] %>';  //$("#GPMembers").val();
        model.GroupSize = '<%=ViewData["GroupCount"] %>';
        model.HoleData = '<%=ViewData["JSONHoleData"] %>';
        model.YID = '<%=ViewData["YearID"] %>';
        model.CID = '<%=ViewData["CID"] %>';
        model.GID = '<%=ViewData["GID"] %>';
        model.NextHole = 1;
        model.HoleCount = '<%=ViewData["HoleCount"] %>';
        model.NextHoleID = '<%=ViewData["NextHoleID"] %>'; 
        model.IsDirty = true;
        localStorage.setItem(index,
                    JSON.stringify(model));
       // alert("'" + GroupMembers + "' saved locally.");
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
                    //alert(HoleData);
                }
       
         var scores = eval('(' + HoleData + ')');
          var users = eval('(' + GroupData + ')');
       
          //NewScoreFor: userid, score, HID, YID, GID
          $.each(scores, function (i, result) {            
              $.each(users, function (i, item) {
                  saveScoresToLocal("H_" + result.HoleID + "_" + item.UserID, result.HoleNum, result.HolePin, result.HoleLD, GroupSize);
              });
          });

        // drawList(96);
       
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
            if (compChk(result.HoleID) == true) {
                comptxt = "<span class=\"ui-li-count\">Completed</span>";
            } else {
                comptxt = "";
            }
            if (serverChk(result.HoleID) == true) {
                servertxt = "saved to server";
            } else {
                servertxt = "saved locally";
            }
            //alert(servertxt);
            if (result.HolePin != 0) {
                htmlList_item = htmlList_item + "<li data-theme=\"e\"><a href=\"#\">" + result.HoleNum + "</a>" + comptxt + "</li>";
            } else {
                htmlList_item = htmlList_item + "<li data-theme=\"b\"><a href=\"#\">" + result.HoleNum + "</a>" + comptxt + "</li>";
            }

            //htmlList_item = htmlList_item + "<li data-theme=\"e\"><a href=\"#\">" + result.HoleNum + "</a>" + comptxt + "</li>";
        });
       //alert(htmlList_item);
        $('#HoleList').html(htmlList_top + htmlList_item + "</ul>").trigger('create');
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


    function saveScoresToLocal(HID, HoleNum, HolePin, HoleLD, GroupSize) {

        var model = getScoreModel(HID);
        model.HoleNum = HoleNum;
        model.HolePin = HolePin;
        model.HoleLD = HoleLD;
        model.Score = "";
        model.IsSaved = false;
        model.HID = HID;
        model.GroupSize = GroupSize;
        localStorage.setItem(HID,
                    JSON.stringify(model));
        //alert("pin'" + HolePin + "' score saved locally.");
    }

    function getHoleModel(index) {
        var model = {
            GroupName: "",
            GroupMembers: "",
            HoleData: "",
            HoleCount: "",
            YID: "",
            HID: "",
            GID: "",
            NextHole: "",
            PrevHole: "",
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

    function getScoreModel(HID) {
        var model = {
            HolePin: "",
            HoleLD: "",
            HoleNum: "",
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

    function getCompModel(HID) {
        var model = {
            IsComplete: false,
            IsCompLocal: false,
            IsCompServer: false,
            Key: "",
            ID: ""
        };

        if (localStorage[HID] != null) {
            model = JSON.parse(localStorage[HID]);
        }
        model.Key = HID;
        return model;
    }


</script>

  <h4>Select hole for <%=ViewData["course"] %>,  <%=ViewData["Year"] %> </h4>
  <h5>Group Name: <div id="GPName"><%=ViewData["Group"] %></div>: <div id="GroupMembers">(<%=ViewData["names"] %>)</div><div><%=ViewData["JSONnames"] %></div> </h5>
  <div id="HoleList">list here</div>
  <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var comptxt = "";
        if (item.Scores.Count() == Convert.ToInt32(ViewData["GroupCount"]))
        {
            comptxt = "<span class=\"ui-li-count\">Completed</span>";
        }
      %>
      <% if (item.N_pin == 1)
         {%>
   <li data-theme="e"><%= Html.ActionLink(Convert.ToString(item.HoleNum) + " (Nearest the Pin)", "HoleCard", "Home", new { YID = ViewData["YearID"], course = ViewData["Course"], GID = ViewData["GID"], HoleID = item.HoleID, CID = ViewData["CID"] }, null)%>
<%=comptxt %></li> 
<% }
         else if (item.L_drive == 1)
         { %>
   <li data-theme="e"><%= Html.ActionLink(Convert.ToString(item.HoleNum) + " (Longest Drive)", "HoleCard", "Home", new { YID = ViewData["YearID"], course = ViewData["Course"], GID = ViewData["GID"], HoleID = item.HoleID, CID = ViewData["CID"] }, null)%>
<%=comptxt %></li> 
   <% }
         else
         { %>
<li data-theme="c"><%= Html.ActionLink(Convert.ToString(item.HoleNum), "HoleCard", "Home", new { YID = ViewData["YearID"], course = ViewData["Course"], GID = ViewData["GID"], HoleID = item.HoleID, CID = ViewData["CID"] }, null)%>
<%=comptxt %></li>  

       <%  }%>
 <% } %>
    </ul>
<ul>
<li><%= Html.ActionLink("Offline Test2", "LocalHoleCard", "Home") %></li>
</ul>    

</asp:Content>

