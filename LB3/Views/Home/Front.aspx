<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Front
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<h1>St Jude Scorecards</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
	<li><%=Html.ActionLink("Profiles", "Users", "Home") %></li>
	<li><%=Html.ActionLink("Courses and Groups", "Years", "Home", new { target = "CourseGroups" }, null)%></li>
	<li><%=Html.ActionLink("Enter Scores", "Years", "Home", new { target = "CourseHoles" }, null) %></li>
	<li><%=Html.ActionLink("View Scores", "Years", "Home", new { target = "CourseHolesView" }, null)%></li>
	<li><%=Html.ActionLink("Results Feed", "Events", "Home") %></li>
    <li><%=Html.ActionLink("Weather", "Weather", "Home") %></li>
</ul>
<% try
   { %>
<h4 data-inset="true">Previous Selection</h4>
<ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
<li><a id="linkd" href="#"><div id="linktxt"><%= Request.Cookies["last"].Value%></div></a></li>
</ul>
<% }
   catch
   { %>

<% } %>
</asp:Content>
