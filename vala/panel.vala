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

    public bool shown = false;
    //public timeout = null;
    public bool expanded = false;
    public string orientation = "Left";
    public int icon_size = 48;
    public bool pos_reseted = false;
    public bool panel_visible = false;

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

        show_all();
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

    public void set_orientation(string orie) {
        orientation = orie;
    }

    public void set_icon_size(int size) {
        icon_size = size;
    }
}
