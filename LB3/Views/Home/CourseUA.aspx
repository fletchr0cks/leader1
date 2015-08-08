<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.CourseUA>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CourseUA
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<h1>Find a Course</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <h2>CourseUA</h2>
<ul data-role="listview" data-filter="true" data-filter-placeholder="Search courses ..." data-inset="true">
<% foreach (var item in Model) { %>
<li><%= Html.ActionLink(item.CourseName, "ViewCourseUA", "Home", new { CUAID = item.ID }, null)%></li>
<% } %>
</ul>

 <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
	<li><%=Html.ActionLink("Add a New Course", "AddCourseUA", "Home") %></li>
</ul>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>

