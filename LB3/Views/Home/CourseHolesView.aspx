<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Course>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Course
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
 <%= Html.ActionLink("Back", "Years", "Home", new { target = "CourseHolesView" }, null)%>
   <h1>View Scores</h1>
    
</asp:Content>

 
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
  <h4>Select Course for <%=ViewData["Year"] %></h4> 
   <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var CID = item.CID;
      %>
      
   <li><%= Html.ActionLink(item.CourseName, "Groups", "Home", new { YID = ViewData["YearID"], course = item.CourseName, CID = item.CID, target = "ViewHole"}, null)%></li>
   
 <% } %>
    </ul>
 
    
</asp:Content>

