<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.HoleUA>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	UAHoleDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back", "CourseUA", "Home")%>
<h1>Holes</h1>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $(document).bind("pageinit", function () {
        var UserID = GetUserID();
        $('<input>').attr({
            type: 'hidden',
            id: 'fieldId',
            name: 'OwnerID',
            value: UserID
        }).appendTo('form');
    });
</script>
    <h2><%=ViewData["Course"] %></h2>
    <% using (Html.BeginForm("CourseDetails", "Home", FormMethod.Post, new { id = "TheForm" }))
   {%>
<%: Html.ValidationSummary(true)%>

    <table>
        <tr>            
            <th>
                HoleNum
            </th>
            <th>
                Par
            </th>
            <th>
                SI
            </th>
            <th>
                Nearest the Pin?
            </th>
             <th>
                Longest Drive?
            </th>
        </tr>

    <% foreach (var item in Model)
       { %>
    
        <tr>          
            <td>
                <%: item.HoleNum%>
            </td>
            <td>
                <%: item.Par%>
            </td>
            <td>
                <%: item.SI%>
            </td>
            <td>
            
<input type="radio" value="pin_<%: item.HoleNum %>" name="pin" class="custom" data-role="none"/>
</td>
 <td>
<input type="radio" value="drive_<%: item.HoleNum %>" name="drive" class="custom" data-role="none"/>
</td>
        </tr>
    
    <% } %>

    </table>
  <input type="text" name="tname" id="tname" />

 <p>
    <input type="submit" value="Create Tournament with this course" />
            </p>
<input type="hidden" name="UACourseID" value="<%=ViewData["UACourseID"] %>"/>
<input type="hidden" name="CourseName" value="<%=ViewData["Course"] %> " />

                <% } %>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>

