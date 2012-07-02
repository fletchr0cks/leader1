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
            timerA = setTimeout(getLatestEvents, 10000);

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
            $.ajax({
                type: "POST",
                url: "/Home/getAllEvents",
                dataType: "html",
                success: function (data) {
                    var json = eval('(' + data + ')');
                    //alert(json);
                    $.each(json.events.reverse(), function (i, result) {
                        
                        $("#EID").val(result.EID);
                        if (result.UserID > 0) {
                            var imghtml = "<img src=../Content/images/" + result.UserID + ".PNG class=\"ui-li-thumb\"/>";
                            var html_li = "<li class=\"ui-li ui-li-static ui-body-d ui-li-has-thumb\" style=\"display:none\">" + imghtml + "<p class=\"ui-li-aside ui-li-desc\"><strong>" + result.Timest + "</strong></p><h3 class=\"ui-li-heading\">" + result.Name + "</h3><p class=\"ui-li-desc\">" + result.Comment + "</p></li>";
                            $(html_li).trigger('create').hide().prependTo('#thelist').fadeIn();
                        } else if (result.type == "Pin") {
                            var html_li = "<li class=\"ui-li ui-li-static ui-body-d\" style=\"display:none\"><p class=\"ui-li-aside\"><a href=\"About\" data-rel=\"dialog\" data-transition=\"flip\" data-inline=\"true\" data-theme=\"e\" data-role=\"button\" data-mini=\"true\">Place bets now!</a></p><h3 class=\"ui-li-heading\">" + result.Name + "</h3><p class=\"ui-li-desc\">" + result.Comment + "</p></li>";
                            $(html_li).trigger('create').hide().prependTo('#thelist').fadeIn();
                        } else {
                            var html_li = "<li class=\"ui-li ui-li-static ui-body-d\" style=\"display:none\"><p class=\"ui-li-aside ui-li-desc\"><strong>" + result.Timest + "</strong></p><h3 class=\"ui-li-heading\">" + result.Name + "</h3><p class=\"ui-li-desc\">" + result.Comment + "</p></li>";
                            $(html_li).trigger('create').hide().prependTo('#thelist').fadeIn();
                        }


                    });
                },
                error: function (xhr, error) {
                    console.debug(xhr); console.debug(error);
                }
            });
            refresht();
            //window.setTimeout(getLatestEvents(), 10000);
        }

        function getLatestEvents() {
            //alert("latest" + $("#EID").val());
            $.ajax({
                type: "POST",
                url: "/Home/getLatestEvents",
                data: "EID=" + $("#EID").val(),
                dataType: "html",
                success: function (data) {
                    var json = eval('(' + data + ')');
                    //alert(json);
                    $.each(json.events.reverse(), function (i, result) {
                       
                        $("#EID").val(result.EID);
                        if (result.UserID > 0) {
                            var imghtml = "<img src=../Content/images/" + result.UserID + ".PNG class=\"ui-li-thumb\"/>";
                            var html_li = "<li class=\"ui-li ui-li-static ui-body-d ui-li-has-thumb\" style=\"display:none\">" + imghtml + "<p class=\"ui-li-aside ui-li-desc\"><strong>" + result.Timest + "</strong></p><h3 class=\"ui-li-heading\">" + result.Name + "</h3><p class=\"ui-li-desc\">" + result.Comment + "</p></li>";
                            $(html_li).trigger('create').hide().prependTo('#thelist').fadeIn();
                        } else if (result.type == "Pin") {
                            var html_li = "<li class=\"ui-li ui-li-static ui-body-d\" style=\"display:none\"><p class=\"ui-li-aside\"><a href=\"About\" data-rel=\"dialog\" data-transition=\"flip\" data-inline=\"true\" data-theme=\"e\" data-role=\"button\" data-mini=\"true\">Place bets now!</a></p><h3 class=\"ui-li-heading\">" + result.Name + "</h3><p class=\"ui-li-desc\">" + result.Comment + "</p></li>";
                            $(html_li).trigger('create').hide().prependTo('#thelist').fadeIn();
                        } else {
                            var html_li = "<li class=\"ui-li ui-li-static ui-body-d\" style=\"display:none\"><p class=\"ui-li-aside ui-li-desc\"><strong>" + result.Timest + "</strong></p><h3 class=\"ui-li-heading\">" + result.Name + "</h3><p class=\"ui-li-desc\">" + result.Comment + "</p></li>";
                            $(html_li).trigger('create').hide().prependTo('#thelist').fadeIn();
                        }
                    });
                },
                error: function (xhr, error) {
                    console.debug(xhr); console.debug(error);
                }
            });
            refresht();
            //setTimeout(getLatestEvents(EID), 10000);
        }

        //var sizedWindowWidth = $(window).width() / 4;

    });
</script>
 

<ul data-role="listview" data-theme="d" id="thelist">
			<li>
				<h3>Stephen Weber</h3>
				<p><strong>You've been invited to a meeting at Filament Group in Boston, MA</strong></p>
				<p>Hey Stephen, if you're available at 10am tomorrow, we've got a meeting with the jQuery team.</p>
				<p class="ui-li-aside"><strong>6:24</strong>PM</p>
			</li>
			<li>
     	<h3>I'm just a div with bar classes and a </h3>
				<p>Are playing for nearest the pin</p>
				
				<p class="ui-li-aside"><a href="About" data-rel="dialog" data-transition="flip" data-inline="true" data-theme="e" data-role="button" data-mini="true">Place bets now!</a></p>

			</li>
		</ul>

<%=Html.Hidden("EID", "0") %>

</asp:Content>
