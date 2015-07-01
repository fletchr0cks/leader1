<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<LB3.Models.Event>>" %>



 <% foreach (var item in Model)
    {
%>
  <p><%=item.Comment%></p>

<% } %>