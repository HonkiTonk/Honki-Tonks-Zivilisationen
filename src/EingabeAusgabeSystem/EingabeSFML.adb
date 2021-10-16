pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;

package body EingabeSFML is
   
   function TastenEingabe
     return Sf.Window.Keyboard.sfKeyCode
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
               when Sf.Window.Event.sfEvtKeyPressed =>
                  return ZeichenEingeben.key.code;
               
               when others =>
                  null;
            end case;
         
         end loop TasteSchleife;
      end loop EingabeSchleife;
      
   end TastenEingabe;
   
   

   procedure MausScrollen
   is begin
      
      null;
      
   end MausScrollen;

end EingabeSFML;
