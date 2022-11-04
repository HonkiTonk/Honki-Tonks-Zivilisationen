pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Window.Mouse;
with Sf.Window.Keyboard;

with KartenDatentypen; use KartenDatentypen;
with GrafikDatentypen;

with NachLogiktask;
with NachGrafiktask;
with EinstellungenGrafik;
with SichtweitenGrafik;

package body TasteneingabeGrafik is

   procedure Tasteneingabe
   is begin
      
      -- Kann man sfMouseButtonCount einfach so als Leerwert nehmen? Scheint zu funktionieren.
      NachLogiktask.MausTaste := Sf.Window.Mouse.sfMouseButtonCount;
      NachLogiktask.TastaturTaste := Sf.Window.Keyboard.sfKeyUnknown;
      
      TasteSchleife:
      while
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => EinstellungenGrafik.FensterAccess,
                                                        event        => Nutzereingabe)
      loop
         
         case
           Nutzereingabe.eventType
         is
            when Sf.Window.Event.sfEvtClosed =>
               NachGrafiktask.FensterGeschlossen := True;
               return;
                  
            when Sf.Window.Event.sfEvtResized =>
               NachGrafiktask.FensterVerändert := GrafikDatentypen.Fenster_Verändert_Enum;
               
            when Sf.Window.Event.sfEvtMouseLeft =>
               NachLogiktask.Mausposition := (-1.00, -1.00);
               
            when Sf.Window.Event.sfEvtMouseEntered =>
               NachLogiktask.Mausposition := (Float (Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => EinstellungenGrafik.FensterAccess).x),
                                              Float (Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => EinstellungenGrafik.FensterAccess).y));
                  
            when Sf.Window.Event.sfEvtMouseMoved =>
               NachLogiktask.Mausposition := (Float (Nutzereingabe.mouseMove.x), Float (Nutzereingabe.mouseMove.y));
               
            when others =>
               null;
         end case;
         
         -- Gäbe es einen Vorteil diesen Teil in jeweils eine eigene Prüfung umzuwandeln? Eventuell um mehrere Dinge gleichzeitig festlegen zu können?
         -- Beeinflusst das nicht auch die Auswertung in EingabeLogik? Hier einzeln durchgehen und dann in EingabeLogik die Auswertungsreihenfolge festlegen?
         case
           Nutzereingabe.eventType
         is
            when Sf.Window.Event.sfEvtKeyPressed =>
               NachLogiktask.TastaturTaste := Nutzereingabe.key.code;
                  
            when Sf.Window.Event.sfEvtMouseWheelScrolled =>
               if
                 Nutzereingabe.mouseWheelScroll.eventDelta < 0.00
               then
                  SichtweitenGrafik.ZoomstufeÄndern (ÄnderungExtern => 1);
                  
               else
                  SichtweitenGrafik.ZoomstufeÄndern (ÄnderungExtern => -1);
               end if;
                  
            when Sf.Window.Event.sfEvtMouseButtonPressed =>
               NachLogiktask.MausTaste := Nutzereingabe.mouseButton.button;
                  
            when others =>
               null;
         end case;
                     
      end loop TasteSchleife;
      
      NachGrafiktask.TastenEingabe := False;
      NachLogiktask.Warten := False;
      
   end Tasteneingabe;
   
   
   
   procedure FensterAnpassen
   is begin
      
      if
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => EinstellungenGrafik.FensterAccess,
                                                        event        => Fensteranpassung)
      then
         case
           Fensteranpassung.eventType
         is
            when Sf.Window.Event.sfEvtClosed =>
               NachGrafiktask.FensterGeschlossen := True;
                  
            when Sf.Window.Event.sfEvtResized =>
               NachGrafiktask.FensterVerändert := GrafikDatentypen.Fenster_Verändert_Enum;
               
            when others =>
               null;
         end case;
            
      else
         null;
      end if;
      
   end FensterAnpassen;

end TasteneingabeGrafik;
