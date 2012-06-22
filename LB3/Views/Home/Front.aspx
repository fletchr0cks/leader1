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
	<li><%=Html.ActionLink("Edit Scorecards", "Years", "Home", new { target = "CourseHoles" }, null) %></li>
	<li><%=Html.ActionLink("View Scorecards", "Years", "Home", new { target = "CourseHolesView" }, null)%></li>
	<li><%=Html.ActionLink("Results Feed", "Events", "Home") %></li>
</ul>
</asp:Content>
