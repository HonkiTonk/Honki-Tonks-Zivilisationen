pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;

package body EingabeSFML is
   
   function TastenEingabe
     return Sf.Window.Event.sfEvent
   is begin
      
      EingabeSchleife:
      loop
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => ZeichenEingeben)
           = Sf.sfTrue loop
            
            case
              ZeichenEingeben.eventType
            is
               when Sf.Window.Event.sfEvtKeyPressed | Sf.Window.Event.sfEvtMouseButtonPressed =>
                  return ZeichenEingeben;
               
               when others =>
                  null;
            end case;
         
         end loop TasteSchleife;
      end loop EingabeSchleife;
      
   end TastenEingabe;
   
   
   
   function TastenEingabeErweitert
     return Sf.Window.Event.sfEvent
   is begin
      
      EingabeSchleife:
      loop
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => ZeichenEingeben)
           = Sf.sfTrue loop
            
            case
              ZeichenEingeben.eventType
            is
               when Sf.Window.Event.sfEvtKeyPressed | Sf.Window.Event.sfEvtMouseButtonPressed | Sf.Window.Event.sfEvtMouseMoved | Sf.Window.Event.sfEvtMouseWheelScrolled =>
                  return ZeichenEingeben;
               
               when others =>
                  null;
            end case;
         
         end loop TasteSchleife;
      end loop EingabeSchleife;
      
   end TastenEingabeErweitert;
   
   

   procedure MausScrollen
   is begin
      
      null;
      
   end MausScrollen;

end EingabeSFML;
