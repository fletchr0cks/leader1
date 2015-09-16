<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div>Tournament Creator:</div>
Passcode:
<input type="text" name="name" id="passcode" data-mini="true" style="width:150px; display:inline" />
<input type="hidden" id="YID" value="<%= ViewData["YID"] %>" />
<input type="hidden" id="CID" value="<%= ViewData["CID"] %>" />
<a href="#" onclick="saveCode()" data-role="button" data-icon="check">Start</a>
