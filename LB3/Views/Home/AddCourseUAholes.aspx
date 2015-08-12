<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddCourseUA
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "AddCourseUA", "Home")%>
<h1>Add hole information</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<h4>
Add holes for <%= ViewData["CourseName"]  %>
</h4>
<div id="holelist_<%=ViewData["CUAID"] %>">
<% Html.RenderPartial("HoleUAPartial", ViewData["UAHoles"] as IEnumerable<LB3.Models.HoleUA>); %>
</div>

</asp:Content>
