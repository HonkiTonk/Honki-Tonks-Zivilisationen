pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;
with InteraktionTasks;

package body EingabeSystemeSFML is

   procedure TastenEingabe
   is begin
      
      TastaturTaste := Sf.Window.Keyboard.sfKeyUnknown;
      MausTaste := Sf.Window.Mouse.sfMouseXButton2;
      MausBewegt := False;
      Mausbewegungen := 0;
      MausRad := 0.00;
      
      EingabeSchleife:
      loop
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => ZeichenEingeben)
           = Sf.sfTrue loop
            
            case
              ZeichenEingeben.eventType
            is
               when Sf.Window.Event.sfEvtClosed =>
                  -- Hier noch einen universellen Endebefehl einbauen.
                  null;
                  
               when Sf.Window.Event.sfEvtKeyPressed =>
                  TastaturTaste := ZeichenEingeben.key.code;
                  return;
                  
               when Sf.Window.Event.sfEvtMouseWheelScrolled =>
                  MausRad := ZeichenEingeben.mouseWheelScroll.eventDelta;
                  return;
                  
               when Sf.Window.Event.sfEvtMouseButtonPressed =>
                  MausTaste := ZeichenEingeben.mouseButton.button;
                  return;
                  
               when Sf.Window.Event.sfEvtMouseMoved =>
                  Mausbewegungen := Mausbewegungen + 1;
                  
                  if
                    Mausbewegungen > 15
                  then
                     MausBewegt := True;
                     -- Immer hier die neue Mausposition festlegen, denn es kann/wird bei mehreren gleichzeitigen Mausaufrufen des RenderWindow zu Abstürzen kommen.
                     GrafikEinstellungen.MausPosition := (ZeichenEingeben.mouseMove.x, ZeichenEingeben.mouseMove.y);
                     return;
                     
                  else
                     null;
                  end if;
                  
               when Sf.Window.Event.sfEvtResized =>
                  InteraktionTasks.FensterVerändert := True;
                  
               when others =>
                  null;
            end case;
         
         end loop TasteSchleife;
      end loop EingabeSchleife;
      
   end TastenEingabe;
   
   
   
   function TextEingeben
     return Unbounded_Wide_Wide_String
   is begin
      
      EingabeSchleife:
      loop
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => TextEingegebenEvent)
           = Sf.sfTrue loop
            
            case
              TextEingegebenEvent.eventType
            is
               when Sf.Window.Event.sfEvtTextEntered =>
                  -- EingegebenerName := EingegebenerName + TextEingegebenEvent.text.unicode;
                  null;
               
               when Sf.Window.Event.sfEvtKeyPressed =>
                  if
                    TextEingegebenEvent.key.code = Sf.Window.Keyboard.sfKeyEnter
                  then
                     exit EingabeSchleife;
                  
                  else
                     null;
                  end if;
               
               when others =>
                  null;
            end case;
         
         end loop TasteSchleife;
      end loop EingabeSchleife;
   
      return EingegebenerName;
      
   end TextEingeben;

end EingabeSystemeSFML;
