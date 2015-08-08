<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddCourseUA
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "CourseUA", "Home")%>
<h1>Add a new Course</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<textbox name="coursename" id="courseID"></textarea>
<button class="ui-btn ui-btn-inline" onClick="AddCourseUA()">Add New Course</button>
     
</asp:Content>
