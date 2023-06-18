// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import ClipboardJS from "clipboard";

const hooks = {};
hooks.Prompt = window.Prompt;
hooks.Theme = window.Theme;


hooks.NavigationTopic = {
    mounted: () => {
      window.addEventListener("phx:navigation_topic_state", (e) => {
        fetch(`/api/navigation_topic_state?payload=${JSON.stringify(e.detail)}`, {
          method: "post",
        });
      });
    },
  };
  
  if (ClipboardJS.isSupported()) {
    hooks.Clipboard = {
      mounted() {
        const el = this.el;
        el.dataset.clipboard = true;
        const clipboard = new ClipboardJS(el);
        clipboard.on("success", function (e) {
          e.clearSelection();
          el.classList.add("clicked");
          setTimeout(() => {
            el.classList.remove("clicked");
          }, 1000);
        });
      },
    };
  }
  
  const SIDEBAR_SCROLLING_ELEM_QUERY = ".sb-sidebar__inner";
  const DRAWER_SCROLLING_ELEM_QUERY = "#drawer_navigation [data-drawer-content]";
  const DATA_ELEM_SIDEBAR_SCROLLTOP = "sidebarScrollTop";
  
  const scrollToAnchorOrTop = () => {
    let anchor;
    if (location.hash) {
      anchor = document.querySelector(location.hash);
    }
    if (anchor) {
      anchor.scrollIntoView();
    } else {
      document.scrollingElement.scrollTop = 0;
    }
  };
  
  const showCurrentSidebarLink = () => {
    const path = window.location.pathname;
    const scrollElement = document.querySelector(SIDEBAR_SCROLLING_ELEM_QUERY);
    if (!scrollElement) {
      return;
    }
    const linkElement = scrollElement.querySelector(`a[href="${path}"]`);
    if (linkElement) {
      if (path === "/") {
        linkElement.scrollTop = 0;
      } else {
        linkElement.scrollIntoView();
      }
      document.scrollingElement.scrollTop = 0;
    }
  };
  
  const showCurrentDrawerLink = () => {
    const path = window.location.pathname;
    const scrollElement = document.querySelector(DRAWER_SCROLLING_ELEM_QUERY);
    if (!scrollElement) {
      return;
    }
    const linkElement = scrollElement.querySelector(`a[href="${path}"]`);
    if (linkElement) {
      if (path === "/") {
        linkElement.scrollTop = 0;
      } else {
        linkElement.scrollIntoView();
      }
    }
  };
  
  showCurrentSidebarLink();
  scrollToAnchorOrTop();
  
  const storeSidebarScrollPosition = () => {
    const sideBarScrollElement = document.querySelector(
      SIDEBAR_SCROLLING_ELEM_QUERY
    );
    const sideBarScrollTop = sideBarScrollElement.scrollTop;
    document.body.dataset[DATA_ELEM_SIDEBAR_SCROLLTOP] = sideBarScrollTop;
  };
  
  const restoreSidebarScrollPosition = () => {
    const sideBarScrollElement = document.querySelector(
      SIDEBAR_SCROLLING_ELEM_QUERY
    );
    if (!sideBarScrollElement) {
      return;
    }
    const storedScrollTop = document.body.dataset[DATA_ELEM_SIDEBAR_SCROLLTOP];
    if (!!storedScrollTop) {
      sideBarScrollElement.scrollTop = storedScrollTop;
    }
    document.body.dataset[DATA_ELEM_SIDEBAR_SCROLLTOP] = "";
  };
  
  hooks.Drawer = {
    show: () => {
      Prompt.show("#drawer_navigation", {
        willShow: () => {
          showCurrentDrawerLink();
        },
      });
    },
    select: (delay = 400) => {
      if (delay) {
        setTimeout(() => {
          Prompt.hide("#drawer_navigation");
        }, delay);
      } else {
        Prompt.hide("#drawer_navigation");
      }
    },
  };
  
  hooks.SideBar = {
    mounted() {
      this.el.addEventListener("click", () => {
        storeSidebarScrollPosition();
      });
    },
  };
  
  hooks.Article = {
    destroyed: () => {
      document.scrollingElement.scrollTop = 0;
      setTimeout(() => scrollToAnchorOrTop(), 0);
      restoreSidebarScrollPosition();
    },
  };

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

