<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LB3.Models.Hole>" %>
<form name="frm">
<div class="ui-grid-e">
 <div class="ui-block-a"><p>
 <input type="text" type="number" value="<%=ViewData["NextNum"]%>" name="name" id="hole_<%=ViewData["CID"] %>" data-mini="true" style="width:20px"/>
 </p></div>
 <div class="ui-block-b"><p>
 <input type="text" type="number" name="name" id="par_<%=ViewData["CID"] %>" data-mini="true" style="width:20px"/>
 </p></div>
 <div class="ui-block-c"><p>
   <input type="text" type="number" name="name" id="SI_<%=ViewData["CID"] %>" data-mini="true" style="width:20px"/>
 </p></div>
 <div class="ui-block-d">
<p><input type="checkbox" name="pin_<%=ViewData["CID"] %>" id="pin_<%=ViewData["CID"] %>" class="custom" data-role="none"/></p>
</div>
  <div class="ui-block-e">
<p><input type="checkbox" name="drive_<%=ViewData["CID"] %>" id="drive_<%=ViewData["CID"] %>" class="custom" data-role="none"/></p>
 </div>
<div class="ui-block-f" data-theme="e"><p>
 <a href="#" onclick="saveHole(<%=ViewData["CID"] %>,<%=ViewData["YID"] %>)" data-role="button" data-icon="check" data-iconpos="notext"></a>
 </p>
 </div>
 </div>
  </form>