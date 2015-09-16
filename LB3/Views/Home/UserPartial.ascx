<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<LB3.Models.User>>" %>
<table>
<tr>
<td>Name</td>
<td>Handicap</td>
</tr>
</table>
	 <% foreach (var item in Model)
     {
    %>

<div id="user_<%=item.UserID %>">
<div class="ui-bar ui-bar-a" style="height:50px;">
<table>
<tr><td><%=item.Name %> <%=item.Lastname %>
<div class="score_txt_o"><%=item.Nickname%></div></td>
 <td><div class="score_txt_g"><%=item.Handicap%></div></td>
<td><a href="#" onclick="EditUser(<%=item.UserID %>)" data-role="button" data-icon="edit" data-iconpos="notext"></a></td>
 <td><div style="display:block"> <a href="#" onclick="DeleteUser(<%=item.UserID %>)" data-role="button" data-icon="delete" data-iconpos="notext"></a></td>
</tr>
</table>
 </div>
 </div>
 


  <%} %>
 
 <div id="newUser">
 Name: <input id="newUser" />
 <p>new partial goes here on submit</p>
 <a href="#" onclick="addUser(<%=ViewData["YID"] %>,<%=ViewData["CourseID"] %>)" data-role="button" data-mini="true" data-icon="plus" data-iconpos="right">Add Player</a>
</div>