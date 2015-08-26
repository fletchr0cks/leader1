<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.HoleUA>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	UACourseDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "CourseUA", "Home")%>
<h1>Course Details</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<h4>
    <%=ViewData["Course"] %>
</h4>
    
<div data-role="collapsible" <% =ViewData["coll"] %> data-theme="c" data-inset="true" data-content-theme="a">    
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
    <a href="#" onclick="deleteHole(<%=h.HoleID%>)" data-role="button" data-icon="delete" data-iconpos="notext"></a>
 </div>
 </div>
<%} %>
</div>

</asp:Content>
