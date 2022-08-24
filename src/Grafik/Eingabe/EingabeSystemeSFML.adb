pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with Sf; use Sf;
with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Window.Mouse;
with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with SystemRecordKonstanten;
with GrafikDatentypen;

with GrafikEinstellungenSFML;
with NachGrafiktask;
with NachLogiktask;
with Sichtweiten;

package body EingabeSystemeSFML is

   procedure TastenEingabe
   is begin
      
      -- Kann man sfMouseButtonCount einfach so als Leerwert nehmen? Scheint zu funktionieren.
      NachLogiktask.MausTaste := Sf.Window.Mouse.sfMouseButtonCount;
      NachLogiktask.TastaturTaste := Sf.Window.Keyboard.sfKeyUnknown;
     -- NachLogiktask.MausRad := 0.00;
      
      TasteSchleife:
      while
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                        event        => Nutzereingabe)
      loop
         
         case
           Nutzereingabe.eventType
         is
            when Sf.Window.Event.sfEvtClosed =>
               -- Hier noch einen besseren universellen Endebefehl einbauen?
               NachGrafiktask.FensterGeschlossen := True;
               return;
                  
            when Sf.Window.Event.sfEvtResized =>
               NachGrafiktask.FensterVerändert := GrafikDatentypen.Fenster_Verändert_Enum;
                  
            when Sf.Window.Event.sfEvtMouseMoved =>
               NachLogiktask.Mausposition := (Float (Nutzereingabe.mouseMove.x), Float (Nutzereingabe.mouseMove.y));
               
            when others =>
               null;
         end case;
            
         -- Gäbe es einen Vorteil diesen Teil in jeweils eine eigene Prüfung umzuwandeln? Eventuell um mehrere Dinge gleichzeitig festlegen zu können?
         -- Beeinflusst das nicht auch die Auswertung in EingabeSFML? Hier einzeln durchgehen und dann in EingabeSFML die Auswertungsreihenfolge festlegen?
         case
           Nutzereingabe.eventType
         is
            when Sf.Window.Event.sfEvtKeyPressed =>
               NachLogiktask.TastaturTaste := Nutzereingabe.key.code;
                  
            when Sf.Window.Event.sfEvtMouseWheelScrolled =>
               -- NachLogiktask.MausRad := Nutzereingabe.mouseWheelScroll.eventDelta;
               if
                 Nutzereingabe.mouseWheelScroll.eventDelta < 0.00
               then
                  Sichtweiten.ZoomstufeÄndern (ÄnderungExtern => 1);
                  
               else
                  Sichtweiten.ZoomstufeÄndern (ÄnderungExtern => -1);
               end if;
                  
            when Sf.Window.Event.sfEvtMouseButtonPressed =>
               NachLogiktask.MausTaste := Nutzereingabe.mouseButton.button;
                  
            when others =>
               null;
         end case;
                     
      end loop TasteSchleife;
      
      NachGrafiktask.TastenEingabe := False;
      NachLogiktask.Warten := False;
      
   end TastenEingabe;
   
   
   
   -- Zahleneingabe über eine eigene Version von Texteingabe regeln? äöü
   procedure TextEingeben
   is begin
      
      TasteSchleife:
      while
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                        event        => TextEingegeben)
      loop
            
         case
           TextEingegeben.eventType
         is
            when Sf.Window.Event.sfEvtTextEntered =>
               TextPrüfen (UnicodeNummerExtern => TextEingegeben.text.unicode);
               
            when Sf.Window.Event.sfEvtKeyPressed =>
               if
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEnter
               then
                  NachLogiktask.EingegebenerText.ErfolgreichAbbruch := True;
                  NachGrafiktask.TextEingabe := False;
                  NachLogiktask.Warten := False;
                     
               elsif
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEscape
               then
                  NachLogiktask.EingegebenerText := SystemRecordKonstanten.LeerTexteingabe;
                  NachGrafiktask.TextEingabe := False;
                  NachLogiktask.Warten := False;
                  
               else
                  null;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop TasteSchleife;
      
   end TextEingeben;
   
   
   
   procedure TextPrüfen
     (UnicodeNummerExtern : in Sf.sfUint32)
   is begin
      
      case
        UnicodeNummerExtern
      is
         when 0 .. 7 | 9 .. 31 | 128 .. 159 =>
            return;
            
         when others =>
            EingegebenesZeichen := Wide_Wide_Character'Val (UnicodeNummerExtern);
      end case;
      
      case
        EingegebenesZeichen
      is
         when BS | DEL =>
            ZeichenEntfernen;
         
         when others =>
            ZeichenHinzufügen (EingegebenesZeichenExtern => EingegebenesZeichen);
      end case;
      
   end TextPrüfen;
   
   
   
   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
   is begin
      
      case
        NachGrafiktask.NameSpielstand
      is
         when False =>
            null;
            
         when True =>
            if
              EingegebenesZeichenExtern not in 'a' .. 'z'
              and
                EingegebenesZeichenExtern not in 'A' .. 'Z'
                and
                  EingegebenesZeichenExtern not in '0' .. '9'
                  and
                    EingegebenesZeichenExtern /= Space
                    and
                      EingegebenesZeichenExtern /= Hyphen
                      and
                        EingegebenesZeichenExtern /= Low_Line
            then
               return;
              
            elsif
              To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Length > MaximaleZeichenlängeDateisystem
            then
               return;
               
            else
               null;
            end if;
      end case;
      
      CharacterZuText (1) := EingegebenesZeichenExtern;
      
      NachLogiktask.EingegebenerText.EingegebenerText := NachLogiktask.EingegebenerText.EingegebenerText & To_Unbounded_Wide_Wide_String (Source => CharacterZuText);
      
   end ZeichenHinzufügen;
   
   
   
   procedure ZeichenEntfernen
   is begin
      
      if
        To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Length < 1
      then
         null;
         
      else
         NachLogiktask.EingegebenerText.EingegebenerText := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => NachLogiktask.EingegebenerText.EingegebenerText,
                                                                                                    From    => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last,
                                                                                                    Through => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last);
      end if;
      
   end ZeichenEntfernen;

end EingabeSystemeSFML;
