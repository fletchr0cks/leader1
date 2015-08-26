<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<LB3.Models.Year>>" %>

<% if (Model.Count() != 0) { %>
 <% foreach (var item in Model)
    {
%>
  <p><%=item.Name%></p>
 
 <% } %>

<% } else { %>
       
  <p>No records found for Tournament owner</p>

<%  } %>