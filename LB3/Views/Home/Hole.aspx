<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Hole>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Holes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back to Groups", "CourseHoles", "Home", new { YID = ViewData["YearID"], GID = ViewData["GID"], course = ViewData["course"], CID = ViewData["CID"], target= "Hole" }, null)%>

    <h1>Edit Scorecard</h1>
    
</asp:Content>

 
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
  <h4>Select hole for <%=ViewData["course"] %>,  <%=ViewData["Year"] %></h4>
  <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
 <% foreach (var item in Model)
    {
        var comptxt = "";
        if (item.Scores.Count() == 4)
        {
            comptxt = "<span class=\"ui-li-count\">Completed</span>";
        }
      %>
      <% if (item.N_pin == 1)
         {%>
   <li data-theme="e"><%= Html.ActionLink(Convert.ToString(item.HoleNum) + " (Nearest the Pin)", "HoleCard", "Home", new { YID = ViewData["YearID"], course = ViewData["Course"], GID = ViewData["GID"], HoleID = item.HoleID, CID = ViewData["CID"] }, null)%>
<%=comptxt %></li> 
<% }
         else if (item.L_drive == 1)
         { %>
   <li data-theme="e"><%= Html.ActionLink(Convert.ToString(item.HoleNum) + " (Longest Drive)", "HoleCard", "Home", new { YID = ViewData["YearID"], course = ViewData["Course"], GID = ViewData["GID"], HoleID = item.HoleID, CID = ViewData["CID"] }, null)%>
<%=comptxt %></li> 
   <% }
         else
         { %>
<li data-theme="c"><%= Html.ActionLink(Convert.ToString(item.HoleNum), "HoleCard", "Home", new { YID = ViewData["YearID"], course = ViewData["Course"], GID = ViewData["GID"], HoleID = item.HoleID, CID = ViewData["CID"] }, null)%>
<%=comptxt %></li>  

       <%  }%>
 <% } %>
    </ul>
    

</asp:Content>

