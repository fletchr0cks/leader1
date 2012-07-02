<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	GroupsList
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">

   GroupsList

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
 <script type="text/javascript">

      $(document).bind('pageinit', function() {
     // Do this once, first page load.
         addlines1();

       addlines2();
     //$("#ui-select").attr("data-native-menu", "false");
      });

     function addlines1() {
         var list = "",
    items = [{ name: "L1 Item A", url: "/#item-a" },
             { name: "L1 Item B", url: "/#item-b" },
             { name: "L1 Item C", url: "/#item-c"}];

         $.each(items, function(i, item) {
             list += '<li><a href="' + item.url + '">';
             list += item.name;
             list += '</a></li>';
         });

         var gp = "<div data-role=\"collapsible\" data-id=\"myGP1\"><h3>Group 2</h3><div id=\"group1\">gp 1</div></div>";

         $("ul:jqmData(id='myID1')").append(list).listview("refresh");
         //$("div:jqmData(id='myGP1')").append(gp);
         $("#colset").html();
         $("#colset").html(gp);
         $("#colset").trigger("create");
     }


     function addlines2() {
         var list = "",
    items = [{ name: "L2 Item A", url: "/#item-a" },
             { name: "L2 Item B", url: "/#item-b" },
             { name: "L2 Item C", url: "/#item-c"}];

         $.each(items, function(i, item) {
             list += '<li><a href="' + item.url + '">';
             list += item.name;
             list += '</a></li>';
         });
         $("ul:jqmData(id='myID2')").append(list).listview("refresh");
     }

</script>
    


    <div data-role="collapsible" data-theme="a" data-content-theme="a">
   <h3>Header swatch A</h3>
   <p>I'm the collapsible content with a themed content block set to "A".</p>
</div>
   
<div id="colset">
	here
	</div>
	
 <p><div onclick="addlines1()">Add 1</div></p>
  
  <p><div onclick="addlines2()">Add 2</div></p>
</asp:Content>

