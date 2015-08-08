<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Users
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Users</h2>

    <fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">UserID</div>
        <div class="display-field"><%: Model.UserID %></div>
        
        <div class="display-label">Name</div>
        <div class="display-field"><%: Model.Name %></div>
        
        <div class="display-label">Nickname</div>
        <div class="display-field"><%: Model.Nickname %></div>
        
        <div class="display-label">Rating</div>
        <div class="display-field"><%: Model.Rating %></div>
        
    </fieldset>
    <p>

        <%: Html.ActionLink("Edit", "Edit", new { id=Model.UserID }) %> |
        <%: Html.ActionLink("Back to List", "Index") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>

