<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Years>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	MyTournx
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>MyTournx</h2>

    <table>
        <tr>
            <th></th>
            <th>
                YID
            </th>
            <th>
                Year1
            </th>
            <th>
                Name
            </th>
            <th>
                Date
            </th>
            <th>
                Passcode
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink("Edit", "Edit", new { id=item.YID }) %> |
                <%: Html.ActionLink("Details", "Details", new { id=item.YID })%> |
                <%: Html.ActionLink("Delete", "Delete", new { id=item.YID })%>
            </td>
            <td>
                <%: item.YID %>
            </td>
            <td>
                <%: item.Year1 %>
            </td>
            <td>
                <%: item.Name %>
            </td>
            <td>
                <%: String.Format("{0:g}", item.Date) %>
            </td>
            <td>
                <%: item.Passcode %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%: Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>

