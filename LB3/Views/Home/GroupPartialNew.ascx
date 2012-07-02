<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LB3.Models.Group>" %>

<div class="ui-grid-c">
 <div class="ui-block-a">
 <input type="text" name="name" value="Group " id="groupname" data-mini="true" style="width:80px" />
 </div>
 <div class="ui-block-b">
 </div>
 <div class="ui-block-c">
 </div>
 <div class="ui-block-d">
 
 <a href="#" onclick="saveGroup(<%=ViewData["CID"] %>,<%=ViewData["YID"] %>)" data-role="button" data-icon="check" data-iconpos="notext"></a>
 </div>
 </div>