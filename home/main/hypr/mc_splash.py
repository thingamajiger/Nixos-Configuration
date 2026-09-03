import gi
import time
import threading
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk
import gi.repository.GtkLayerShell as LayerShell

class Splash(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self)

        self.set_decorated(False)
        self.fullscreen()

        LayerShell.init_for_window(self)
        LayerShell.set_layer(self, LayerShell.Layer.TOP)
        LayerShell.set_keyboard_mode(self, LayerShell.KeyboardMode.NONE)

        overlay = Gtk.Overlay()
        self.add(overlay)

        # background (replace with your dirt image)
        bg = Gtk.Image.new_from_file("/home/tmajig/Pictures/minecraft_dirt.webp")
        overlay.add(bg)

        # center box
        self.box = Gtk.DrawingArea()
        self.box.set_size_request(40, 40)

        overlay.add_overlay(self.box)
        self.box.set_halign(Gtk.Align.CENTER)
        self.box.set_valign(Gtk.Align.CENTER)

        self.progress = 0
        self.box.connect("draw", self.draw_box)

        threading.Thread(target=self.animate).start()

    def draw_box(self, widget, cr):
        cr.set_source_rgb(0.2, 0.8, 0.2)  # green
        cr.rectangle(0, 0, 40 * self.progress, 40)
        cr.fill()

    def animate(self):
        for i in range(40):
            time.sleep(0.05)
            self.progress = i / 40
            Gtk.idle_add(self.box.queue_draw)
        time.sleep(0.5)
        Gtk.main_quit()

win = Splash()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
