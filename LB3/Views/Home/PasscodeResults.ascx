<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<LB3.Models.Year>>" %>

<% if (Model.Count() != 0) { %>
<ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b" data-count-theme="b">
 <% foreach (var item in Model)
    {
%>

<li><%= Html.ActionLink(item.Name, "Groups", "Home", new { YID = item.YID, course = ViewData["CourseName"], CID = item.Courses.First().CID, target = "Hole"}, null)%></li>
 
 <% } %>
</ul>
<% } else { %>
       
  <p>No records found for Tournament owner</p>

<%  } %>
