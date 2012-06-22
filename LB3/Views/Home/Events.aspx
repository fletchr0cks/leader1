<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.Event>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Events
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<%= Html.ActionLink("Back to Menu", "Index", "Home", null)%>
<h1>Events</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">

    $(document).ready(function () {
        getAllEvents();
        var timerA;
        var timerB;
        //$("#canvas4").slideToggle("slow");

        function refresht() {
            clearTimeout(timerA);
            timerA = setTimeout(getAllEvents, 10000);

        }

        function inject() {
            $('#ev2').fadeIn(1000);
            clearTimeout(timerB);
            timerB = setTimeout(prep, 3000);

        }

        function prep() {
            //alert("prep");
            var html_li = "<li class=\"ui-li ui-li-static ui-body-c\" style=\"display:none\"><h3 class=\"ui-li-heading\">no thumb pre</h3><p class=\"ui-li-desc\">Content</p></li>";
            $(html_li).trigger('create').hide().prependTo('#thelist').slideDown(1000);
            clearTimeout(timerB);
            timerB = setTimeout(prep, 3000);

        }

        function getAllEvents() {
            var EID = 0;
            $.ajax({
                type: "POST",
                url: "/Home/getAllEvents",
                dataType: "html",
                success: function (data) {
                    var json = eval('(' + data + ')');
                    //alert(json);
                    $.each(json.events.reverse(), function (i, result) {
                        //alert(result.Name);
                        EID = result.EID;
                        var html_li = "<li class=\"ui-li ui-li-static ui-body-c\" style=\"display:none\"><h3 class=\"ui-li-heading\">" + result.Name + "</h3><p class=\"ui-li-desc\">" + result.Comment + "</p></li>";
                        $(html_li).trigger('create').hide().prependTo('#thelist').slideDown(1000);

                    });
                },
                error: function (xhr, error) {
                    console.debug(xhr); console.debug(error);
                }
            });

            //setTimeout(getLatestEvents(EID), 10000);
        }

        function getLatestEvents(EID) {
           
            $.ajax({
                type: "POST",
                url: "/Home/getLatestEvents",
                data: "EID=" + EID,
                dataType: "html",
                success: function (data) {
                    var json = eval('(' + data + ')');
                    //alert(json);
                    $.each(json.events.reverse(), function (i, result) {
                        //alert(result.Name);
                        EID = result.EID;
                        var html_li = "<li class=\"ui-li ui-li-static ui-body-c\" style=\"display:none\"><h3 class=\"ui-li-heading\">" + result.Name + "</h3><p class=\"ui-li-desc\">" + result.Comment + "</p></li>";
                        $(html_li).trigger('create').hide().prependTo('#thelist').slideDown(1000);

                    });
                },
                error: function (xhr, error) {
                    console.debug(xhr); console.debug(error);
                }
            });

            setTimeout(getLatestEvents(EID), 10000);
        }

        //var sizedWindowWidth = $(window).width() / 4;

    });
</script>
 
 <ul data-role="listview" id="thelist">
  
        <li class="ui-li-has-thumb" id="ev2" style="display:none">
          <img class="ui-li-thumb" src="../Content/images/3.PNG" />
        <h3>Heading here</h3>
        <p>Content</p>
        </li>
      
           <li class="ui-li-has-thumb">
          <img class="ui-li-thumb" src="../Content/images/3.PNG" />
        <h3>Heading here</h3>
        <p>Content</p>
        </li>
    <li>
         <h3>no thumb</h3>
        <p>Content</p>
        </li>
  
</ul>

</asp:Content>
