#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import time
import cairo
import alsaaudio
import ConfigParser
import Globals as G

from gi.repository import Gtk
from gi.repository import Gdk
from gi.repository import GdkPixbuf
from gi.repository import GObject
from gi.repository import Gio

icon_theme = Gtk.IconTheme()
icons = icon_theme.list_icons(None)


class Area(Gtk.IconView):

    __gtype_name__ = 'DesktopArea'

    def __init__(self):

        Gtk.IconView.__init__(self)

        self.modelo = Gtk.ListStore(str, GdkPixbuf.Pixbuf)

        self.set_selection_mode(Gtk.SelectionMode.MULTIPLE)
        self.set_model(self.modelo)
        self.set_text_column(0)
        self.set_pixbuf_column(1)
        self.set_item_orientation(Gtk.Orientation.VERTICAL)
        #self.set_item_width(100)
        #self.set_margin(0)
        #self.set_item_padding(0)
        self.set_reorderable(True)
        #self.set_columns(2)

        self.connect('button-press-event', self.clic)

    def clic(self, widget, event):

        def abrir_archivo(aplicacion):

            direccion = os.path.join(self.direccion, aplicacion)

            if not direccion.endswith('.desktop'):
                if ' ' in direccion:
                    direccion = direccion.replace(' ', '\ ')

                os.system('xdg-open %s' % direccion)

            else:
                cfg = ConfigParser.ConfigParser()
                cfg.read([direccion])

                if cfg.has_option('Desktop Entry', 'Exec'):
                    os.system(cfg.has_option('Desktop Entry', 'Exec'))

        boton = event.button
        posx = event.x
        posy = event.y

        if event.type.value_name == 'GDK_2BUTTON_PRESS' and boton == 1:

            try:
                path = self.get_path_at_pos(int(posx), int(posy))
                iter = self.modelo.get_iter(path)

                abrir_archivo(self.modelo.get_value(iter, 0))

            except TypeError:
                pass

    def agregar_icono(self, lista):

        directorios = []
        archivos = []

        for x in lista:
            if os.path.isdir(x):
                directorios.append(x)

            elif os.path.isfile(x):
                archivos.append(x)

        directorios.sort()
        archivos.sort()

        for x in directorios:
            self.insertar_iter(x)

        for x in archivos:
            self.insertar_iter(x)

    def insertar_iter(self, direccion):

        nombre = direccion.split('/')[-1]
        icono = G.get_icon(direccion)

        if nombre.endswith('.desktop'):
            cfg = ConfigParser.ConfigParser()
            cfg.read([direccion])

            if cfg.has_option('Desktop Entry', 'Name'):
                nombre = cfg.get('Desktop Entry', 'Name')

        iter = self.modelo.append([nombre, icono])
        path = self.modelo.get_path(iter)
        #tooltip = Gtk.Tooltip()

        #tooltip.set_text(direccion)
        #tooltip.set_icon(icono)
        #self.set_tooltip_item(tooltip, path)

        self.show_all()

    def limpiar(self):

        self.modelo.clear()

    def set_direccion(self, direccion):

        self.direccion = direccion


class Panel(Gtk.Box):

    __gsignals__ = {
        'action': (GObject.SIGNAL_RUN_FIRST, None, (str,))
            }

    def __init__(self, orientacion=Gtk.Orientation.HORIZONTAL):

        Gtk.Box.__init__(self, orientation=orientacion)

        self.boton_aplicaciones = ApplicationsButton()
        self.boton_calendario = CalendarButton()
        self.boton_usuario = UserButton()
        menu = self.boton_usuario.get_menu()
        separador1 = Gtk.SeparatorToolItem()
        separador2 = Gtk.SeparatorToolItem()

        separador1.set_expand(True)
        separador2.set_expand(True)
        separador1.set_draw(False)
        separador2.set_draw(False)

        menu.connect('action', lambda w, x: self.emit('action', x))

        self.pack_start(self.boton_aplicaciones, False, False, 0)
        self.pack_start(separador1, True, True, 0)
        self.pack_start(self.boton_calendario, False, False, 0)
        self.pack_start(separador2, True, True, 0)
        self.pack_end(self.boton_usuario, False, False, 0)

    def get_applications_menu(self):

        return self.boton_aplicaciones.get_applications_menu()

    def emitir(self, widget):

        self.emit('action', widget.get_label())


class ApplicationsMenu(Gtk.HBox):

    __gsignals__ = {
        'open-application': (GObject.SIGNAL_RUN_FIRST, None, [str, str])
            }

    def __init__(self):

        Gtk.HBox.__init__(self)

        self.listbox = Gtk.ListBox()
        self.area = Gtk.IconView()
        self.entrada = Gtk.Entry()
        self.buttonbox = Gtk.HBox()
        self.modelo = Gtk.ListStore(str, GdkPixbuf.Pixbuf)
        self.programas = {}
        self.iters = {}

        self.set_apps()
        self.area.set_selection_mode(Gtk.SelectionMode.NONE)
        self.area.set_model(self.modelo)
        self.area.set_text_column(0)
        self.area.set_pixbuf_column(1)
        self.area.set_columns(3)
        self.entrada.set_size_request(400, -1)

        vbox = Gtk.VBox()
        _hbox = Gtk.HBox()
        scrolled1 = Gtk.ScrolledWindow()
        scrolled2 = Gtk.ScrolledWindow()

        scrolled1.set_size_request(675, 400)
        scrolled1.set_can_focus(False)
        scrolled2.set_size_request(200, -1)
        scrolled2.set_can_focus(False)

        for x in self.categorias:
            row = Gtk.ListBoxRow()
            hbox = Gtk.HBox()

            hbox.pack_start(Gtk.Label(x), False, False, 0)
            row.add(hbox)
            self.listbox.add(row)

        self.listbox.connect('row-activated', self.category_changed)
        self.area.connect('button-press-event', self.click)
        self.entrada.connect('changed', self.app_search)
        self.entrada.connect('activate', self.app_search)

        scrolled1.add(self.area)
        scrolled2.add(self.listbox)
        _hbox.pack_end(self.entrada, False, False, 10)
        vbox.pack_start(_hbox, False, False, 2)
        vbox.pack_start(scrolled1, True, True, 0)
        vbox.pack_end(self.buttonbox, False, False, 0)
        self.pack_start(scrolled2, False, False, 5)
        self.pack_start(vbox, True, True, 0)

        self.show_applications(self.categorias[0])

    def app_exec(self, aplicacion):

        os.system(aplicacion['ejecutar'])

    def click(self, widget, event):

        boton = event.button
        posx = event.x
        posy = event.y

        try:
            path = self.area.get_path_at_pos(int(posx), int(posy))
            iter = self.modelo.get_iter(path)
            aplicacion = self.iters[self.modelo.get_value(iter, 0)]

            if boton == 1:
                self.app_exec(aplicacion)

        except TypeError:
            pass

    def set_apps(self):

        self.modelo.clear()
        self.programas = G.get_applications()
        self.categorias = self.programas.keys()

    def show_applications(self, categoria, apps=None):

        numero = 0
        index = 0
        iters = {}
        self.modelo.clear()

        if apps is None:
            if categoria in self.programas.keys():
                for x in self.programas[categoria]:
                    index += 1 if numero % 12 == 0 else 0
                    numero += 1

                    if not index in iters.keys():
                        iters[index] = []

                    iters[index].append(x)
                    iters[index].sort()

        else:
            for x in apps:
                index += 1 if numero % 12 == 0 else 0
                numero += 1

                if not index in iters.keys():
                    iters[index] = []

                iters[index].append(x)
                iters[index].sort()

        self.app_switch(None, iters, 1)
        self.set_buttons(numero, iters)

    def category_changed(self, widget, row):

        categoria = row.get_children()[0].get_children()[0].get_label()
        self.show_applications(categoria)

    def app_search(self, widget):

        resultados = []

        for categoria in self.programas.keys():
            for programa in self.programas[categoria]:
                if type(programa) == dict:
                    texto = G.clear_string(widget.get_text())
                    app = G.clear_string(programa['nombre'])

                    if texto in app:
                        resultados.append(programa)

        self.show_applications(None, resultados)

    def app_switch(self, widget, iters, index=None):

        if index is None:
            index = widget.index

        self.modelo.clear()
        self.iters = {}

        if index in iters.keys():
            for x in iters[index]:
                iter = self.modelo.append([x['nombre'], x['icono']])
                self.iters[x['nombre']] = x

    def set_buttons(self, numero=0, iters={}):

        while self.buttonbox.get_children():
            self.buttonbox.remove(self.buttonbox.get_children()[0])

        s1 = Gtk.HSeparator()
        s2 = Gtk.HSeparator()

        s1.set_hexpand(True)
        s2.set_hexpand(True)

        self.buttonbox.pack_start(s1, True, True, 0)
        self.buttonbox.pack_end(s2, True, True, 0)

        cantidad = numero / 12 if numero % 12 > 0 else 0
        _boton = Gtk.RadioButton.new_from_widget(None)
        _boton.index = 1
        _boton.connect('toggled', self.app_switch, iters)
        _boton.set_hexpand(False)

        self.buttonbox.pack_start(_boton, False, False, 0)

        for x in range(1, cantidad + 1):
            boton = Gtk.RadioButton.new_from_widget(_boton)
            boton.index = x+1

            boton.set_hexpand(False)

            boton.connect('toggled', self.app_switch, iters)
            self.buttonbox.pack_start(boton, False, False, 0)

        self.buttonbox.show_all()


class ApplicationsButton(Gtk.ScaleButton):

    def __init__(self):

        Gtk.ScaleButton.__init__(self)

        self.set_relief(Gtk.ReliefStyle.NONE)
        self.hack()

    def hack(self):

        self.label = Gtk.Label('Aplicaciones')
        self.aplicaciones = ApplicationsMenu()

        self.aplicaciones.connect('open-application', self.close_menu)

        self.remove(self.get_children()[0])
        self.add(self.label)

        win = self.get_popup()
        frame = win.get_children()[0]
        _vbox = frame.get_children()[0]
        vbox = Gtk.VBox()

        vbox.add(self.aplicaciones)
        frame.remove(_vbox)
        frame.add(vbox)

        self.show_all()

    def get_applications_menu(self):

        return self.aplicaciones

    def close_menu(self, *args):

        self.get_popup().hide()


class UserMenu(Gtk.ListBox):

    __gsignals__ = {
        'action': (GObject.SIGNAL_RUN_FIRST, None, [str])
            }

    def __init__(self):

        Gtk.ListBox.__init__(self)

        self.mixer = alsaaudio.Mixer()

        self.set_selection_mode(Gtk.SelectionMode.NONE)

        _hbox = self.create_row()
        hbox = Gtk.HBox()
        expander = Gtk.Expander()

        expander.set_label('Wi-Fi')

        hbox.add(Gtk.Label(G.get_ip()))
        expander.add(hbox)
        _hbox.add(expander)

        hbox = self.create_row()
        volumebutton = Gtk.VolumeButton()
        adj = Gtk.Adjustment(int(self.mixer.getvolume()[0]), 25, 100, 1, 10, 0)
        scale = Gtk.HScale(adjustment=adj)

        volumebutton.set_sensitive(False)
        volumebutton.set_opacity(1)
        volumebutton.set_value(scale.get_value() / 100)
        scale.set_show_fill_level(True)
        scale.set_draw_value(False)

        scale.connect('value-changed', self.set_value, volumebutton)

        hbox.pack_start(volumebutton, False, False, 0)
        hbox.pack_start(scale, True, True, 0)

        box = self.create_row(Gtk.ButtonBox())
        boton_confi = Gtk.Button(stock=Gtk.STOCK_PREFERENCES)
        boton_cerrar = Gtk.Button('Salir')

        box.set_layout(Gtk.ButtonBoxStyle.CENTER)
        box.set_spacing(20)

        boton_confi.connect('clicked', lambda widget: self.emit('action', 'Configuraciones'))
        boton_cerrar.connect('clicked', lambda widget: self.emit('action', 'Cerrar'))

        box.add(boton_confi)
        box.add(boton_cerrar)

    def set_value(self, widget, button):

        button.set_value(widget.get_value() / 100)
        self.mixer.setvolume(int(button.get_value() * 100))

    def create_row(self, widget=None):

        # No se puede establecer la variable widget directamente como una HBox
        # porque sino, cada vez que se llame a la función, se tomará en cuenta
        # a la misma HBox, y esto no permite el normal empaquetamiento

        if not widget:
            widget = Gtk.HBox()

        row = Gtk.ListBoxRow()

        row.add(widget)
        self.add(row)

        return widget


class UserButton(Gtk.ScaleButton):

    def __init__(self):

        Gtk.ScaleButton.__init__(self)

        self.set_relief(Gtk.ReliefStyle.NONE)
        self.hack()

    def hack(self):

        self.label = Gtk.Label(os.getlogin())
        self.menu = UserMenu()
        scrolled = Gtk.ScrolledWindow()

        scrolled.set_size_request(400, 500)

        self.remove(self.get_children()[0])
        self.add(self.label)

        win = self.get_popup()
        frame = win.get_children()[0]
        _vbox = frame.get_children()[0]
        vbox = Gtk.VBox()

        scrolled.add(self.menu)
        vbox.add(scrolled)
        frame.remove(_vbox)
        frame.add(vbox)

        self.show_all()

    def get_menu(self):

        return self.menu


class CalendarButton(Gtk.ScaleButton):

    def __init__(self):

        Gtk.ScaleButton.__init__(self)

        self.hack()
        self.set_time()
        GObject.timeout_add(1000, self.set_time, ())

    def hack(self):

        self.label = Gtk.Label()

        self.remove(self.get_children()[0])
        self.add(self.label)

        win = self.get_popup()
        frame = win.get_children()[0]
        _vbox = frame.get_children()[0]
        vbox = Gtk.VBox()

        vbox.add(Gtk.Calendar())
        frame.remove(_vbox)
        frame.add(vbox)

    def set_time(self, *args):

        actual = time.asctime()

        if actual:
            dia = actual.split(' ')[0]
            mes = actual.split(' ')[1]
            fecha = actual.split(' ')[2]
            hora = actual.split(' ')[3]
            anyo = actual.split(' ')[4]

            dias = {
                'Sun': 'Dom',
                'Mon': 'Lun',
                'Tue': 'Mar',
                'Wed': 'Mié',
                'Thu': 'Jue',
                'Fri': 'Vie',
                'Sat': 'Sáb',
            }

            meses = {
                'Jan': 'Ene',
                'Feb': 'Feb',
                'Mar': 'Mar',
                'Apr': 'Abr',
                'May': 'May',
                'Jun': 'Jun',
                'Jul': 'Jul',
                'Aug': 'Ago',
                'Sep': 'Sep',
                'Nov': 'Nov',
                'Dec': 'Dic',
            }

            texto = hora + '  ' + dias[dia] + ', ' + fecha + ' de ' + meses[mes] + ' del ' + anyo
            self.label.set_text(texto)

        return True