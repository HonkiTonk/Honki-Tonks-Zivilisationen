with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Window.Mouse;
with Sf.Window.Keyboard;

with KartenDatentypen;
with GrafikDatentypen;
with GrafikRecordKonstanten;
with GrafikKonstanten;

with NachLogiktask;
with NachGrafiktask;
with SichtweitenGrafik;
with InteraktionAllgemein;
with FensterGrafik;

package body TasteneingabeGrafik is

   procedure Tasteneingabe
   is
      use type Sf.sfBool;
      use type KartenDatentypen.Kartenfeld;
      use type GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum;
   begin
      
      -- Kann man sfMouseButtonCount einfach so als Leerwert nehmen? Scheint zu funktionieren.
      NachLogiktask.MausTaste := Sf.Window.Mouse.sfMouseButtonCount;
      NachLogiktask.TastaturTaste := Sf.Window.Keyboard.sfKeyUnknown;
      
      TasteSchleife:
      while
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => FensterGrafik.FensterLesen,
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
               InteraktionAllgemein.Mausposition := GrafikRecordKonstanten.FalschePosition;
               
            when Sf.Window.Event.sfEvtMouseEntered =>
               InteraktionAllgemein.Mausposition := (Float (Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => FensterGrafik.FensterLesen).x),
                                                     Float (Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => FensterGrafik.FensterLesen).y));
                  
            when Sf.Window.Event.sfEvtMouseMoved =>
               InteraktionAllgemein.Mausposition := (Float (Nutzereingabe.mouseMove.x), Float (Nutzereingabe.mouseMove.y));
               
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
                 NachGrafiktask.AktuelleDarstellung /= GrafikDatentypen.Grafik_Weltkarte_Enum
               then
                  null;
                  
               elsif
                 Nutzereingabe.mouseWheelScroll.eventDelta < GrafikKonstanten.Nullwert
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
      NachLogiktask.GrafikWarten := False;
      
   end Tasteneingabe;
   
   
   
   procedure FensterAnpassen
   is
      use type Sf.sfBool;
   begin
      
      AnpassenSchleife:
      while
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => FensterGrafik.FensterLesen,
                                                        event        => Fensteranpassung)
      loop
         
         case
           Fensteranpassung.eventType
         is
            when Sf.Window.Event.sfEvtClosed =>
               NachGrafiktask.FensterGeschlossen := True;
               return;
                  
            when Sf.Window.Event.sfEvtResized =>
               NachGrafiktask.FensterVerändert := GrafikDatentypen.Fenster_Verändert_Enum;
               
            when others =>
               null;
         end case;
         
      end loop AnpassenSchleife;
      
   end FensterAnpassen;

end TasteneingabeGrafik;
