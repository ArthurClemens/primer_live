defmodule AttributeHelpersTest do
  @moduledoc false
  use ExUnit.Case

  describe "The prompt_attrs/2 function" do
    test "Default values (with attr id to prevent getting random values in tests)" do
      assert PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
               %{
                 rest: %{
                   id: "some-id"
                 },
                 is_fast: false,
                 backdrop_strength: nil,
                 is_backdrop: false,
                 is_show: false,
                 show_state: nil,
                 is_show_on_mount: false,
                 on_cancel: nil,
                 focus_after_opening_selector: nil,
                 focus_after_closing_selector: nil,
                 transition_duration: nil,
                 status_callback_selector: nil,
                 is_escapable: true
               },
               %{
                 component: "some-component-name",
                 toggle_slot: nil,
                 toggle_class: "btn",
                 menu_class: "",
                 is_menu: true
               }
             ) ==
               %{
                 backdrop_attrs: [],
                 focus_wrap_attrs: [
                   "data-focuswrap": "",
                   id: "focus-wrap-some-id",
                   "phx-key": "Escape",
                   "phx-window-keydown": %Phoenix.LiveView.JS{
                     ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                   }
                 ],
                 prompt_attrs: [
                   class: nil,
                   "data-cancel": %Phoenix.LiveView.JS{ops: [["exec", %{attr: "data-close"}]]},
                   "data-close": %Phoenix.LiveView.JS{
                     ops: [
                       ["remove_class", %{names: ["is-showing"], to: "#some-id"}],
                       [
                         "remove_class",
                         %{
                           names: ["is-open"],
                           to: "#some-id",
                           transition: [["duration-"], [""], [""]]
                         }
                       ],
                       ["pop_focus", %{}]
                     ]
                   },
                   "data-isescapable": "",
                   "data-ismenu": "",
                   "data-open": %Phoenix.LiveView.JS{
                     ops: [
                       ["add_class", %{names: ["is-open"], to: "#some-id"}],
                       ["focus_first", %{to: "#some-id [data-content]"}],
                       [
                         "add_class",
                         %{
                           names: ["is-showing"],
                           time: 30,
                           to: "#some-id",
                           transition: [["duration-30"], [""], [""]]
                         }
                       ]
                     ]
                   },
                   "data-prompt": "",
                   id: "some-id",
                   "phx-hook": "Prompt",
                   "phx-remove": nil
                 ],
                 toggle_attrs: [
                   {:"aria-haspopup", "true"},
                   {:"aria-owns", "focus-wrap-some-id"},
                   {:class, "btn"},
                   {:"phx-click",
                    %Phoenix.LiveView.JS{
                      ops: [["dispatch", %{event: "prompt:toggle", to: "#some-id"}]]
                    }},
                   {:type, "button"}
                 ],
                 touch_layer_attrs: [
                   "data-touch": "",
                   "phx-click": %Phoenix.LiveView.JS{
                     ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                   }
                 ]
               }
    end

    test "With is_show_on_mount" do
      assert PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
               %{
                 rest: %{
                   id: "some-id"
                 },
                 is_fast: false,
                 backdrop_strength: nil,
                 is_show: true,
                 show_state: nil,
                 is_show_on_mount: true,
                 on_cancel: nil,
                 focus_after_opening_selector: nil,
                 focus_after_closing_selector: nil,
                 transition_duration: nil,
                 status_callback_selector: nil,
                 is_escapable: true
               },
               %{
                 component: "some-component-name",
                 toggle_slot: nil,
                 toggle_class: "btn",
                 menu_class: "",
                 is_menu: false
               }
             ) == %{
               backdrop_attrs: [],
               focus_wrap_attrs: [
                 "data-focuswrap": "",
                 id: "focus-wrap-some-id",
                 "phx-key": "Escape",
                 "phx-window-keydown": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ],
               prompt_attrs: [
                 class: "is-open is-showing is-show_on_mount",
                 "data-cancel": %Phoenix.LiveView.JS{ops: [["exec", %{attr: "data-close"}]]},
                 "data-close": %Phoenix.LiveView.JS{
                   ops: [
                     ["remove_class", %{names: ["is-showing"], to: "#some-id"}],
                     [
                       "remove_class",
                       %{
                         names: ["is-open"],
                         to: "#some-id",
                         transition: [["duration-"], [""], [""]]
                       }
                     ],
                     ["pop_focus", %{}]
                   ]
                 },
                 "data-isescapable": "",
                 "data-open": %Phoenix.LiveView.JS{
                   ops: [
                     ["add_class", %{names: ["is-open"], to: "#some-id"}],
                     ["focus_first", %{to: "#some-id [data-content]"}],
                     ["add_class", %{names: ["is-showing"], to: "#some-id"}],
                     ["remove_class", %{names: ["is-show_on_mount"], to: "#some-id"}]
                   ]
                 },
                 "data-prompt": "",
                 id: "some-id",
                 "phx-hook": "Prompt",
                 "phx-mounted": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-open", to: "#some-id"}]]
                 },
                 "phx-remove": nil
               ],
               toggle_attrs: [
                 {:"aria-haspopup", "true"},
                 {:"aria-owns", "focus-wrap-some-id"},
                 {:class, "btn"},
                 {:"phx-click",
                  %Phoenix.LiveView.JS{
                    ops: [["dispatch", %{event: "prompt:toggle", to: "#some-id"}]]
                  }},
                 {:type, "button"}
               ],
               touch_layer_attrs: [
                 "data-touch": "",
                 "phx-click": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ]
             }
    end

    test "With on_cancel and is_show_on_mount" do
      assert PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
               %{
                 rest: %{
                   id: "some-id"
                 },
                 is_fast: false,
                 backdrop_strength: nil,
                 is_show: true,
                 show_state: nil,
                 is_show_on_mount: true,
                 on_cancel: Phoenix.LiveView.JS.patch("/"),
                 focus_after_opening_selector: nil,
                 focus_after_closing_selector: nil,
                 transition_duration: nil,
                 status_callback_selector: nil,
                 is_escapable: true
               },
               %{
                 component: "some-component-name",
                 toggle_slot: nil,
                 toggle_class: "btn",
                 menu_class: "",
                 is_menu: false
               }
             ) == %{
               backdrop_attrs: [],
               focus_wrap_attrs: [
                 "data-focuswrap": "",
                 id: "focus-wrap-some-id",
                 "phx-key": "Escape",
                 "phx-window-keydown": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ],
               prompt_attrs: [
                 class: "is-open is-showing is-show_on_mount",
                 "data-cancel": %Phoenix.LiveView.JS{
                   ops: [["patch", %{replace: false, href: "/"}], ["exec", %{attr: "data-close"}]]
                 },
                 "data-close": %Phoenix.LiveView.JS{
                   ops: [
                     ["remove_class", %{names: ["is-showing"], to: "#some-id"}],
                     [
                       "remove_class",
                       %{
                         names: ["is-open"],
                         to: "#some-id",
                         transition: [["duration-"], [""], [""]]
                       }
                     ],
                     ["pop_focus", %{}]
                   ]
                 },
                 "data-isescapable": "",
                 "data-open": %Phoenix.LiveView.JS{
                   ops: [
                     ["add_class", %{names: ["is-open"], to: "#some-id"}],
                     ["focus_first", %{to: "#some-id [data-content]"}],
                     ["add_class", %{names: ["is-showing"], to: "#some-id"}],
                     ["remove_class", %{names: ["is-show_on_mount"], to: "#some-id"}]
                   ]
                 },
                 "data-prompt": "",
                 id: "some-id",
                 "phx-hook": "Prompt",
                 "phx-mounted": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-open", to: "#some-id"}]]
                 },
                 "phx-remove": %Phoenix.LiveView.JS{
                   ops: [["exec", %{to: "#some-id", attr: "data-close"}]]
                 }
               ],
               toggle_attrs: [
                 {:"aria-haspopup", "true"},
                 {:"aria-owns", "focus-wrap-some-id"},
                 {:class, "btn"},
                 {:"phx-click",
                  %Phoenix.LiveView.JS{
                    ops: [["dispatch", %{event: "prompt:toggle", to: "#some-id"}]]
                  }},
                 {:type, "button"}
               ],
               touch_layer_attrs: [
                 "data-touch": "",
                 "phx-click": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ]
             }
    end

    test "With on_cancel and show_state \"onset\"" do
      assert PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
               %{
                 rest: %{
                   id: "some-id"
                 },
                 is_fast: false,
                 backdrop_strength: nil,
                 is_show: true,
                 show_state: "onset",
                 is_show_on_mount: nil,
                 on_cancel: Phoenix.LiveView.JS.patch("/"),
                 focus_after_opening_selector: nil,
                 focus_after_closing_selector: nil,
                 transition_duration: nil,
                 status_callback_selector: nil,
                 is_escapable: true
               },
               %{
                 component: "some-component-name",
                 toggle_slot: nil,
                 toggle_class: "btn",
                 menu_class: "",
                 is_menu: false
               }
             ) == %{
               backdrop_attrs: [],
               focus_wrap_attrs: [
                 "data-focuswrap": "",
                 id: "focus-wrap-some-id",
                 "phx-key": "Escape",
                 "phx-window-keydown": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ],
               prompt_attrs: [
                 class: nil,
                 "data-cancel": %Phoenix.LiveView.JS{
                   ops: [["patch", %{replace: false, href: "/"}], ["exec", %{attr: "data-close"}]]
                 },
                 "data-close": %Phoenix.LiveView.JS{
                   ops: [
                     ["remove_class", %{names: ["is-showing"], to: "#some-id"}],
                     [
                       "remove_class",
                       %{
                         names: ["is-open"],
                         to: "#some-id",
                         transition: [["duration-"], [""], [""]]
                       }
                     ],
                     ["pop_focus", %{}]
                   ]
                 },
                 "data-isescapable": "",
                 "data-open": %Phoenix.LiveView.JS{
                   ops: [
                     ["add_class", %{names: ["is-open"], to: "#some-id"}],
                     ["focus_first", %{to: "#some-id [data-content]"}],
                     [
                       "add_class",
                       %{
                         names: ["is-showing"],
                         time: 30,
                         to: "#some-id",
                         transition: [["duration-30"], [""], [""]]
                       }
                     ]
                   ]
                 },
                 "data-prompt": "",
                 id: "some-id",
                 "phx-hook": "Prompt",
                 "phx-mounted": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-open", to: "#some-id"}]]
                 }
               ],
               toggle_attrs: [
                 {:"aria-haspopup", "true"},
                 {:"aria-owns", "focus-wrap-some-id"},
                 {:class, "btn"},
                 {:"phx-click",
                  %Phoenix.LiveView.JS{
                    ops: [["dispatch", %{event: "prompt:toggle", to: "#some-id"}]]
                  }},
                 {:type, "button"}
               ],
               touch_layer_attrs: [
                 "data-touch": "",
                 "phx-click": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ]
             }
    end

    test "With on_cancel and show_state \"hold\"" do
      assert PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
               %{
                 rest: %{
                   id: "some-id"
                 },
                 is_fast: false,
                 backdrop_strength: nil,
                 is_show: true,
                 show_state: "hold",
                 is_show_on_mount: true,
                 on_cancel: Phoenix.LiveView.JS.patch("/"),
                 focus_after_opening_selector: nil,
                 focus_after_closing_selector: nil,
                 transition_duration: nil,
                 status_callback_selector: nil,
                 is_escapable: true
               },
               %{
                 component: "some-component-name",
                 toggle_slot: nil,
                 toggle_class: "btn",
                 menu_class: "",
                 is_menu: false
               }
             ) == %{
               backdrop_attrs: [],
               focus_wrap_attrs: [
                 "data-focuswrap": "",
                 id: "focus-wrap-some-id",
                 "phx-key": "Escape",
                 "phx-window-keydown": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ],
               prompt_attrs: [
                 class: "is-open is-showing is-show_on_mount",
                 "data-cancel": %Phoenix.LiveView.JS{
                   ops: [["patch", %{replace: false, href: "/"}], ["exec", %{attr: "data-close"}]]
                 },
                 "data-close": %Phoenix.LiveView.JS{
                   ops: [
                     ["remove_class", %{names: ["is-showing"], to: "#some-id"}],
                     [
                       "remove_class",
                       %{
                         names: ["is-open"],
                         to: "#some-id",
                         transition: [["duration-"], [""], [""]]
                       }
                     ],
                     ["pop_focus", %{}]
                   ]
                 },
                 "data-isescapable": "",
                 "data-open": %Phoenix.LiveView.JS{
                   ops: [
                     ["add_class", %{names: ["is-open"], to: "#some-id"}],
                     ["add_class", %{names: ["is-showing"], to: "#some-id"}],
                     ["remove_class", %{names: ["is-show_on_mount"], to: "#some-id"}]
                   ]
                 },
                 "data-prompt": "",
                 id: "some-id",
                 "phx-hook": "Prompt",
                 "phx-mounted": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-open", to: "#some-id"}]]
                 }
               ],
               toggle_attrs: [
                 {:"aria-haspopup", "true"},
                 {:"aria-owns", "focus-wrap-some-id"},
                 {:class, "btn"},
                 {:"phx-click",
                  %Phoenix.LiveView.JS{
                    ops: [["dispatch", %{event: "prompt:toggle", to: "#some-id"}]]
                  }},
                 {:type, "button"}
               ],
               touch_layer_attrs: [
                 "data-touch": "",
                 "phx-click": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ]
             }
    end

    test "With transition_duration" do
      assert PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
               %{
                 rest: %{
                   id: "some-id"
                 },
                 is_fast: true,
                 backdrop_strength: nil,
                 is_backdrop: true,
                 is_show: false,
                 show_state: nil,
                 is_show_on_mount: false,
                 on_cancel: nil,
                 focus_after_opening_selector: nil,
                 focus_after_closing_selector: nil,
                 transition_duration: 500,
                 status_callback_selector: nil,
                 is_escapable: true
               },
               %{
                 component: "some-component-name",
                 toggle_slot: nil,
                 toggle_class: "btn",
                 menu_class: "",
                 is_menu: false
               }
             ) == %{
               backdrop_attrs: ["data-backdrop": ""],
               focus_wrap_attrs: [
                 "data-focuswrap": "",
                 id: "focus-wrap-some-id",
                 "phx-key": "Escape",
                 "phx-window-keydown": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ],
               prompt_attrs: [
                 class: nil,
                 "data-cancel": %Phoenix.LiveView.JS{ops: [["exec", %{attr: "data-close"}]]},
                 "data-close": %Phoenix.LiveView.JS{
                   ops: [
                     [
                       "set_attr",
                       %{
                         attr: [
                           "style",
                           "--prompt-transition-duration: 500ms; --prompt-fast-transition-duration: 500ms;"
                         ],
                         to: "#some-id"
                       }
                     ],
                     ["remove_class", %{names: ["is-showing"], to: "#some-id"}],
                     [
                       "remove_class",
                       %{
                         names: ["is-open"],
                         time: 500,
                         to: "#some-id",
                         transition: [["duration-500"], [""], [""]]
                       }
                     ],
                     ["pop_focus", %{}]
                   ]
                 },
                 "data-isescapable": "",
                 "data-isfast": "",
                 "data-open": %Phoenix.LiveView.JS{
                   ops: [
                     [
                       "set_attr",
                       %{
                         attr: [
                           "style",
                           "--prompt-transition-duration: 500ms; --prompt-fast-transition-duration: 500ms;"
                         ],
                         to: "#some-id"
                       }
                     ],
                     ["add_class", %{names: ["is-open"], to: "#some-id"}],
                     ["focus_first", %{to: "#some-id [data-content]"}],
                     [
                       "add_class",
                       %{
                         names: ["is-showing"],
                         time: 30,
                         to: "#some-id",
                         transition: [["duration-30"], [""], [""]]
                       }
                     ]
                   ]
                 },
                 "data-prompt": "",
                 id: "some-id",
                 "phx-hook": "Prompt",
                 "phx-remove": nil
               ],
               toggle_attrs: [
                 {:"aria-haspopup", "true"},
                 {:"aria-owns", "focus-wrap-some-id"},
                 {:class, "btn"},
                 {:"phx-click",
                  %Phoenix.LiveView.JS{
                    ops: [["dispatch", %{event: "prompt:toggle", to: "#some-id"}]]
                  }},
                 {:type, "button"}
               ],
               touch_layer_attrs: [
                 "data-touch": "",
                 "phx-click": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ]
             }
    end

    test "Transition duration equals default duration" do
      assert PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
               %{
                 rest: %{
                   id: "some-id"
                 },
                 is_fast: true,
                 backdrop_strength: nil,
                 is_backdrop: true,
                 is_show: false,
                 show_state: nil,
                 is_show_on_mount: false,
                 on_cancel: nil,
                 focus_after_opening_selector: nil,
                 focus_after_closing_selector: nil,
                 transition_duration: 170,
                 status_callback_selector: nil,
                 is_escapable: true
               },
               %{
                 component: "some-component-name",
                 toggle_slot: nil,
                 toggle_class: "btn",
                 menu_class: "",
                 is_menu: false
               }
             ) == %{
               backdrop_attrs: ["data-backdrop": ""],
               focus_wrap_attrs: [
                 "data-focuswrap": "",
                 id: "focus-wrap-some-id",
                 "phx-key": "Escape",
                 "phx-window-keydown": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ],
               prompt_attrs: [
                 class: nil,
                 "data-cancel": %Phoenix.LiveView.JS{ops: [["exec", %{attr: "data-close"}]]},
                 "data-close": %Phoenix.LiveView.JS{
                   ops: [
                     ["remove_class", %{names: ["is-showing"], to: "#some-id"}],
                     [
                       "remove_class",
                       %{
                         names: ["is-open"],
                         time: 170,
                         to: "#some-id",
                         transition: [["duration-170"], [""], [""]]
                       }
                     ],
                     ["pop_focus", %{}]
                   ]
                 },
                 "data-isescapable": "",
                 "data-isfast": "",
                 "data-open": %Phoenix.LiveView.JS{
                   ops: [
                     ["add_class", %{names: ["is-open"], to: "#some-id"}],
                     ["focus_first", %{to: "#some-id [data-content]"}],
                     [
                       "add_class",
                       %{
                         names: ["is-showing"],
                         time: 30,
                         to: "#some-id",
                         transition: [["duration-30"], [""], [""]]
                       }
                     ]
                   ]
                 },
                 "data-prompt": "",
                 id: "some-id",
                 "phx-hook": "Prompt",
                 "phx-remove": nil
               ],
               toggle_attrs: [
                 {:"aria-haspopup", "true"},
                 {:"aria-owns", "focus-wrap-some-id"},
                 {:class, "btn"},
                 {:"phx-click",
                  %Phoenix.LiveView.JS{
                    ops: [["dispatch", %{event: "prompt:toggle", to: "#some-id"}]]
                  }},
                 {:type, "button"}
               ],
               touch_layer_attrs: [
                 "data-touch": "",
                 "phx-click": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ]
             }
    end

    test "Backdrop settings" do
      assert PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
               %{
                 rest: %{
                   id: "some-id"
                 },
                 is_fast: true,
                 is_backdrop: true,
                 backdrop_strength: "medium",
                 backdrop_tint: "light",
                 is_show: false,
                 show_state: nil,
                 is_show_on_mount: false,
                 on_cancel: nil,
                 focus_after_opening_selector: nil,
                 focus_after_closing_selector: nil,
                 transition_duration: nil,
                 status_callback_selector: nil,
                 is_escapable: true
               },
               %{
                 component: "some-component-name",
                 toggle_slot: nil,
                 toggle_class: "btn",
                 menu_class: "",
                 is_menu: true
               }
             ) == %{
               backdrop_attrs: [
                 {:"data-backdrop", ""},
                 {:"data-backdrop-strength", "medium"},
                 {:"data-backdrop-tint", "light"}
               ],
               focus_wrap_attrs: [
                 "data-focuswrap": "",
                 id: "focus-wrap-some-id",
                 "phx-key": "Escape",
                 "phx-window-keydown": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ],
               prompt_attrs: [
                 class: nil,
                 "data-cancel": %Phoenix.LiveView.JS{ops: [["exec", %{attr: "data-close"}]]},
                 "data-close": %Phoenix.LiveView.JS{
                   ops: [
                     ["remove_class", %{names: ["is-showing"], to: "#some-id"}],
                     [
                       "remove_class",
                       %{
                         names: ["is-open"],
                         to: "#some-id",
                         transition: [["duration-"], [""], [""]]
                       }
                     ],
                     ["pop_focus", %{}]
                   ]
                 },
                 "data-isescapable": "",
                 "data-isfast": "",
                 "data-ismenu": "",
                 "data-open": %Phoenix.LiveView.JS{
                   ops: [
                     ["add_class", %{names: ["is-open"], to: "#some-id"}],
                     ["focus_first", %{to: "#some-id [data-content]"}],
                     [
                       "add_class",
                       %{
                         names: ["is-showing"],
                         time: 30,
                         to: "#some-id",
                         transition: [["duration-30"], [""], [""]]
                       }
                     ]
                   ]
                 },
                 "data-prompt": "",
                 id: "some-id",
                 "phx-hook": "Prompt",
                 "phx-remove": nil
               ],
               toggle_attrs: [
                 {:"aria-haspopup", "true"},
                 {:"aria-owns", "focus-wrap-some-id"},
                 {:class, "btn"},
                 {:"phx-click",
                  %Phoenix.LiveView.JS{
                    ops: [["dispatch", %{event: "prompt:toggle", to: "#some-id"}]]
                  }},
                 {:type, "button"}
               ],
               touch_layer_attrs: [
                 "data-touch": "",
                 "phx-click": %Phoenix.LiveView.JS{
                   ops: [["exec", %{attr: "data-cancel", to: "#some-id"}]]
                 }
               ]
             }
    end
  end
end
