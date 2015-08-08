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
  <p><strong>Par</strong></p>
 </div>
  
<% foreach (Score s in (IEnumerable)ViewData.Model)  
   {
%><!-- second row -->

 <div class="ui-block-a">
  <p><%=s.TotalScore %></p>
 </div>
 <div class="ui-block-b">
  <p><%=s.Score1 %></p>
 </div>
 <div class="ui-block-c">
  <p></p>
 </div>
 
<%} %>
</div>
