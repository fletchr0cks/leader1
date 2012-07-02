<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<LB3.Models.UserGroup>>" %>
<div class="ui-grid-a">
<% foreach (var player in Model)
    {%>
	<div class="ui-block-a">
<div id="user_<%=(player.User.UserID)%>"><p><%=player.User.Name %></p></div>
 </div>	
 <div class="ui-block-b" style="cursor:pointer">
<a href="#" onclick="removePlayer(<%=player.User.UserID %>,<%=ViewData["GID"] %> )" data-role="button" data-icon="delete" data-iconpos="notext"></a>
 </div>
 
	<% } %>

	
	<div class="ui-block-a" id="newPlayer_<%=ViewData["GID"] %>">
   <select data-mini="true" name="select-choice-<%=ViewData["GID"]%>" id="select-choice-<%=ViewData["GID"]%>" data-native-menu="false" onchange="savePlayer(this.value,<%=ViewData["GID"] %>)" >
   <% =ViewData["dd_vals"]%>
</select>
		</div>
	</div>
