<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Course>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Course
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
 <%= Html.ActionLink("Back", "Years", "Home", new { target = "CourseGroups" }, null)%>  
    <h1>Courses and Groups</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<script  type="text/javascript">

    $(document).bind("pageinit", function () {
        //$(document).ready(function () {
        //alert(groupName);
        $.mobile.loadPage('#page-id');
        saveHoleToLocal("96");
    });


    function saveHoleToLocal(index) {
        var model = getHoleModel(index);
        model.YID = '<%=ViewData["YearID"] %>';
       
        localStorage.setItem(index,
                    JSON.stringify(model));
    }


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



</script>

  <h4>Select Course for <%=ViewData["Year"] %></h4>
  <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var CID = item.CID;
      %>
      
   <li><%= Html.ActionLink(item.CourseName, "CourseDetails", "Home", new { CID = item.CID, YID = ViewData["YearID"], course = item.CourseName}, null)%></li>
   
 <% } %>
    </ul>
    
      

</asp:Content>

