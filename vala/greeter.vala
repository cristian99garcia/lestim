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

public class GreeterCanvas: Gtk.Box {

    public Gtk.Box canvas;
    public Gtk.Image distro_logo;

    public GreeterCanvas() {
        set_orientation(Gtk.Orientation.VERTICAL);

        Gtk.Box hbox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
        add(hbox);

        canvas = new Gtk.Box(Gtk.Orientation.VERTICAL, 5);
        hbox.add(canvas);

        hbox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);
        canvas.pack_start(hbox, false, false, 0);

        distro_logo = Gtk.Image();
        hbox.pack_start(distro_logo, false, false, 0);
        hbox.pack_start(new Gtk.Label("Welcome!"), false, false, 0);


    }
}

int main(string[] args) {
    Gtk.init(ref args);

    Gtk.Window win = new Gtk.Window();
    GreeterCanvas canvas = new GreeterCanvas();

    win.add(canvas);
    win.show_all();

    Gtk.main();

    return 0;
}