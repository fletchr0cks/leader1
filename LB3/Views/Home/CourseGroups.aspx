<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Course>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Course
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
 <%= Html.ActionLink("Back", "Years", "Home", new { target = "CourseGroups" }, null)%>
    
    <h1>Courses and Groups</h1>
</asp:Content>

 
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
  <h4>Select Course for <%=ViewData["Year"] %></h4>
  <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var CID = item.CID;
      %>
      
   <li><%= Html.ActionLink(item.CourseName, "CourseDetails", "Home", new { CID = item.CID, YID = ViewData["YearID"], course = item.CourseName}, null)%></li>
   
 <% } %>
    </ul>
    
      

</asp:Content>

