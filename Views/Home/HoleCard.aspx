<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.UserGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	HoleCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
 <%= Html.ActionLink("Hole List", "Hole", "Home", new { YID = ViewData["YearID"], course = ViewData["course"], CID = ViewData["CID"], GID = ViewData["GID"] }, null)%>
 <h1><%=ViewData["course"] %>, hole <%=ViewData["HoleNum"] %></h1>
 <% if (ViewData["NextHoleID"] == null)
    {
    }
    else
    { %>    
<%= Html.ActionLink("Next Hole (" + ViewData["NextHole"] + ")", "HoleCard", "Home", new { YID = ViewData["YID"], course = ViewData["course"], GID = ViewData["GID"], HoleID = ViewData["NextHoleID"], CID = ViewData["CID"] }, null)%>
<% } %>
   
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
   

    <table>
       <tr>
       <td>
       </td>
       <td></td></tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            
            <td>
                <h3><%= Html.Encode(item.User.Nickname) %></h3>
            </td>
            <td></td><td></td>
        </tr>
        <tr><td>
     
        <fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">

    	<% if (item.checkScore(Convert.ToInt32(ViewData["HID"]), Convert.ToInt32(ViewData["YID"]), item.UserID) == 3)
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,3,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-1" value="3" checked="checked"/>
    	<label for="radio-mini-1">3</label>
    	
    	<% }
   else
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,3,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-1" value="3" />
    	<label for="radio-mini-1">3</label>
    	
    	<% } %>
  
  <% if (item.checkScore(Convert.ToInt32(ViewData["HID"]), Convert.ToInt32(ViewData["YID"]), item.UserID) == 4)
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,4,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-2" value="4" checked="checked"/>
    	<label for="radio-mini-2">4</label>
    	
    	<% }
   else
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,4,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-2" value="4" />
    	<label for="radio-mini-2">4</label>
    	
    	<% } %>  	
    	 <% if (item.checkScore(Convert.ToInt32(ViewData["HID"]), Convert.ToInt32(ViewData["YID"]), item.UserID) == 5)
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,5,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-3" value="5" checked="checked"/>
    	<label for="radio-mini-3">5</label>
    	
    	<% }
   else
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,5,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-3" value="5" />
    	<label for="radio-mini-3">5</label>
    	
    	<% } %>  	
    	
</fieldset>
</td>
<td>
<% if (Convert.ToInt32(ViewData["Pin"]) == 1)
   { %>
<div class="sliderforpin">
       
<select data-mini="true" name="slider<%=item.UserID %>" id="flip-a<%=item.UserID %>" data-role="slider"  data-theme="e" onchange="SliderForPin(this.value,<%=item.UserID %>,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" >
	<option value="no">Nearest the pin?</option>
	<% if (Convert.ToInt32(ViewData["PinUser"]) == item.UserID)
    { %>
	<option value="yes" selected="selected">Yes</option>
	<% }
    else
    { %>
	<option value="yes">Yes</option>
	
	<%} %>
</select></div>
<% } %>
<% if (Convert.ToInt32(ViewData["LD"]) == 1)
   { %>
<div class="sliderforLD">
       
<select data-mini="true" name="slider<%=item.UserID %>" id="flip-a<%=item.UserID %>" data-role="slider"  data-theme="e" onchange="SliderForLD(this.value,<%=item.UserID %>,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" >
	<option value="no">Longest drive</option>
	<% if (Convert.ToInt32(ViewData["LDUser"]) == item.UserID)
    { %>
	<option value="yes" selected="selected">Yes</option>
	<% }
    else
    { %>
	<option value="yes">Yes</option>
	
	<%} %>
</select></div>
<% } %>
        </td>
        <td>
        <div id="scoretxt_<%=item.UserID %>"></div>
        </td></tr>
    
    <% } %>

    </table>

</asp:Content>

