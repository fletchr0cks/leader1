<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Year>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Admin
</asp:Content>
 
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
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
<h4>Setup a Tournament </h4>
 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
	<li><%=Html.ActionLink("New Tournament", "AddTourn", "Home") %></li>
</ul>
<h4>Select an existing Tournament </h4>
 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var yr = item.Year1;
        var target = ViewData["YearTarget"];
      %>
      
   <li><%= Html.ActionLink(Convert.ToString(yr), Convert.ToString(target), "Home", new { YID = item.YID }, null)%></li>
   
 <% } %>
    </ul>
  
	
</asp:Content>