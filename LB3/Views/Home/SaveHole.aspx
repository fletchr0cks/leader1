<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.Hole>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	SaveHole
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>SaveHole</h2>

    <%= Html.ValidationSummary("Edit was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm()) {%>

        <fieldset>
            <legend>Fields</legend>
            <p>
                <label for="HoleID">HoleID:</label>
                <%= Html.TextBox("HoleID", Model.HoleID) %>
                <%= Html.ValidationMessage("HoleID", "*") %>
            </p>
            <p>
                <label for="HoleNum">HoleNum:</label>
                <%= Html.TextBox("HoleNum", Model.HoleNum) %>
                <%= Html.ValidationMessage("HoleNum", "*") %>
            </p>
            <p>
                <label for="HoleName">HoleName:</label>
                <%= Html.TextBox("HoleName", Model.HoleName) %>
                <%= Html.ValidationMessage("HoleName", "*") %>
            </p>
            <p>
                <label for="CourseID">CourseID:</label>
                <%= Html.TextBox("CourseID", Model.CourseID) %>
                <%= Html.ValidationMessage("CourseID", "*") %>
            </p>
            <p>
                <label for="Par">Par:</label>
                <%= Html.TextBox("Par", Model.Par) %>
                <%= Html.ValidationMessage("Par", "*") %>
            </p>
            <p>
                <label for="YearID">YearID:</label>
                <%= Html.TextBox("YearID", Model.YearID) %>
                <%= Html.ValidationMessage("YearID", "*") %>
            </p>
            <p>
                <label for="Avg">Avg:</label>
                <%= Html.TextBox("Avg", Model.Avg) %>
                <%= Html.ValidationMessage("Avg", "*") %>
            </p>
            <p>
                <label for="Best">Best:</label>
                <%= Html.TextBox("Best", Model.Best) %>
                <%= Html.ValidationMessage("Best", "*") %>
            </p>
            <p>
                <label for="Notes">Notes:</label>
                <%= Html.TextBox("Notes", Model.Notes) %>
                <%= Html.ValidationMessage("Notes", "*") %>
            </p>
            <p>
                <label for="L_drive">L_drive:</label>
                <%= Html.TextBox("L_drive", Model.L_drive) %>
                <%= Html.ValidationMessage("L_drive", "*") %>
            </p>
            <p>
                <label for="N_pin">N_pin:</label>
                <%= Html.TextBox("N_pin", Model.N_pin) %>
                <%= Html.ValidationMessage("N_pin", "*") %>
            </p>
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%=Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>

