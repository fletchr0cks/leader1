<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Front
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<h1>St Jude Scorecards</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<script  type="text/javascript">
    saveHistoryModel("123", "Home");
</script>
<div>
 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
	<li><%=Html.ActionLink("Profiles", "Users", "Home") %></li>
    <li><%=Html.ActionLink("Groups", "Groups", "Home")%></li>
</ul>

 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
	<li><%=Html.ActionLink("Courses", "CourseUA", "Home") %></li>
</ul>

 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
	<li><%=Html.ActionLink("Tournaments", "Years", "Home", new { target = "CourseGroups" }, null)%></li>
	<li><%=Html.ActionLink("Enter Scores", "Years", "Home", new { target = "CourseHoles" }, null) %></li>
	<li><%=Html.ActionLink("View Scores", "Years", "Home", new { target = "CourseHolesView" }, null)%></li>
	<li><%=Html.ActionLink("Results Feed", "Events", "Home") %></li>
</ul>
 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
    <li><%=Html.ActionLink("Weather", "Weather", "Home") %></li>
</ul>
</div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
<div data-role="footer" style="overflow:hidden;">
<div data-theme="a" id="eventsfeed"></div>
<div data-role="navbar">
<ul><li><a href="#">Home</a></li> <li><a onclick="refresh_feed()" href="#">Refresh Events Feed</a></li> <li><a href="#">Check Connection</a></li></ul>
</div></div>
</asp:Content>
