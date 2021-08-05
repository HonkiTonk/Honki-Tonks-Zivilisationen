with Sf.Window, Sf.Window.Window, Sf.Window.VideoMode, Sf.Window.Cursor, Sf, Sf.Window.Event, Sf.Window.Keyboard, Sf.Graphics.Texture;
use Sf.Window, Sf.Window.Window, Sf.Window.VideoMode, Sf.Window.Cursor, Sf, Sf.Window.Event, Sf.Window.Keyboard, Sf.Graphics.Texture;
use Sf.Graphics;
with Sf.Graphics.Sprite; use Sf.Graphics.Sprite;

with Sf.Graphics.RenderWindow; use Sf.Graphics.RenderWindow;
with Sf.Graphics.Color; use Sf.Graphics, Sf.Graphics.Color;





Fenster : sfRenderWindow_Ptr;
Modus : constant sfVideoMode := (640, 480, 32);
EventDing : aliased sfEvent;
CursorDing : constant sfCursor_Ptr := Cursor.createFromSystem (Cursor.sfCursorHand);
Textur : sfTexture_Ptr;
Sprit : sfSprite_Ptr;



Fenster := create (Modus, Ada.Characters.Conversions.To_String (To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (1, 1))), sfResize or sfClose, sfDefaultContextSettings);
Textur := createFromFile ("Bilder/107_Igel.jpg", null);
Sprit := create;
setTexture (Sprit, Textur, sfTrue);
setMouseCursor (Fenster, CursorDing);
setFramerateLimit (Fenster, 30);
setVerticalSyncEnabled (Fenster, sfTrue);

while isOpen (Fenster) = True loop
   while pollEvent (Fenster, EventDing) = sfTrue loop

      if
        EventDing.eventType = sfEvtKeyPressed
      then
         if
           EventDing.key.code = sfKeyEscape
         then
            close (Fenster);

         elsif
           EventDing.key.code = sfKeyUp
         then
            -- setTitle := (Fenster, "AAAÄÄÄ???ßßßccc");
            null;

         else
            null;
         end if;

      else
         null;
      end if;

   end loop;

   clear (Fenster, sfBlack);
   drawSprite (Fenster, Sprit, null);
   display (Fenster);

end loop;
destroy (Fenster);



package Notizen is

   -- Wenn man das in die KartePositionPruefen einbaut erhält man einen Tugel, später als alternatives Planetenmodell einbauen?
      
      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2)
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
                      
         ÜberhangYAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseKleinerSchleife:
         while ÜberhangYAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (2)) loop
                                                                  
            ÜberhangYAchse (KoordinatenExtern.EAchse) := ÜberhangYAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);

         end loop YAchseKleinerSchleife;
         return (0, GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (KoordinatenExtern.EAchse)), PolXAchse (KoordinatenExtern.EAchse));
               
      elsif
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
         
         ÜberhangYAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseGrößerSchleife:
         while ÜberhangYAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) loop
            
            ÜberhangYAchse (KoordinatenExtern.EAchse) := ÜberhangYAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
            
         end loop YAchseGrößerSchleife;
         return (0, GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (KoordinatenExtern.EAchse)), PolXAchse (KoordinatenExtern.EAchse));
               
      else
         return (0, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse);
      end if;
      
   -- Wenn man das in die KartePositionPruefen einbaut erhält man einen Torus, später als alternatives Planetenmodell einbauen?

end Notizen;
