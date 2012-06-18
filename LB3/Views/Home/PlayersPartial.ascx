<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<LB3.Models.UserGroup>>" %>

<% foreach (var player in Model)
    {%>
	<p><div id="user"><%=player.User.Name %></div>Remove</p>
	<% } %>