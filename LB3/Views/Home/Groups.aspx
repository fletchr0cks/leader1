<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Group>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Groups
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
 <% if (Convert.ToString(ViewData["GroupTarget"]) == "ViewHole") { %>
 <%= Html.ActionLink("Back", "CourseHolesView", "Home", new { YID = ViewData["YID"] }, null)%>
 <h1>View Scores</h1>
  <% }
    else if (Convert.ToString(ViewData["GroupTarget"]) == "Hole")
    { %>
<%= Html.ActionLink("Back", "CourseHoles", "Home", new { YID = ViewData["YID"] }, null)%>
<h1>Enter Scores</h1>
 <% }
    else
    { %>
<%= Html.ActionLink("Back", "CourseDetails", "Home", new { YID = ViewData["YID"] }, null)%>
<h1>Groups</h1>
 <%   } %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <h4>Select a Group for <%= ViewData["year"] %>, <%= ViewData["course"] %></h4>

 <% if (Convert.ToString(ViewData["GroupTarget"]) == "ViewHole")
    { %>
 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var yr = item.GroupName;
        var target = ViewData["GroupTarget"];
        var names = "<span class=\"ui-li-count\">" + item.GetNamesForGroup(item.GID) + "</span>";
      %>
      
   <li><%= Html.ActionLink(Convert.ToString(yr), "ScoreDetails", "Home", new { CID = item.CourseID, GID = item.GID, course = ViewData["course"], YID = ViewData["YID"] }, null)%>
  <%= names %>
   </li>
   
 <% } %>
    </ul>
 <%}
    else
    { %>


   <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var yr = item.GroupName;
        var target = ViewData["GroupTarget"];
        var names = "<span class=\"ui-li-count\">" + item.GetNamesForGroup(item.GID) + "</span>";
      %>
      
   <li><%= Html.ActionLink(Convert.ToString(yr), Convert.ToString(target), "Home", new { YID = ViewData["YID"], GID = item.GID, course = ViewData["course"], CID = ViewData["CID"] }, null)%>
     <%= names %>
   </li>
 <% } %>
    </ul>
  <%} %>

</asp:Content>


