<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Hole>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Hole2
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Hole2</h2>

    <table>
        <tr>
            <th></th>
            <th>
                HoleID
            </th>
            <th>
                HoleNum
            </th>
            <th>
                HoleName
            </th>
            <th>
                CourseID
            </th>
            <th>
                Par
            </th>
            <th>
                YearID
            </th>
            <th>
                Avg
            </th>
            <th>
                Best
            </th>
            <th>
                Notes
            </th>
            <th>
                L_drive
            </th>
            <th>
                N_pin
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edit", new { id=item.HoleID }) %> |
                <%= Html.ActionLink("Details", "Details", new { id=item.HoleID })%>
            </td>
            <td>
                <%= Html.Encode(item.HoleID) %>
            </td>
            <td>
                <%= Html.Encode(item.HoleNum) %>
            </td>
            <td>
                <%= Html.Encode(item.HoleName) %>
            </td>
            <td>
                <%= Html.Encode(item.CourseID) %>
            </td>
            <td>
                <%= Html.Encode(item.Par) %>
            </td>
            <td>
                <%= Html.Encode(item.YearID) %>
            </td>
            <td>
                <%= Html.Encode(item.Avg) %>
            </td>
            <td>
                <%= Html.Encode(item.Best) %>
            </td>
            <td>
                <%= Html.Encode(item.Notes) %>
            </td>
            <td>
                <%= Html.Encode(item.L_drive) %>
            </td>
            <td>
                <%= Html.Encode(item.N_pin) %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>

