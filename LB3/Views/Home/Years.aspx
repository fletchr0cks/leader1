<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Year>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Years
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
 <h1>Select a Tournament</h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   

    <table>
        <tr>
            <th></th>
            <th>
                YID
            </th>
            <th>
                Year1
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edit", new { id=item.YID }) %> |
                <%= Html.ActionLink("Details", "Details", new { id=item.YID })%>
            </td>
            <td>
                <%= Html.Encode(item.YID) %>
            </td>
            <td>
                <%= Html.Encode(item.Year1) %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>


