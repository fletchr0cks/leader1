<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.Course>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CourseDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "CourseGroups", "Home", new { YID = ViewData["YID"]}, null)%>
<h1>Holes and Groups</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<h4>
    <%=ViewData["Course"] %>, <%=ViewData["Year"] %>
</h4>
    

<div id="holelist_<%=ViewData["CourseID"] %>">
<% Html.RenderPartial("HolePartial", ViewData["Holes"] as IEnumerable<LB3.Models.Hole>); %>
</div>


<div id="grouplist_<%=ViewData["CourseID"] %>">
<% Html.RenderPartial("GroupPartial", ViewData["Groups"] as IEnumerable<LB3.Models.Group>); %>
</div>
</asp:Content>
