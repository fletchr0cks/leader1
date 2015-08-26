<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	EnterPasscode
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
<h1>Enter Passcode</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<div class="ui-grid-a">
 <div class="ui-block-a"><div>
<input type="text" name="name" value="Group " id="passcode" data-mini="true" style="width:200px" /></div>
 <div>
<input type="text" name="name" value="Group " id="ownername" data-mini="true" style="width:200px" /></div>
 </div>
  </div>
 <div class="ui-block-b">
 <a href="#" onclick="checkCode()" data-role="button" data-icon="check" data-iconpos="notext"></a>
 </div>
 </div>
 <div id="results"></div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>
