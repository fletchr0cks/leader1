<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="LB3.Models" %>

<div class="ui-grid-e">
 <div class="ui-block-a">
  <p>Hole</p>
 </div>
 <div class="ui-block-b">
  <p>Par</p>
 </div>
 <div class="ui-block-c">
  <p>SI</p>
 </div>
 <div class="ui-block-d">
  <p>Pin</p>
 </div>
 <div class="ui-block-e">
  <p>Drive</p>
 </div>
  <div class="ui-block-f">
  <p></p>
 </div>
 
<% foreach (Hole h in (IEnumerable)ViewData.Model)  
   {
%><!-- second row -->
<div id="holeRow_<%=h.HoleID %>">
 <div class="ui-block-a">
  <p><%=h.HoleNum %></p>
 </div>
 <div class="ui-block-b">
  <p><%=h.Par %></p>
 </div>
 <div class="ui-block-c">
  <p><%=h.SI %></p>
 </div>
 <div class="ui-block-d">
 <% if (h.N_pin == 1)
    { %>
  <p>Yes</p>
  <% }
    else
    { %>
   <p>No</p>
  <% } %>
 </div>
 	<div class="ui-block-e">
  <% if (h.L_drive == 1)
    { %>
  <p>Yes</p>
  <% }
    else
    { %>
   <p>No</p>
  <% } %>
 </div>
	<div class="ui-block-f">
  <p><div onclick="deleteHole(<%=h.HoleID%>)">Delete</div></p>
 </div>
 </div>
<%} %>
</div>
 <div id="newHole_<%=ViewData["CourseID"] %>">
<div onclick="addHole(<%=ViewData["YID"] %>,<%=ViewData["CourseID"] %>)">add hole</div>
</div>
