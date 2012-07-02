<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.Course>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CourseDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "Groups", "Home", new { CID = ViewData["CID"], YID = ViewData["YID"], Course = ViewData["Course"], target = "ViewHole" }, null)%>
<h1>View Scores</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<h4>
    <%=ViewData["Course"] %>, <%=ViewData["Year"] %>, <%=ViewData["Group"] %>
</h4>
    
<select name="select-choice-<%=ViewData["CID"] %>_<%=ViewData["YID"] %>" data-theme="c" id="select-choice-<%=ViewData["CID"] %>_<%=ViewData["YID"] %>" data-native-menu="false" onchange="getScores(this.value,<%=ViewData["HID"] %>,<%=ViewData["GID"] %>)" >
   <% = ViewData["dd_vals"]%>
</select>

<div id="scores_<%=ViewData["GID"] %>">
</div>
</asp:Content>
