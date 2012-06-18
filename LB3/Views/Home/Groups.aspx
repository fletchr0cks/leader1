<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Group>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Groups
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back to Courses", "CourseHoles", "Home", new { YID = ViewData["YID"] }, null)%>
 <% if (Convert.ToString(ViewData["GroupTarget"]) == "ViewHole") { %>
 <h1>View Scorecards</h1>
  <% }
    else if (Convert.ToString(ViewData["YearTarget"]) == "Hole")
    { %>
<h1>Edit Scorecards</h1>
 <% }
    else
    { %>
<h1>Groups</h1>
 <%   } %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <h4>Select a Group for year. course</h4>
   <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var yr = item.GroupName;
        var target = ViewData["GroupTarget"];
      %>
      
   <li><%= Html.ActionLink(Convert.ToString(yr), Convert.ToString(target), "Home", new { YID = ViewData["YID"], GID = item.GID, course = ViewData["course"], CID = ViewData["CID"] }, null)%></li>
   
 <% } %>
    </ul>
  

</asp:Content>


