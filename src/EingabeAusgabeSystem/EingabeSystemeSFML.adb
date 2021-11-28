pragma SPARK_Mode (On);

with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

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
      
      EingegebenerName := To_Unbounded_Wide_Wide_String (Source => "");
      
      EingabeSchleife:
      loop
         TasteSchleife:
         while Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungen.Fenster,
                                                   event        => TextEingegeben)
           = Sf.sfTrue loop
            
            case
              TextEingegeben.eventType
            is
               when Sf.Window.Event.sfEvtTextEntered =>
                  TextPrüfen (UnicodeNummerExtern => TextEingegeben.text.unicode);
               
                  -- Im aktuellen System gibt es gar kein Abbruch für Speichern/Laden/Städtbau/usw., oder?
               when Sf.Window.Event.sfEvtKeyPressed =>
                  if
                    TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEnter
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
   
   
   
   procedure TextPrüfen
     (UnicodeNummerExtern : in Sf.sfUint32)
   is begin
      
      case
        UnicodeNummerExtern
      is
         when 0 .. 7 | 9 .. 26 | 28 .. 31 | 128 .. 159 =>
            return;
            
         when others =>
            EingegebenesZeichen := Wide_Wide_Character'Val (UnicodeNummerExtern);
      end case;
      
      case
        EingegebenesZeichen
      is
         when ESC =>
            null;
            
         when BS | DEL =>
            ZeichenEntfernen;
         
         when others =>
            ZeichenHinzufügen (EingegebenesZeichenExtern => EingegebenesZeichen);
      end case;
      
   end TextPrüfen;
   
   
   
   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
   is begin
      
      CharacterZuText (1) := EingegebenesZeichenExtern;
      
      EingegebenerName := EingegebenerName & To_Unbounded_Wide_Wide_String (Source => CharacterZuText);
      
   end ZeichenHinzufügen;
   
   
   
   procedure ZeichenEntfernen
   is begin
      
      if
        To_Wide_Wide_String (Source => EingegebenerName)'Length < 1
      then
         null;
         
      else
         EingegebenerName := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => EingegebenerName,
                                                                     From    => To_Wide_Wide_String (Source => EingegebenerName)'Last,
                                                                     Through => To_Wide_Wide_String (Source => EingegebenerName)'Last);
      end if;
      
   end ZeichenEntfernen;

end EingabeSystemeSFML;
