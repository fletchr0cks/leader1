<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<LB3.Models.Group>>" %>

<div data-role="collapsible" data-theme="c" data-content-theme="d">
<h3>Groups</h3>    
 <% foreach (var item in Model)
    {
        var yr = item.Year;
        
      %>
      
<div data-role="collapsible" data-theme="c" data-content-theme="d" data-mini="true">
	<h3><%=item.GroupName %></h3>
	
	
	<div id="playerList_<%=(item.GID)%>">
	<div class="ui-grid-a">

	<% foreach (var player in item.UserGroups)
    {
    
    %>
 <div class="ui-block-a">
<div id="user_<%=(player.User.UserID)%>"><%=player.User.Name %></div></td>
 </div>	
 <div class="ui-block-b" style="cursor:pointer">
 Remove
 </div>
 
	<% } %>
	</div>
	</div>
	<div class="ui-grid-a">
	
	<div class="ui-block-a" id="newPlayer_<%=(item.GID)%>"></div>
	<div class="ui-block-b" onclick="addPlayer(<%=item.GID %>)">add player</div>
	</div>
	</div>   
 <% } %>
 <div id="newGroup"></div>
<div onclick="addGroup(<%=ViewData["YID"] %>,<%=ViewData["CourseID"] %>)">add group</div>

</div>
