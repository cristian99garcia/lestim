
[CCode (cprefix = "Wnck", lower_case_cprefix = "wnck_", gir_namespace = "Wnck", gir_version = "3.0")]
namespace Wnck {
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class ActionMenu : Gtk.Menu, Atk.Implementor, Gtk.Buildable {
		public Wnck.ActionMenuPrivate priv;
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public ActionMenu (Wnck.Window window);
		[NoAccessorMethod]
		public void* window { get; construct; }
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class Application : GLib.Object {
		public Wnck.ApplicationPrivate priv;
		public static unowned Wnck.Application @get (ulong xwindow);
		public unowned Gdk.Pixbuf get_icon ();
		public bool get_icon_is_fallback ();
		public unowned string get_icon_name ();
		public unowned Gdk.Pixbuf get_mini_icon ();
		public int get_n_windows ();
		public unowned string get_name ();
		public int get_pid ();
		public unowned string get_startup_id ();
		public unowned GLib.List<weak Wnck.Window> get_windows ();
		public ulong get_xid ();
		public virtual signal void icon_changed ();
		public virtual signal void name_changed ();
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class ClassGroup : GLib.Object {
		public Wnck.ClassGroupPrivate priv;
		public static unowned Wnck.ClassGroup @get (string res_class);
		public unowned Gdk.Pixbuf get_icon ();
		public unowned Gdk.Pixbuf get_mini_icon ();
		public unowned string get_name ();
		public unowned string get_res_class ();
		public unowned GLib.List<weak Wnck.Window> get_windows ();
		public virtual signal void icon_changed ();
		public virtual signal void name_changed ();
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class Pager : Gtk.Widget, Atk.Implementor, Gtk.Buildable {
		public Wnck.PagerPrivate priv;
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Pager ();
		public void set_display_mode (Wnck.PagerDisplayMode mode);
		public bool set_n_rows (int n_rows);
		public bool set_orientation (Gtk.Orientation orientation);
		public void set_shadow_type (Gtk.ShadowType shadow_type);
		public void set_show_all (bool show_all_workspaces);
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class Screen : GLib.Object {
		public Wnck.ScreenPrivate priv;
		public void calc_workspace_layout (int num_workspaces, int space_index, Wnck.WorkspaceLayout layout);
		public void change_workspace_count (int count);
		public void force_update ();
		public static void free_workspace_layout (Wnck.WorkspaceLayout layout);
		public static unowned Wnck.Screen @get (int index);
		public unowned Wnck.Window get_active_window ();
		public unowned Wnck.Workspace get_active_workspace ();
		public ulong get_background_pixmap ();
		public static unowned Wnck.Screen get_default ();
		public static unowned Wnck.Screen get_for_root (ulong root_window_id);
		public int get_height ();
		public int get_number ();
		public unowned Wnck.Window get_previously_active_window ();
		public bool get_showing_desktop ();
		public int get_width ();
		public unowned string get_window_manager_name ();
		public unowned GLib.List<weak Wnck.Window> get_windows ();
		public unowned GLib.List<weak Wnck.Window> get_windows_stacked ();
		public unowned Wnck.Workspace get_workspace (int workspace);
		public int get_workspace_count ();
		public unowned GLib.List<weak Wnck.Workspace> get_workspaces ();
		public void move_viewport (int x, int y);
		public bool net_wm_supports (string atom);
		public void release_workspace_layout (int current_token);
		public void toggle_showing_desktop (bool show);
		public int try_set_workspace_layout (int current_token, int rows, int columns);
		public virtual signal void active_window_changed (Wnck.Window screen);
		public virtual signal void active_workspace_changed (Wnck.Workspace screen);
		public virtual signal void application_closed (Wnck.Application screen);
		public virtual signal void application_opened (Wnck.Application screen);
		public virtual signal void background_changed ();
		public virtual signal void class_group_closed (Wnck.ClassGroup screen);
		public virtual signal void class_group_opened (Wnck.ClassGroup screen);
		public virtual signal void showing_desktop_changed ();
		public virtual signal void viewports_changed ();
		public virtual signal void window_closed (Wnck.Window screen);
		public virtual signal void window_manager_changed ();
		public virtual signal void window_opened (Wnck.Window screen);
		public virtual signal void window_stacking_changed ();
		public virtual signal void workspace_created (Wnck.Workspace screen);
		public virtual signal void workspace_destroyed (Wnck.Workspace screen);
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class Selector : Gtk.MenuBar, Atk.Implementor, Gtk.Buildable {
		public Wnck.SelectorPrivate priv;
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Selector ();
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class Tasklist : Gtk.Container, Atk.Implementor, Gtk.Buildable {
		public Wnck.TasklistPrivate priv;
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Tasklist ();
		public int get_size_hint_list (int n_elements);
		public void set_button_relief (Gtk.ReliefStyle relief);
		public void set_grouping (Wnck.TasklistGroupingType grouping);
		public void set_grouping_limit (int limit);
		public void set_include_all_workspaces (bool include_all_workspaces);
		public void set_switch_workspace_on_unminimize (bool switch_workspace_on_unminimize);
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class Window : GLib.Object {
		public Wnck.WindowPrivate priv;
		public void activate (uint32 timestamp);
		public void activate_transient (uint32 timestamp);
		public void close (uint32 timestamp);
		public static unowned Wnck.Window @get (ulong xwindow);
		public Wnck.WindowActions get_actions ();
		public unowned Wnck.Application get_application ();
		public unowned Wnck.ClassGroup get_class_group ();
		public void get_client_window_geometry (int xp, int yp, int widthp, int heightp);
		public void get_geometry (int xp, int yp, int widthp, int heightp);
		public ulong get_group_leader ();
		public unowned Gdk.Pixbuf get_icon ();
		public bool get_icon_is_fallback ();
		public unowned string get_icon_name ();
		public unowned Gdk.Pixbuf get_mini_icon ();
		public unowned string get_name ();
		public int get_pid ();
		public unowned Wnck.Screen get_screen ();
		public unowned string get_session_id ();
		public unowned string get_session_id_utf8 ();
		public int get_sort_order ();
		public Wnck.WindowState get_state ();
		public unowned Wnck.Window get_transient ();
		public Wnck.WindowType get_window_type ();
		public unowned Wnck.Workspace get_workspace ();
		public ulong get_xid ();
		public bool has_icon_name ();
		public bool has_name ();
		public bool is_above ();
		public bool is_active ();
		public bool is_below ();
		public bool is_fullscreen ();
		public bool is_in_viewport (Wnck.Workspace workspace);
		public bool is_maximized ();
		public bool is_maximized_horizontally ();
		public bool is_maximized_vertically ();
		public bool is_minimized ();
		public bool is_most_recently_activated ();
		public bool is_on_workspace (Wnck.Workspace workspace);
		public bool is_pinned ();
		public bool is_shaded ();
		public bool is_skip_pager ();
		public bool is_skip_tasklist ();
		public bool is_sticky ();
		public bool is_visible_on_workspace (Wnck.Workspace workspace);
		public void keyboard_move ();
		public void keyboard_size ();
		public void make_above ();
		public void make_below ();
		public void maximize ();
		public void maximize_horizontally ();
		public void maximize_vertically ();
		public void minimize ();
		public void move_to_workspace (Wnck.Workspace space);
		public bool needs_attention ();
		public bool or_transient_needs_attention ();
		public void pin ();
		public void set_fullscreen (bool fullscreen);
		public void set_geometry (Wnck.WindowGravity gravity, Wnck.WindowMoveResizeMask geometry_mask, int x, int y, int width, int height);
		public void set_icon_geometry (int x, int y, int width, int height);
		public void set_skip_pager (bool skip);
		public void set_skip_tasklist (bool skip);
		public void set_sort_order (int order);
		public void set_window_type (Wnck.WindowType wintype);
		public void shade ();
		public void stick ();
		public bool transient_is_most_recently_activated ();
		public void unmake_above ();
		public void unmake_below ();
		public void unmaximize ();
		public void unmaximize_horizontally ();
		public void unmaximize_vertically ();
		public void unminimize (uint32 timestamp);
		public void unpin ();
		public void unshade ();
		public void unstick ();
		public virtual signal void actions_changed (Wnck.WindowActions window, Wnck.WindowActions changed_mask);
		public virtual signal void geometry_changed ();
		public virtual signal void icon_changed ();
		public virtual signal void name_changed ();
		public virtual signal void state_changed (Wnck.WindowState window, Wnck.WindowState changed_mask);
		public virtual signal void workspace_changed ();
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public class Workspace : GLib.Object {
		public Wnck.WorkspacePrivate priv;
		public void activate (uint32 timestamp);
		public void change_name (string name);
		public int get_height ();
		public int get_layout_column ();
		public int get_layout_row ();
		public unowned string get_name ();
		public unowned Wnck.Workspace get_neighbor (Wnck.MotionDirection direction);
		public int get_number ();
		public unowned Wnck.Screen get_screen ();
		public int get_viewport_x ();
		public int get_viewport_y ();
		public int get_width ();
		public bool is_virtual ();
		public virtual signal void name_changed ();
	}
	[CCode (type_id = "WNCK_TYPE_ACTION_MENU_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct ActionMenuPrivate {
	}
	[CCode (type_id = "WNCK_TYPE_APPLICATION_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct ApplicationPrivate {
	}
	[CCode (type_id = "WNCK_TYPE_CLASS_GROUP_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct ClassGroupPrivate {
	}
	[CCode (type_id = "WNCK_TYPE_PAGER_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct PagerPrivate {
	}
	[CCode (type_id = "WNCK_TYPE_RESOURCE_USAGE", cheader_filename = "libwnck/libwnck.h")]
	public struct ResourceUsage {
		public ulong total_bytes_estimate;
		public ulong pixmap_bytes;
		public uint n_pixmaps;
		public uint n_windows;
		public uint n_gcs;
		public uint n_pictures;
		public uint n_glyphsets;
		public uint n_fonts;
		public uint n_colormap_entries;
		public uint n_passive_grabs;
		public uint n_cursors;
		public uint n_other;
		public uint pad1;
		public uint pad2;
		public uint pad3;
		public uint pad4;
		public uint pad5;
		public uint pad6;
		public uint pad7;
		public uint pad8;
		public uint pad9;
	}
	[CCode (type_id = "WNCK_TYPE_SCREEN_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct ScreenPrivate {
	}
	[CCode (type_id = "WNCK_TYPE_SELECTOR_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct SelectorPrivate {
	}
	[CCode (type_id = "WNCK_TYPE_TASKLIST_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct TasklistPrivate {
	}
	[CCode (type_id = "WNCK_TYPE_WINDOW_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct WindowPrivate {
	}
	[CCode (type_id = "WNCK_TYPE_WORKSPACE_LAYOUT", cheader_filename = "libwnck/libwnck.h")]
	public struct WorkspaceLayout {
		public int rows;
		public int cols;
		public int grid;
		public int grid_area;
		public int current_row;
		public int current_col;
	}
	[CCode (type_id = "WNCK_TYPE_WORKSPACE_PRIVATE", cheader_filename = "libwnck/libwnck.h")]
	public struct WorkspacePrivate {
	}
	[CCode (cprefix = "WNCK_CLIENT_TYPE_", cheader_filename = "libwnck/libwnck.h")]
	public enum ClientType {
		APPLICATION,
		PAGER
	}
	[CCode (cprefix = "WNCK_MOTION_", cheader_filename = "libwnck/libwnck.h")]
	public enum MotionDirection {
		UP,
		DOWN,
		LEFT,
		RIGHT
	}
	[CCode (cprefix = "WNCK_PAGER_DISPLAY_", cheader_filename = "libwnck/libwnck.h")]
	public enum PagerDisplayMode {
		NAME,
		CONTENT
	}
	[CCode (cprefix = "WNCK_TASKLIST_", cheader_filename = "libwnck/libwnck.h")]
	public enum TasklistGroupingType {
		NEVER_GROUP,
		AUTO_GROUP,
		ALWAYS_GROUP
	}
	[CCode (cprefix = "WNCK_WINDOW_ACTIONS_", cheader_filename = "libwnck/libwnck.h")]
	public enum WindowActions {
		[CCode (cname = "WNCK_WINDOW_ACTION_MOVE")]
		MOVE,
		[CCode (cname = "WNCK_WINDOW_ACTION_RESIZE")]
		RESIZE,
		[CCode (cname = "WNCK_WINDOW_ACTION_SHADE")]
		SHADE,
		[CCode (cname = "WNCK_WINDOW_ACTION_STICK")]
		STICK,
		[CCode (cname = "WNCK_WINDOW_ACTION_MAXIMIZE_HORIZONTALLY")]
		MAXIMIZE_HORIZONTALLY,
		[CCode (cname = "WNCK_WINDOW_ACTION_MAXIMIZE_VERTICALLY")]
		MAXIMIZE_VERTICALLY,
		[CCode (cname = "WNCK_WINDOW_ACTION_CHANGE_WORKSPACE")]
		CHANGE_WORKSPACE,
		[CCode (cname = "WNCK_WINDOW_ACTION_CLOSE")]
		CLOSE,
		[CCode (cname = "WNCK_WINDOW_ACTION_UNMAXIMIZE_HORIZONTALLY")]
		UNMAXIMIZE_HORIZONTALLY,
		[CCode (cname = "WNCK_WINDOW_ACTION_UNMAXIMIZE_VERTICALLY")]
		UNMAXIMIZE_VERTICALLY,
		[CCode (cname = "WNCK_WINDOW_ACTION_UNSHADE")]
		UNSHADE,
		[CCode (cname = "WNCK_WINDOW_ACTION_UNSTICK")]
		UNSTICK,
		[CCode (cname = "WNCK_WINDOW_ACTION_MINIMIZE")]
		MINIMIZE,
		[CCode (cname = "WNCK_WINDOW_ACTION_UNMINIMIZE")]
		UNMINIMIZE,
		[CCode (cname = "WNCK_WINDOW_ACTION_MAXIMIZE")]
		MAXIMIZE,
		[CCode (cname = "WNCK_WINDOW_ACTION_UNMAXIMIZE")]
		UNMAXIMIZE,
		[CCode (cname = "WNCK_WINDOW_ACTION_FULLSCREEN")]
		FULLSCREEN,
		[CCode (cname = "WNCK_WINDOW_ACTION_ABOVE")]
		ABOVE,
		[CCode (cname = "WNCK_WINDOW_ACTION_BELOW")]
		BELOW
	}
	[CCode (cprefix = "WNCK_WINDOW_GRAVITY_", cheader_filename = "libwnck/libwnck.h")]
	public enum WindowGravity {
		CURRENT,
		NORTHWEST,
		NORTH,
		NORTHEAST,
		WEST,
		CENTER,
		EAST,
		SOUTHWEST,
		SOUTH,
		SOUTHEAST,
		STATIC
	}
	[CCode (cprefix = "WNCK_WINDOW_MOVE_RESIZE_MASK_", cheader_filename = "libwnck/libwnck.h")]
	public enum WindowMoveResizeMask {
		[CCode (cname = "WNCK_WINDOW_CHANGE_X")]
		X,
		[CCode (cname = "WNCK_WINDOW_CHANGE_Y")]
		Y,
		[CCode (cname = "WNCK_WINDOW_CHANGE_WIDTH")]
		WIDTH,
		[CCode (cname = "WNCK_WINDOW_CHANGE_HEIGHT")]
		HEIGHT
	}
	[CCode (cprefix = "WNCK_WINDOW_STATE_", cheader_filename = "libwnck/libwnck.h")]
	public enum WindowState {
		MINIMIZED,
		MAXIMIZED_HORIZONTALLY,
		MAXIMIZED_VERTICALLY,
		SHADED,
		SKIP_PAGER,
		SKIP_TASKLIST,
		STICKY,
		HIDDEN,
		FULLSCREEN,
		DEMANDS_ATTENTION,
		URGENT,
		ABOVE,
		BELOW
	}
	[CCode (cprefix = "WNCK_WINDOW_", cheader_filename = "libwnck/libwnck.h")]
	public enum WindowType {
		NORMAL,
		DESKTOP,
		DOCK,
		DIALOG,
		TOOLBAR,
		MENU,
		UTILITY,
		SPLASHSCREEN
	}
	[CCode (cprefix = "WNCK_LAYOUT_CORNER_", cheader_filename = "libwnck/libwnck.h")]
	public enum _LayoutCorner {
		TOPLEFT,
		TOPRIGHT,
		BOTTOMRIGHT,
		BOTTOMLEFT
	}
	[CCode (cprefix = "WNCK_LAYOUT_ORIENTATION_", cheader_filename = "libwnck/libwnck.h")]
	public enum _LayoutOrientation {
		HORIZONTAL,
		VERTICAL
	}
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public const int MAJOR_VERSION;
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public const int MICRO_VERSION;
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public const int MINOR_VERSION;
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public static void pid_read_resource_usage (Gdk.Display gdk_display, ulong pid, Wnck.ResourceUsage usage);
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public static void set_client_type (Wnck.ClientType ewmh_sourceindication_client_type);
	[CCode (cheader_filename = "libwnck/libwnck.h")]
	public static void xid_read_resource_usage (Gdk.Display gdk_display, ulong xid, Wnck.ResourceUsage usage);
}
