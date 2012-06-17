<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LB3.Models.Hole>" %>
<form name="frm">
<div class="ui-grid-e">
 <div class="ui-block-a">
 <input type="text" value="<%=ViewData["NextNum"]%>" name="name" id="hole_<%=ViewData["CID"] %>" data-mini="true" style="width:20px"/>
 </div>
 <div class="ui-block-b">
 <input type="text" name="name" id="par_<%=ViewData["CID"] %>" data-mini="true" style="width:20px"/>
 </div>
 <div class="ui-block-c">
   <input type="text" name="name" id="SI_<%=ViewData["CID"] %>" data-mini="true" style="width:20px"/>
 </div>
 <div class="ui-block-d">
<input type="checkbox" name="pin_<%=ViewData["CID"] %>" id="pin_<%=ViewData["CID"] %>" class="custom" /> </div>
  <div class="ui-block-e">
<input type="checkbox" name="drive_<%=ViewData["CID"] %>" id="drive_<%=ViewData["CID"] %>" class="custom" />
 </div>
<div class="ui-block-f">
 <div style="display:inline" onclick="saveHole(<%=ViewData["CID"] %>,<%=ViewData["YID"] %>)">Save</div>
 </div>
 </div>
 
 <div id="newHole_<%=ViewData["CourseID"] %>">
<div onclick="addHole(<%=ViewData["YID"] %>,<%=ViewData["CourseID"] %>)">add hole</div>
</div>
 </form>