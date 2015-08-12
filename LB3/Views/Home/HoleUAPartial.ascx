<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="LB3.Models" %>
<div data-role="collapsible" <% =ViewData["coll"] %> data-theme="c" data-inset="true" data-content-theme="a">    
<h3>Holes</h3>
<div class="ui-grid-c">
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
  <p></p>
 </div>
 
<% foreach (HoleUA h in (IEnumerable)ViewData.Model)  
   {
%><!-- second row -->
<div id="holeRow_<%=h.ID %>">
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
    <a href="#" onclick="deleteHoleUA(<%=h.ID%>)" data-role="button" data-icon="delete" data-iconpos="notext"></a>
 </div>
 </div>
<%} %>
</div>
 <div id="newHoleUA_<%=ViewData["CUAID"] %>">
<a href="#" onclick="addHoleUA(<%=ViewData["CUAID"] %>)" data-role="button" data-icon="plus" data-iconpos="right">Add Hole</a>
</div>
</div> 