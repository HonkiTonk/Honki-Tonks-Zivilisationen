pragma SPARK_Mode (On);

with Sf.Window, Sf.Window.VideoMode, Sf.Window.Cursor, Sf.Window.Window;
use Sf.Window;

with Spielstart;

procedure Start
is

   Fenster : Sf.Window.sfWindow_Ptr;
   Modus : constant Sf.Window.VideoMode.sfVideoMode := (640, 480, 32);
   Zeiger : constant Sf.Window.sfCursor_Ptr := Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorHand);

begin

   Fenster := Sf.Window.Window.create (mode  => Modus,
                                       title => "Test");

   if
     Fenster = null
   then
      return;

   else
      Sf.Window.Window.setMouseCursor (window => Fenster,
                                       cursor => Zeiger);
      Sf.Window.Window.setFramerateLimit (window => Fenster,
                                          limit  => 30);
   end if;

   Spielstart.Spielstart;

   Sf.Window.Window.destroy (window => Fenster);

end Start;
