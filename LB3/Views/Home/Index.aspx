<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Year>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Admin
</asp:Content>
 
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
<script  type="text/javascript">
    $(document).bind("pageinit", function () {
        //$(document).ready(function () {
        //alert(groupName);
        $.mobile.loadPage('#page-id');
        var CID = getCID();
        var YID = getYID();

        getLocalTourn(CID, YID);


    });


    function getHoleModel(index) {
        var model = {
            GroupName: "",
            GroupMembers: "",
            HoleData: "",
            ScoreData: "",
            HoleCount: "",
            YID: "",
            HID: "",
            GID: "",
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

</script>

<%= Html.ActionLink("Back", "Index", "Home", null)%>

 <% if (Convert.ToString(ViewData["YearTarget"]) == "CourseGroups") { %>
 <h1>Courses and Groups</h1>
  <% }
    else if (Convert.ToString(ViewData["YearTarget"]) == "CourseHoles")
    { %>
<h1>Enter Scores</h1>
 <% }
    else
    { %>
<h1>View Scores</h1>
 <%   } %>

</asp:Content>
 
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="ui-grid-a">
 <div class="ui-block-a"><p>
 Passcode:
<input type="text" name="name" id="passcode" data-mini="true" style="width:150px; display:inline" /></p>
<p>Owner Name:
<input type="text" name="name" id="ownername" data-mini="true" style="width:150px; display:inline" /></p>
</div>

 <div class="ui-block-b">
 <a href="#" onclick="checkCode()" data-role="button" data-icon="check">Check Code</a>
 </div>
 </div>
  <% if (Convert.ToString(ViewData["YearTarget"]) != "player")
     { %>
 
<h4>Select a Tournament</h4>
 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var yr = item.Name;
        var target = ViewData["YearTarget"];
      %>
      
   <li><%= Html.ActionLink(Convert.ToString(yr), "CourseGroups", "Home", new { YID = item.YID }, null)%></li>
   
 <% } %>
    </ul>
 
	<% } %>
<div id="results"></div>
</asp:Content>