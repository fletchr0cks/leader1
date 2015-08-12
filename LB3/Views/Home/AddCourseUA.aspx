<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<LB3.Models.CourseUA>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddCourseUA
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "CourseUA", "Home")%>
<h1>Add a new Course</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

 <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Fields</legend>
            
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

</asp:Content>
