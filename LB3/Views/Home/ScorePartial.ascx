<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="LB3.Models" %>

<div class="ui-grid-d">
 <div class="ui-block-a">
  <p><strong>Hole</strong></p>
 </div>
 <div class="ui-block-b">
  <p><strong>Score</strong></p>
 </div>
 <div class="ui-block-c">
  <p><strong>Points</strong></p>
 </div>
 <div class="ui-block-d">
  <p><strong>Pin</strong></p>
 </div>
 <div class="ui-block-e">
  <p><strong>Drive</strong></p>
 </div>
  
<% foreach (Score s in (IEnumerable)ViewData.Model)  
   {
%><!-- second row -->

 <div class="ui-block-a">
  <p><%=s.Hole.HoleNum %></p>
 </div>
 <div class="ui-block-b">
  <p><%=s.Score1 %></p>
 </div>
 <div class="ui-block-c">
  <p></p>
 </div>
 <div class="ui-block-d">
 <% if (s.PinUserID != null)
    { %>
  <p>Yes</p>
  <% }
    else
    { %>
   <p>No</p>
  <% } %>
 </div>
 	<div class="ui-block-e">
  <% if (s.DriveUserID != null)
    { %>
  <p>Yes</p>
  <% }
    else
    { %>
   <p>No</p>
  <% } %>
 </div>

<%} %>
</div>
