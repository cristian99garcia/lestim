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


public class LestimWindow: Gtk.ApplicationWindow {

    //bool panel_orientation;
    //bool panel_autohide;
    //bool panel_expand;
    //bool panel_space_reserved;

    public LestimWindow() {
        set_title("Lestim");
        set_type_hint(Gdk.WindowTypeHint.DESKTOP);
        set_size_request(DISPLAY_WIDTH, DISPLAY_HEIGHT);
        move(0, 0);
    }
}
