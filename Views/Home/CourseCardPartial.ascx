<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="LB3.Models" %>



<table>
<tr>
<td>Hole</td>
<td>Par</td>
<% foreach (UserGroup u in (IEnumerable)ViewData.Model)  
   {%>
<td><%=u.User.Name %></td>

<%} %>
</tr>

<% var holect = 1;
   
   while (holect < 10)
   {

       %>
 <tr>    
<td><%=holect %></td>
<% var pardone = 0;

   foreach (UserGroup u in (IEnumerable)ViewData.Model)
   {
              
           %>
   <% foreach (var item in u.GetHolesForCourse(Convert.ToInt32(u.Group.CourseID), 4, holect))
      {

          if (pardone == 0)
          {
          %>
<td><%=item.Par%></td>  
<%
              
    pardone = 1;
          } %> 
 <% if ((u.checkScore(item.HoleID, item.YearID, u.UserID) == -1))
    {  %>

<td>not yet</td>
 <%
   
    }
    else if ((u.checkScore(item.HoleID, item.YearID, u.UserID) == 0))
    {  %>
    

 <td><div id="user_<%=u.UserID %>"><input type="text" name="name" id="hole_<%=u.UserID %>" data-mini="true" style="width:10px"/></div>hole_<%=u.UserID %></td>
<% }
    else
    { %>
<td><%=(u.checkScore(item.HoleID, item.YearID, u.UserID))%> done</td>


<% }
   
        %>
<% }

   }%>
</tr>

  <%
       holect = holect + 1;
       //scct = scct + 1;
   }
        %>

</table>
