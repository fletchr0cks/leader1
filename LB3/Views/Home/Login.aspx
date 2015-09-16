<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.User>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Login
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<h1>Select a User</h1>
 </asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<h4>Select Administrator User</h4>
<ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
	 <% foreach (var item in Model)
     {
    %>
    <li><a href="#" onclick="LoginUser(<%=item.UserID %>)"><%= item.Name %></a></li>
    <%} %>
</ul>


</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
<div>foot</div>
</asp:Content>

