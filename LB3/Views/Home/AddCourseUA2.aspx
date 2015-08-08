<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.CourseUA>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddCourseUA2
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>AddCourseUA2</h2>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.ID) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.ID) %>
                <%: Html.ValidationMessageFor(model => model.ID) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.CourseName) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.CourseName) %>
                <%: Html.ValidationMessageFor(model => model.CourseName) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Stableford_Total) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Stableford_Total) %>
                <%: Html.ValidationMessageFor(model => model.Stableford_Total) %>
            </div>
            
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>

