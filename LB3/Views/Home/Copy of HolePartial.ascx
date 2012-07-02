<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="LB3.Models" %>
<div data-role="collapsible" <% =ViewData["coll"] %> data-theme="b" data-inset="true" data-content-theme="d">    
<h3>Holes</h3>
<div class="ui-grid-e">
 <div class="ui-block-a">
  <p><strong>Hole</strong></p>
 </div>
 <div class="ui-block-b">
  <p><strong>Par</strong></p>
 </div>
 <div class="ui-block-c">
  <p><strong>SI</strong></p>
 </div>
 <div class="ui-block-d">
  <p><strong>Pin</strong></p>
 </div>
 <div class="ui-block-e">
  <p><strong>Drive</strong></p>
 </div>
  <div class="ui-block-f">
  <p></p>
 </div>
 
<% foreach (Score s in (IEnumerable)ViewData.Model)  
   {
%><!-- second row -->
<div id="holeRow_<%=s.ScID %>">
 <div class="ui-block-a">
  <p><%=s.Hole.HoleNum %></p>
 </div>
 <div class="ui-block-b">
  <p><%=s.Score1 %></p>
 </div>
 <div class="ui-block-c">
  <p>7</p>
 </div>
 <div class="ui-block-d">
 <% if (s.PinUserID == 2)
    { %>
  <p>Yes</p>
  <% }
    else
    { %>
   <p>No</p>
  <% } %>
 </div>
 	<div class="ui-block-e">
  <% if (s.DriveUserID == 1)
    { %>
  <p>Yes</p>
  <% }
    else
    { %>
   <p>No</p>
  <% } %>
 </div>
	<div class="ui-block-f">
 </div>
 </div>
<%} %>
</div>

</div> 