/*
Copyright (C) 2015, Cristian García <cristian99garcia@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

using Wnck;


class OpenedAppButton: Gtk.Button {

    //public Wnck.Window window;
    //public Gtk.Image image;

    public OpenedAppButton() {
    }

    //public void set_window(Wnck.Window w) {
    //    window = w;

    //    image = new Gtk.Image();
        //self.image = Gtk.Image.new_from_pixbuf(window.get_icon())
        //self.set_image(self.image)
        //self.set_tooltip_text(window.get_name())

        //self.connect('button-release-event', self.__button_press_event_cb)

    //def __button_press_event_cb(self, widget, event):
    //    if event.button == 1:
    //        if not self.window.is_active():
    //            self.window.activate(0)

    //        else:
    //            self.window.minimize()
    //}
}



public class LestimPanel: Gtk.Window {

    public signal void show_apps();
    public signal void show_lateral_panel(bool visible);

    public bool shown = true;
    public string orientation = "Left";
    public bool expand = false;
    public bool autohide = false;
    public bool reserve_space = false;
    public int icon_size = 48;
    public bool panel_visible = false;
    public bool in_transition = false;

    public Gtk.Box box;
    public Gtk.Button button;
    public Gtk.Box favorite_area;
    //public Wnck.Tasklist opened_apps_area;
    private Gtk.Button lateral_panel_button;

    public LestimPanel() {
        set_keep_above(true);
        set_decorated(false);
        set_type_hint(Gdk.WindowTypeHint.DOCK);
        resize(48, 400);
        move(0, DISPLAY_HEIGHT / 2 - 200);
        set_name("LestimPanel");

        box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        add(box);

        Gtk.Button button = new Gtk.Button();
        button.set_name("PanelAppsButton");
        button.set_image(get_image_from_name("view-grid-symbolic", 48));
        button.clicked.connect(show_apps_c);
        box.pack_start(button, false, false, 0);

        favorite_area = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        box.pack_start(favorite_area, false, false, 0);

        //Wnck.Tasklist opened_apps_area = new Wnck.Tasklist();
        //opened_apps_area = new Wnck.Tasklist();
        //box.pack_start(opened_apps_area, false, false, 0);

        lateral_panel_button = new Gtk.Button();
        lateral_panel_button.set_name("ShowPanelButton");
        lateral_panel_button.clicked.connect(show_lateral_panel_c);
        box.pack_end(lateral_panel_button, false, false, 1);

        configure_event.connect(configure_event_cb);

        show_all();
    }

    private bool configure_event_cb(Gtk.Widget self, Gdk.EventConfigure event) {
        if (!check_pos()) {
            reset_pos();
        }
        return false;
    }

    private void show_lateral_panel_c(Gtk.Button button) {
        panel_visible = !(panel_visible);
        show_lateral_panel(panel_visible);
    }

    private void show_apps_c(Gtk.Button button) {
        show_apps();
    }

    public void set_reveal_state(bool visible) {
        panel_visible = visible;
    }

    public void set_orientation(string _orientation) {
        orientation = _orientation;
        if (orientation == "Top" || orientation == "Bottom") {
            box.set_orientation(Gtk.Orientation.HORIZONTAL);
            favorite_area.set_orientation(Gtk.Orientation.HORIZONTAL);
        } else {
            box.set_orientation(Gtk.Orientation.VERTICAL);
            favorite_area.set_orientation(Gtk.Orientation.VERTICAL);
        }

        reset_pos();
    }

    public void set_autohide(bool _autohide) {
        autohide = _autohide;
        reveal(!autohide);
    }

    public void set_expand(bool _expand) {
        expand = _expand;
        int w, h;
        get_size(out w, out h);

        if (orientation == "Left") {
            set_size_request(w, DISPLAY_HEIGHT);
            resize(w, DISPLAY_HEIGHT);
            move(0, 0);
        } else {
            if (h == DISPLAY_WIDTH) {
                h = 48;
            }

            set_size_request(DISPLAY_WIDTH, h);
            resize(DISPLAY_WIDTH, h);
            if (orientation == "Top") {
                move(0, 0);
            } else {
                get_size(out w, out h);
                move(DISPLAY_HEIGHT - h, 0);
            }
        }
    }

    public void set_reserve_space(bool _reserve_space) {
        reserve_space = _reserve_space;
    }

    public void set_icon_size(int size) {
        icon_size = size;
    }

    private bool check_pos() {
        int x, y, w, h;
        get_position(out x, out y);
        get_size(out w, out h);
        bool result = false;

        if (shown && !in_transition) {
            switch (orientation) {
                case "Left":
                    result = x == 0 && y == DISPLAY_HEIGHT / 2 - h / 2;
                    break;

                case "Top":
                    result = y == 0 && x == DISPLAY_WIDTH / 2 - w / 2;
                    break;

                default:
                    result = y == DISPLAY_WIDTH - h && x == DISPLAY_WIDTH / 2 - w / 2;
                    break;
            }
        } else if (!shown && !in_transition) {
            switch (orientation) {
                case "Left":
                    result = x == -w && y == DISPLAY_HEIGHT / 2 - h / 2;
                    break;

                case "Top":
                    result = y == -h && x == DISPLAY_WIDTH / 2 - w / 2;
                    break;

                default:
                    result = y == DISPLAY_WIDTH && x == DISPLAY_WIDTH / 2 - w / 2;
                    break;
            }
        } else if (in_transition) {
            result = true;
        }

        return result;
    }

    private void reset_pos() {
        if (expand) {
            if (orientation == "Left") {
                set_size_request(48, DISPLAY_HEIGHT);
                resize(48, DISPLAY_HEIGHT);
                move(0, 0);
            } else {
                set_size_request(DISPLAY_WIDTH, 48);
                resize(DISPLAY_WIDTH, 48);

                int w, h;
                get_size(out w, out h);

                if (orientation == "Top") {
                    move(0, 0);
                } else {
                    move(0, DISPLAY_HEIGHT - h);
                }
            }
        } else {
            if (orientation == "Left") {
                set_size_request(48, 1);
                resize(48, 1);
                int w, h;
                get_size(out w, out h);

                move(0, DISPLAY_HEIGHT / 2 - h / 2);
            } else {
                set_size_request(1, 48);
                resize(48, 1);
                int w, h;
                get_size(out w, out h);

                if (orientation == "Top") {
                    move(DISPLAY_WIDTH / 2 - w / 2, 0);
                } else {
                    move(DISPLAY_WIDTH / 2 - w / 2, DISPLAY_HEIGHT - h);
                }
            }
        }
    }

    private void _reveal() {
        if (in_transition) {
            return;
        }

        shown = true;

        int avance = 0;
        int w, h;
        get_size(out w, out h);

        int _x = DISPLAY_WIDTH / 2 - w / 2;
        int _y = DISPLAY_HEIGHT / 2 - h / 2;

        int lx = 0;
        int ly = 0;

        if (orientation == "Left") {
            GLib.Timeout.add(20, () => {
                get_position(out lx, out ly);

                if (lx < 0) {
                    in_transition = true;

                    avance = (w - lx) / 2;
                    lx = (lx + avance);
                    if (lx <= 0) {
                        move(lx, _y);
                    } else {
                        move(0, _y);
                    }

                    return true;
                } else {
                    in_transition = false;
                    return false;
                }
            });

        } else if (orientation == "Up") {
            GLib.Timeout.add(20, () => {
                get_position(out lx, out ly);

                if (ly < 0) {
                    in_transition = true;

                    avance = (h - ly) / 2;
                    ly = (ly + avance);
                    if (ly <= 0) {
                        move(_x, ly);
                    } else {
                        move(_x, 0);
                    }
                    return true;
                } else {
                    in_transition = false;
                    return false;
                }
            });

        } else if (orientation == "Bottom") {
            GLib.Timeout.add(20, () => {
                get_position(out lx, out ly);

                if (ly < DISPLAY_HEIGHT + h) {
                    avance = (DISPLAY_HEIGHT - ly) / 2;
                    ly = (ly + avance);
                    if (ly <= DISPLAY_HEIGHT - h) {
                        move(_x, ly);
                    } else {
                        move(_x, DISPLAY_HEIGHT - h);
                    }
                    return true;
                } else {
                    in_transition = false;
                    return false;
                }
            });
        }
    }

    private void _disreveal() {
        if (in_transition) {
            return;
        }

        shown = false;

        int avance = 0;
        int w, h;
        get_size(out w, out h);

        int _x = DISPLAY_WIDTH / 2 - w / 2;
        int _y = DISPLAY_HEIGHT / 2 - h / 2;

        int lx = 0;
        int ly = 0;
        if (orientation == "Left") {
            GLib.Timeout.add(20, () => {
                get_position(out lx, out ly);

                if (lx + w > 0) {
                    in_transition = true;

                    avance = (lx - w) / 2;
                    move(lx + avance, _y);
                    return true;
                } else {
                    in_transition = false;
                    return false;
                }
            });

        } else if (orientation == "Up") {
            GLib.Timeout.add(20, () => {
                get_position(out lx, out ly);
                if (ly + h > 0) {
                    in_transition = true;

                    avance = (ly - h) / 2;
                    move(_x, ly + avance);
                    return true;
                } else {
                    in_transition = false;
                    return false;
                }
            });

        } else if (orientation == "Bottom") {
            GLib.Timeout.add(20, () => {
                get_position(out lx, out ly);
                if (ly + h < DISPLAY_HEIGHT) {
                    in_transition = true;

                    avance = (DISPLAY_HEIGHT - ly) / 2;
                    move(_x, ly + avance);
                    return true;
                } else {
                    in_transition = false;
                    return false;
                }
            });
        }
    }

    public void reveal(bool visible) {
        if (visible == shown) {
            return;
        }

        shown = visible;
        if (!visible) {
            _disreveal();
        } else {
            _reveal();
        }
    }
}
