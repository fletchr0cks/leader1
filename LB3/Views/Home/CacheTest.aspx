<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CacheTest
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">

    <h2>CacheTest</h2>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <script>
        $(function () {

            var customerIndex = 0;

            $("#back").click(function () {
                if (customerIndex > 0) {
                    customerIndex--;
                    showCustomer();
                }
            });

            $("#next").click(function () {
                customerIndex++
                showCustomer();
            });

            $("#save").click(function () {
                if (Modernizr.localstorage) {

                    saveToLocal();

                    if (isOnLine()) {
                        saveToServer();
                    }
                }
                else {
                    alert("AlwaysNote requires local storage.");
                }
            });

            function isOnLine() {
                return navigator.onLine;
            }

            function getModel(index) {
                var model = {
                    Name: "",
                    Note: "",
                    IsDirty: false,
                    Key: "",
                    ID: ""
                };

                if (localStorage[index] != null) {
                    model = JSON.parse(localStorage[index]);
                }
                model.Key = index;
                return model;
            }

            function saveToLocal() {
                var model = getModel(customerIndex);
                model.Name = $("#name").val();
                model.Note = $("#note").val();
                model.IsDirty = true;
                localStorage.setItem(customerIndex,
                    JSON.stringify(model));
                logMessage("'" + model.Name + "' saved locally.");
            }

            function saveToServer() {
                for (var i = 0; i < localStorage.length; i++) {
                    var model = getModel(i);
                    if (model.IsDirty) {
                        $.post("/customer/save", model,
                            function (data) {
                                var key = data.Key;
                                var m = getModel(key);
                                m.ID = data.ID;
                                m.IsDirty = false;
                                localStorage[key] =
                                    JSON.stringify(m);
                                logMessage("'" +
                                    m.Name + "' saved to server");
                            });
                    }
                }
            }

            function logMessage(message) {
                $("#log").append("<li>" + message + "</li>");
            }

            function clearUI() {
                $("#name, #note").val("");
                $("#log").html("");
            }

            function showCustomer() {
                var model = getModel(customerIndex);
                if (model == null) {
                    clearUI();
                }
                else {
                    $("#name").val(model.Name);
                    $("#note").val(model.Note);
                }
            }

            function reportOnlineStatus() {
                var status = $("#onlineStatus");

                if (isOnLine()) {
                    status.text("Online");
                    status.
                        removeClass("offline").
                        addClass("online");
                }
                else {
                    status.text("Offline");
                    status.
                        removeClass("online").
                        addClass("offline");
                }
            }

            window.applicationCache.onupdateready = function (e) {
                applicationCache.swapCache();
                window.location.reload();
            }

            window.addEventListener("online", function (e) {
                reportOnlineStatus();
                saveToServer();
            }, true);

            window.addEventListener("offline", function (e) {
                reportOnlineStatus();
            }, true);

            if (isOnLine()) {
                saveToServer();
            }
            showCustomer();
            reportOnlineStatus();

        });
    </script>
        <div id="onlineStatus"></div>
      
        <input type="text" placeholder="Name" id="name" />
        <textarea id="note" placeholder="Note"></textarea>
        
        <div id="command">
            <input type="button" value="&laquo;" id="back" />
            <input type="button" value="&raquo;" id="next" />
            <input type="button" value="Save" id="save" />
        </div>
      
        <a href="/events">Events</a>
        <a href="/customer/list">Customers</a>
      
        <ul id="log"></ul>
      
        <div id="version">Version 1</div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>
