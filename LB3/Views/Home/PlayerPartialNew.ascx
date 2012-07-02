<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LB3.Models.User>" %>

 <select data-mini="true" name="select-choice-0" id="select-choice-0" data-native-menu="false" onchange="savePlayer(this.value,<%=ViewData["GID"] %>)" >
   <% = ViewData["dd_vals"]%>
</select>
