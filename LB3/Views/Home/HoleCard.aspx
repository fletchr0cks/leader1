<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<LB3.Models.UserGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	HoleCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
 <%= Html.ActionLink("Hole List", "Hole", "Home", new { YID = ViewData["YID"], course = ViewData["course"], CID = ViewData["CID"], GID = ViewData["GID"] }, null)%>
 <h1><%=ViewData["course"] %>, hole <%=ViewData["HoleNum"] %></h1>
 <% if (ViewData["NextHoleID"] == null)
    {
    }
    else
    { %>    
<%= Html.ActionLink("Next Hole (" + ViewData["NextHole"] + ")", "HoleCard", "Home", new { YID = ViewData["YID"], course = ViewData["course"], GID = ViewData["GID"], HoleID = ViewData["NextHoleID"], CID = ViewData["CID"] }, null)%>
<% } %>
   
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
   <script type="text/javascript">

       $(function () {
           //var sizedWindowWidth = $(window).width() / 4;
           $('#scoretxt_2').html("refresh").trigger('refresh');
                  });



       function SliderForLD(slval, userid, HID, YID, GID) {
           $.ajax({
               type: "POST",
               url: "/Home/newScore",
               data: "GID=" + GID + "&HID=" + HID + "&YID=" + YID + "&score=0&UserID=" + userid + "&Pin=0&LD=1",
               dataType: "html",
               success: function (data) {
                   var json = eval('(' + data + ')');
                   $.each(json.winners.reverse(), function (i, result) {
                       var nickname = result.nickname;
                       $('#scoretxt_' + userid).html("Nice one " + nickname).trigger('refresh');
                   });

                   $.each(json.members.reverse(), function (i, result) {
                       var id = result.UserID;
                       $('#flip-a' + id).val('off').slider('refresh');
                       $('#scoretxt_' + id).html("Better luck next time.").trigger('refresh');
                   });


               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
               }
           });
           return false;
       }

       function SliderForPin(slval, userid, HID, YID, GID) {
           //alert(userid + " " + HID + " " + YID + " " + GID);
           $.ajax({
               type: "POST",
               url: "/Home/newScore",
               data: "GID=" + GID + "&HID=" + HID + "&YID=" + YID + "&score=0&UserID=" + userid + "&Pin=1&LD=0",
               dataType: "html",
               success: function (data) {
                   var json = eval('(' + data + ')');
                   $.each(json.winners.reverse(), function (i, result) {
                       var nickname = result.nickname;
                       $('#scoretxt_' + userid).html("Nice one " + nickname).trigger("create").fadeIn();
                   });

                   $.each(json.members.reverse(), function (i, result) {
                       var id = result.UserID;
                       $('#flip-a' + id).val('off').slider('refresh');
                       $('#scoretxt_' + id).html("Better luck next time.").trigger("create").fadeIn();
                   });


               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
               }
           });
           return false;
       }

       function NewScoreFor(userid, score, HID, YID, GID) {

           $.ajax({
               type: "POST",
               url: "/Home/newScore",
               data: "GID=" + GID + "&YID=" + YID + "&HID=" + HID + "&score=" + score + "&Pin=0&LD=0&UserID=" + userid,
               dataType: "html",
               success: function (data) {
                   var json = eval('(' + data + ')');

                   var type = json.type;

                   $('#scoretxt_' + userid).html(type).trigger("create");

               },
               error: function (xhr, error) {
                   console.debug(xhr); console.debug(error);
               }
           });
           return false;
       }


          function drawCanvas(num) {
           $("#canvas" + num).width(400);
           $("#canvas" + num).height(80);

           var canvas = $("#canvas" + num).get(0);

           if (canvas) {
               var canvasContext = canvas.getContext('2d');

               if (canvasContext) {
                   canvasContext.canvas.width = 400;
                   canvasContext.canvas.height = 80;

                   //canvasContext.font = "bold 14px serif";
                   //canvasContext.fillText("Canvas is supported", 10, 20);
                   canvasContext.strokeStyle = "#2489CE";
                   canvasContext.moveTo(20, 65);
                   canvasContext.lineTo(380, 65);
                   
                   canvasContext.stroke();

                   canvasContext.font = "bold 10px sans-serif";
                   canvasContext.fillStyle = "#999";
                   canvasContext.fillText("2008", 95, 78);

                   canvasContext.fillStyle = "#999";
                   canvasContext.fillRect(100, 10, 20, 55);


                   $("#canvas" + num).trigger('refresh').fadeIn(2000);
               }
       

           }

       }

       

</script>

    <% foreach (var item in Model) { %>
   
    <div class="ui-body ui-body-d">
    <table>
       
        <tr>
            
            <td>
                <div class="H1thin"><%= Html.Encode(item.User.Nickname) %>
                <div class="thin" style="display:inline" id="scoretxt_<%=item.UserID %>">ready</div></div>
            </td>
           <td><a href="#" onclick="drawCanvas(<%=item.UserID %>)" data-role="button" data-icon="info" data-iconpos="notext">Stats</a></td>
           <td rowspan="3"><canvas style="border:1px solid #999;display:none" "width="400px" height="80px" id="canvas<%=item.UserID %>">Canvas is not supported</canvas></td>
        </tr>
        <tr><td>
     
        <fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
    	<% if (item.checkScore(Convert.ToInt32(ViewData["HID"]), Convert.ToInt32(ViewData["YID"]), item.UserID) == 2)
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,2,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-0" value="2" checked="checked"/>
    	<label for="radio-mini-0">2</label>
    	
    	<% }
   else
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,2,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-0" value="2" />
    	<label for="radio-mini-0">2</label>
    	
    	<% } %>
    	<% if (item.checkScore(Convert.ToInt32(ViewData["HID"]), Convert.ToInt32(ViewData["YID"]), item.UserID) == 3)
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,3,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-1" value="3" checked="checked"/>
    	<label for="radio-mini-1">3</label>
    	
    	<% }
   else
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,3,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-1" value="3" />
    	<label for="radio-mini-1">3</label>
    	
    	<% } %>
  
  <% if (item.checkScore(Convert.ToInt32(ViewData["HID"]), Convert.ToInt32(ViewData["YID"]), item.UserID) == 4)
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,4,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-2" value="4" checked="checked"/>
    	<label for="radio-mini-2">4</label>
    	
    	<% }
   else
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,4,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-2" value="4" />
    	<label for="radio-mini-2">4</label>
    	
    	<% } %>  	
    	 <% if (item.checkScore(Convert.ToInt32(ViewData["HID"]), Convert.ToInt32(ViewData["YID"]), item.UserID) == 5)
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,5,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-3" value="5" checked="checked"/>
    	<label for="radio-mini-3">5</label>
    	
    	<% }
   else
   { %>
    	<input type="radio"  onclick="NewScoreFor(<%=item.UserID %>,5,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" name="radio-choice-<%=item.UserID %>" id="radio-mini-3" value="5" />
    	<label for="radio-mini-3">5</label>
    	
    	<% } %>  	
    	
</fieldset>
</td>
<td></td>
        <td>
         
         
        </td>
</tr>
<tr>
<td>
<% if (Convert.ToInt32(ViewData["Pin"]) == 1)
   { %>
<div class="sliderforpin">
       
<select data-mini="true" name="slider<%=item.UserID %>" id="flip-a<%=item.UserID %>" data-role="slider"  data-theme="e" onchange="SliderForPin(this.value,<%=item.UserID %>,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" >
	<option value="no">Nearest the pin?</option>
	<% if (Convert.ToInt32(ViewData["PinUser"]) == item.UserID)
    { %>
	<option value="yes" selected="selected">Yes</option>
	<% }
    else
    { %>
	<option value="yes">Yes</option>
	
	<%} %>
</select></div>
<% } %>
<% if (Convert.ToInt32(ViewData["LD"]) == 1)
   { %>
<div class="sliderforLD">
       
<select data-mini="true" name="slider<%=item.UserID %>" id="flip-a<%=item.UserID %>" data-role="slider"  data-theme="e" onchange="SliderForLD(this.value,<%=item.UserID %>,<%=ViewData["HID"] %>,<%=ViewData["YID"] %>,<%=ViewData["GID"] %>)" >
	<option value="no">Longest drive</option>
	<% if (Convert.ToInt32(ViewData["LDUser"]) == item.UserID)
    { %>
	<option value="yes" selected="selected">Yes</option>
	<% }
    else
    { %>
	<option value="yes">Yes</option>
	
	<%} %>
</select></div>
<% } %>
        </td><td></td>      
        </tr>
     </table></div>
         <p class="thin">&nbsp;</p>
    <% } %>

   
    
</asp:Content>

