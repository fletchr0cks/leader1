<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<LB3.Models.Group>>" %>

<div data-role="collapsible" data-theme="c" data-content-theme="a" data-collapsed="false">
<h3>Groups</h3>    
 <% foreach (var item in Model)
    {
        var yr = item.Year;
        
      %>
      
<div data-role="collapsible" data-theme="b" data-content-theme="d" data-mini="true">
	<h3><%=item.GroupName %></h3>
    <div class="ui-grid-a">

    <div class="ui-block-a">
	<div id="playerList_<%=(item.GID)%>">
	<div class="ui-grid-a">

	<% foreach (var player in item.UserGroups)
    {
    
    %>
 <div class="ui-block-a">
<div id="user_<%=(player.User.UserID)%>"><p><%=player.User.Name %></p></div>
 </div>	
 <div class="ui-block-b" style="cursor:pointer">
<a href="#" onclick="removePlayer(<%=player.User.UserID %>,<%=item.GID %> )" data-role="button" data-icon="delete" data-iconpos="notext"></a>
 </div>
 
	<% } %>
	</div>
	
	<div class="ui-grid-a">
	<div class="ui-block-a" id="newPlayer_<%=(item.GID)%>">
 <select data-mini="true" name="select-choice-<%=(item.GID)%>" id="select-choice-<%=(item.GID)%>" data-native-menu="false" onchange="savePlayer(this.value,<%=(item.GID)%>)" >
   <% =ViewData["dd_vals"]%>
</select>
    </div>
    
    </div>
	
	</div>
 </div>
 	<div class="ui-block-b">
    <a href="#" onclick="deleteGroup()" data-mini="true" data-role="button" data-icon="delete" data-iconpos="right">Delete Group</a>
    </div>



	</div>   
</div>
 <% } %>


 <div id="newGroup">
 <a href="#" onclick="addGroup(<%=ViewData["YID"] %>,<%=ViewData["CourseID"] %>)" data-role="button" data-mini="true" data-icon="plus" data-iconpos="right">Add Group</a>
</div>