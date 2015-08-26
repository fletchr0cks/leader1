<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.Year>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Tournament Group
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Home", "Index", "Home")%>
<h1>Tournament Groups</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<h4>
    Tournament <%=ViewData["Tname"] %>, at <%=ViewData["Course"] %>, on <%=ViewData["Date"] %>
</h4>
    
<div id="grouplist_<%=ViewData["CourseID"] %>">
<% Html.RenderPartial("GroupPartial", ViewData["Groups"] as IEnumerable<LB3.Models.Group>); %>
</div>


<% using (Html.BeginForm(new { action = "TournInfo" }))
   {%>
   <div>Tournament Passcode</div>
    <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Passcode) %>
            
    </div>

      <p>
                <input type="submit" value="Start Playing" />
            </p>
   <% } %>

</asp:Content>
