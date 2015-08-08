<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LB3.Models.HoleUA>" %>
<div>edit</div>
<form name="frm">
<div class="ui-grid-c">
 <div class="ui-block-a"><p>
 <input type="number" value="<%=ViewData["NextNum"]%>" name="name" id="hole_<%=ViewData["CUAID"] %>" data-mini="true" style="width:40px"/>
 </p></div>
 <div class="ui-block-b"><p>
 <input type="number" name="par" id="par_<%=ViewData["CUAID"] %>" data-mini="true" style="width:40px"/>
 </p></div>
 <div class="ui-block-c"><p>
   <input type="number" name="si" id="SI_<%=ViewData["CUAID"] %>" data-mini="true" style="width:40px"/>
 </p></div>
<div class="ui-block-d" data-theme="e"><p>
 <a href="#" onclick="saveUAHole(<%=ViewData["CUAID"] %>)" data-role="button" data-icon="check" data-iconpos="notext"></a>
 </p>
 </div>
 </div>
  </form>