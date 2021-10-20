pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;

package body EingabeSFML is
   
   procedure TastenEingabe
   is begin
      
      -- Werden diese Leerwerte gebraucht?
      TastaturTaste := Sf.Window.Keyboard.sfKeyUnknown;
      MausTaste := Sf.Window.Mouse.sfMouseXButton2;
      
      EingabeSchleife:
      loop
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => ZeichenEingeben)
           = Sf.sfTrue loop
            
            case
              ZeichenEingeben.eventType
            is
               when Sf.Window.Event.sfEvtKeyPressed =>
                  TastaturTaste := ZeichenEingeben.key.code;
                  return;
                  
               when Sf.Window.Event.sfEvtMouseButtonPressed =>
                  MausTaste := ZeichenEingeben.mouseButton.button;
                  return;
               
               when others =>
                  null;
            end case;
         
         end loop TasteSchleife;
      end loop EingabeSchleife;
      
   end TastenEingabe;
   
   
   
   procedure TastenEingabeErweitert
   is begin
      
      -- Werden diese Leerwerte gebraucht?
      MausAmRand := SystemDatentypen.Leer;
      TastaturTaste := Sf.Window.Keyboard.sfKeyUnknown;
      
      EingabeSchleife:
      loop
         
         MausAmRand := MausScrollen;
         
         case
           MausAmRand
         is
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               return;
         end case;
         
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => ZeichenEingeben)
           = Sf.sfTrue loop
            
            case
              ZeichenEingeben.eventType
            is
               when Sf.Window.Event.sfEvtKeyPressed =>
                  TastaturTaste := ZeichenEingeben.key.code;
                  return;
                  
               when Sf.Window.Event.sfEvtMouseButtonPressed =>
                  MausTaste := ZeichenEingeben.mouseButton.button;
                  return;
                  
               when Sf.Window.Event.sfEvtMouseWheelScrolled =>
                  null;
                  
               when others =>
                  null;
            end case;
         
         end loop TasteSchleife;
      end loop EingabeSchleife;
      
   end TastenEingabeErweitert;
   
   

   function MausScrollen
     return SystemDatentypen.Tastenbelegung_Enum
   is begin
      
      MausZeigerPosition := Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster);
      
      if
        MausZeigerPosition.y <= Sf.sfInt32 (GrafikEinstellungen.FensterHöhe / 50)
        and
          MausZeigerPosition.x <= Sf.sfInt32 (GrafikEinstellungen.FensterBreite / 50)
      then
         return SystemDatentypen.Links_Oben;
         
      elsif
        MausZeigerPosition.y <= Sf.sfInt32 (GrafikEinstellungen.FensterHöhe / 50)
        and
          MausZeigerPosition.x >= Sf.sfInt32 (GrafikEinstellungen.FensterBreite - GrafikEinstellungen.FensterBreite / 50)
      then
         return SystemDatentypen.Rechts_Oben;
         
      elsif
        MausZeigerPosition.y >= Sf.sfInt32 (GrafikEinstellungen.FensterHöhe - GrafikEinstellungen.FensterHöhe / 50)
        and
          MausZeigerPosition.x <= Sf.sfInt32 (GrafikEinstellungen.FensterBreite / 50)
      then
         return SystemDatentypen.Links_Unten;
         
      elsif
        MausZeigerPosition.y >= Sf.sfInt32 (GrafikEinstellungen.FensterHöhe - GrafikEinstellungen.FensterHöhe / 50)
        and
          MausZeigerPosition.x >= Sf.sfInt32 (GrafikEinstellungen.FensterBreite - GrafikEinstellungen.FensterBreite / 50)
      then
         return SystemDatentypen.Rechts_Unten;
         
      elsif
        MausZeigerPosition.y <= Sf.sfInt32 (GrafikEinstellungen.FensterHöhe / 50)
      then
         return SystemDatentypen.Oben;
           
      elsif
        MausZeigerPosition.y >= Sf.sfInt32 (GrafikEinstellungen.FensterHöhe - GrafikEinstellungen.FensterHöhe / 50)
      then
         return SystemDatentypen.Unten;
         
      elsif
        MausZeigerPosition.x <= Sf.sfInt32 (GrafikEinstellungen.FensterBreite / 50)
      then
         return SystemDatentypen.Links;
         
      elsif
        MausZeigerPosition.x >= Sf.sfInt32 (GrafikEinstellungen.FensterBreite - GrafikEinstellungen.FensterBreite / 50)
      then
         return SystemDatentypen.Rechts;
         
      else
         return SystemDatentypen.Leer;
      end if;
      
   end MausScrollen;

end EingabeSFML;
