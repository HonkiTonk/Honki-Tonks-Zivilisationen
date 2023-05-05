with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with Sf;
with Sf.Window.Keyboard;
with Sf.Window.Mouse;
with Sf.Graphics.RenderWindow;

with SystemRecordKonstanten;
with SystemKonstanten;
with BetriebssystemKonstanten;

with NachGrafiktask;
with NachLogiktask;
-- with SpielstandlisteLogik;
with FensterGrafik;
with DebugobjekteLogik;

package body TexteingabeGrafik is

   procedure Texteingabe
   is
      use type Sf.sfBool;
      use type Sf.Window.Keyboard.sfKeyCode;
      use type Sf.Window.Mouse.sfMouseButton;
   begin
      
      TextSchleife:
      while
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => FensterGrafik.FensterLesen,
                                                        event        => TextEingegeben)
      loop
         
         case
           TextEingegeben.eventType
         is
            when Sf.Window.Event.sfEvtTextEntered =>
               EingegebenesZeichen := Wide_Wide_Character'Val (TextEingegeben.text.unicode);
               
               if
                 EingegebenesZeichen = CR
               then
                  null;
               
               elsif
                 EingegebenesZeichen = BS
                 or
                   EingegebenesZeichen = DEL
               then
                  ZeichenEntfernen;
         
               else
                  ZeichenHinzufügen (EingegebenesZeichenExtern => EingegebenesZeichen);
               end if;
               
            when Sf.Window.Event.sfEvtKeyPressed =>
               if
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEnter
               then
                  case
                    ExtraprüfungenWindows
                  is
                     when True =>
                        NachLogiktask.EingegebenerText.ErfolgreichAbbruch := True;
                        NachGrafiktask.TextEingabe := False;
                        NachLogiktask.GrafikWarten := False;
                        
                     when False =>
                        null;
                  end case;
                     
               elsif
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEscape
               then
                  NachLogiktask.EingegebenerText := SystemRecordKonstanten.LeerTexteingabe;
                  NachGrafiktask.TextEingabe := False;
                  NachLogiktask.GrafikWarten := False;
                  
               else
                  null;
               end if;
               
            when Sf.Window.Event.sfEvtMouseButtonPressed =>
               if
                 TextEingegeben.mouseButton.button = Sf.Window.Mouse.sfMouseRight
               then
                  NachLogiktask.EingegebenerText := SystemRecordKonstanten.LeerTexteingabe;
                  NachGrafiktask.TextEingabe := False;
                  NachLogiktask.GrafikWarten := False;
                  
               else
                  null;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop TextSchleife;
      
   end Texteingabe;
   
   
   
   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
   is begin
            
      case
        NachGrafiktask.NameSpielstand
      is
         when True =>
            if
              Spielstandnamen (EingegebenesZeichenExtern => EingegebenesZeichenExtern) = False
            then
               return;
                 
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
            
      NachLogiktask.EingegebenerText.EingegebenerText := NachLogiktask.EingegebenerText.EingegebenerText & EingegebenesZeichenExtern;
      
   end ZeichenHinzufügen;
   
   
   
   function Spielstandnamen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean
   is begin
      
      case
        EingegebenesZeichenExtern
      is
         when NUL .. US =>
            return False;
            
         when others =>
            null;
      end case;
      
      case
        DebugobjekteLogik.Debug.LinuxWindows
      is
         when True =>
            return SpielstandnamenLinux (EingegebenesZeichenExtern => EingegebenesZeichenExtern);
            
         when False =>
            return SpielstandnamenWindows (EingegebenesZeichenExtern => EingegebenesZeichenExtern);
      end case;
            
   end Spielstandnamen;
   
   
   
   function SpielstandnamenLinux
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean
   is begin
      
      if
        To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Length >= SystemKonstanten.MaximaleZeichenlängeDateisystem
      then
         return False;
         
      else
         null;
      end if;
      
      case
        EingegebenesZeichenExtern
      is
         when '/' =>
            return False;
            
         when others =>
            return True;
      end case;
      
   end SpielstandnamenLinux;
   
   
     
   function SpielstandnamenWindows
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean
   is begin
      
      if
        To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Length >= SystemKonstanten.MaximaleSpielstandlängeWindows
      then
         return False;
         
      else
         null;
      end if;
      
      case
        EingegebenesZeichenExtern
      is
         when '\' | '/' | ':' | '*' | '?' | '"' | '<' | '>' | '|' =>
            return False;
            
         when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | Space | Hyphen | Low_Line | Full_Stop =>
            return True;
            
         when others =>
            return False; -- True;
      end case;
      
   end SpielstandnamenWindows;
   
   
   
   function ExtraprüfungenWindows
     return Boolean
   is begin
      
      case
        DebugobjekteLogik.Debug.LinuxWindows
      is
         when True =>
            return True;
            
         when False =>
            null;
      end case;
      
      PunktLeerzeichenSchleife:
      loop
         
         if
           To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Length = 0
         then
            return False;
            
         elsif
           -- Full_Stop = Period, nicht erlaubt am Ende unter Windows!
           Full_Stop = Element (Source => NachLogiktask.EingegebenerText.EingegebenerText,
                                Index  => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last)
         then
            NachLogiktask.EingegebenerText.EingegebenerText := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => NachLogiktask.EingegebenerText.EingegebenerText,
                                                                                                       From    => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last,
                                                                                                       Through => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last);
            
         elsif
           -- Leerzeichen ist am Anfang unter Windows nicht erlaubt!
           Space = Element (Source => NachLogiktask.EingegebenerText.EingegebenerText,
                            Index  => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'First)
         then
            NachLogiktask.EingegebenerText.EingegebenerText := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => NachLogiktask.EingegebenerText.EingegebenerText,
                                                                                                       From    => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'First,
                                                                                                       Through => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'First);
            
         elsif
           -- Leerzeichen ist am Ende unter Windows nicht erlaubt!
           Space = Element (Source => NachLogiktask.EingegebenerText.EingegebenerText,
                            Index  => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last)
         then
            NachLogiktask.EingegebenerText.EingegebenerText := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => NachLogiktask.EingegebenerText.EingegebenerText,
                                                                                                       From    => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last,
                                                                                                       Through => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last);
            
         else
            exit PunktLeerzeichenSchleife;
         end if;
         
      end loop PunktLeerzeichenSchleife;
      
      -- Prüfen ob die Anfangszeichen identisch mit den verbotenen Namen sind und wenn ja, dann auf Punkt prüfen. äöü
      -- Punkt sollte reichen? äöü
      VerboteneNamenSchleife:
      for VerboteneNamenSchleifenwert in BetriebssystemKonstanten.VerboteneWindowsnamenArray'Range loop
         
         if
           To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText) = To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamen (VerboteneNamenSchleifenwert))
         then
            return False;
            
         else
            null;
         end if;
         
      end loop VerboteneNamenSchleife;
      
      return True;
      
   end ExtraprüfungenWindows;
       
   
   
   procedure ZeichenEntfernen
   is begin
      
      case
        To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Length
      is
         when 0 =>
            null;
         
         when others =>
            NachLogiktask.EingegebenerText.EingegebenerText := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => NachLogiktask.EingegebenerText.EingegebenerText,
                                                                                                       From    => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last,
                                                                                                       Through => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last);
      end case;
      
   end ZeichenEntfernen;

end TexteingabeGrafik;
