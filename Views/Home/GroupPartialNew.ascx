<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LB3.Models.Group>" %>

<div class="ui-grid-c">
 <div class="ui-block-a">
 <input type="text" name="name" id="groupname" data-mini="true" style="width:80px" />
 </div>
 <div class="ui-block-b">
 </div>
 <div class="ui-block-c">
  
 </div>
 <div class="ui-block-d">
  
 </div>

 <div style="display:inline" onclick="saveGroup(<%=ViewData["CID"] %>,<%=ViewData["YID"] %>)">Save</div>
 
 </div>
 
 