<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.UserGroup>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CourseCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">

    Scorecard for <%=ViewData["Course"] %>, <%=ViewData["Year"] %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    

<div id="holecardlist">
<% Html.RenderPartial("CourseCardPartial", ViewData["Card"] as IEnumerable<LB3.Models.UserGroup>); %>
</div>

</asp:Content>
