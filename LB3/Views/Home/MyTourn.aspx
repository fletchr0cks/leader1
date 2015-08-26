<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Year>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	MyTourn
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Home", "Index", "Home")%>
<h1>My Tournaments</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
    <% foreach (var item in Model) {
           var linkname = item.Name;
            %>

    <li><%=Html.ActionLink(linkname, "CourseDetails", "Home", new { YID = item.YID, CID = item.Courses.First().CID, course = item.Courses.First().CourseName  }, null)%></li>
        
    <% } %>
    </ul>
   
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>
