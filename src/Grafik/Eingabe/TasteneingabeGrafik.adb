with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Window.Mouse;
with Sf.Window.Keyboard;

with KartenDatentypen;
with GrafikDatentypen;
with GrafikRecordKonstanten;
with GrafikKonstanten;
with InteraktionAuswahl;

with SchreibeLogiktask;
with SchreibeGrafiktask;
with LeseGrafiktask;

with SichtweitenGrafik;
with FensterGrafik;

package body TasteneingabeGrafik is

   procedure Tasteneingabe
   is
      use type Sf.sfBool;
      use type KartenDatentypen.Senkrechte;
      use type GrafikDatentypen.Aktuelle_Anzeige_Enum;
   begin
      
      -- Kann man sfMouseButtonCount einfach so als Leerwert nehmen? Scheint zu funktionieren.
      SchreibeLogiktask.Maustaste (TasteExtern => Sf.Window.Mouse.sfMouseButtonCount);
      SchreibeLogiktask.Tastaturtaste (TasteExtern => Sf.Window.Keyboard.sfKeyUnknown);
      
      TasteSchleife:
      while
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => FensterGrafik.FensterLesen,
                                                        event        => Nutzereingabe)
      loop
         
         case
           Nutzereingabe.eventType
         is
            when Sf.Window.Event.sfEvtClosed =>
               SchreibeGrafiktask.FensterEntfernen (JaNeinExtern => True);
               return;
                  
            when Sf.Window.Event.sfEvtResized =>
               SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Fenster_Verändert_Enum);
               
            when Sf.Window.Event.sfEvtMouseLeft =>
               InteraktionAuswahl.SchreibeGesamteMausposition (MauspositionExtern => GrafikRecordKonstanten.FalschePosition);
               
            when Sf.Window.Event.sfEvtMouseEntered =>
               InteraktionAuswahl.SchreibeGesamteMausposition (MauspositionExtern => (Float (Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => FensterGrafik.FensterLesen).x),
                                                                                      Float (Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => FensterGrafik.FensterLesen).y)));
                  
            when Sf.Window.Event.sfEvtMouseMoved =>
               InteraktionAuswahl.SchreibeGesamteMausposition (MauspositionExtern => (Float (Nutzereingabe.mouseMove.x), Float (Nutzereingabe.mouseMove.y)));
               
            when others =>
               null;
         end case;
         
         -- Gäbe es einen Vorteil diesen Teil in jeweils eine eigene Prüfung umzuwandeln? Eventuell um mehrere Dinge gleichzeitig festlegen zu können?
         -- Beeinflusst das nicht auch die Auswertung in EingabeLogik? Hier einzeln durchgehen und dann in EingabeLogik die Auswertungsreihenfolge festlegen?
         case
           Nutzereingabe.eventType
         is
            when Sf.Window.Event.sfEvtKeyPressed =>
               SchreibeLogiktask.Tastaturtaste (TasteExtern => Nutzereingabe.key.code);
                  
            when Sf.Window.Event.sfEvtMouseWheelScrolled =>
               if
                 LeseGrafiktask.Darstellung /= GrafikDatentypen.Weltkarte_Enum
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
               SchreibeLogiktask.Maustaste (TasteExtern => Nutzereingabe.mouseButton.button);
               
            when others =>
               null;
         end case;
                     
      end loop TasteSchleife;
      
      SchreibeGrafiktask.Tasteneingabe (JaNeinExtern => False);
      SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
      
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
               SchreibeGrafiktask.FensterEntfernen (JaNeinExtern => True);
               return;
                  
            when Sf.Window.Event.sfEvtResized =>
               SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Fenster_Verändert_Enum);
               
            when others =>
               null;
         end case;
         
      end loop AnpassenSchleife;
      
   end FensterAnpassen;

end TasteneingabeGrafik;
