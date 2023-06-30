with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with Sf;
with Sf.Window.Keyboard;
with Sf.Window.Mouse;
with Sf.Graphics.RenderWindow;

with SystemRecordKonstanten;
with SystemKonstanten;
with BetriebssystemKonstanten;
with Projekteinstellungen;

with SchreibeLogiktask;
with LeseLogiktask;

with Grafiktask;
with FensterGrafik;

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
                    Extraprüfungen
                  is
                     when True =>
                        SchreibeLogiktask.ErfolgTexteingabe (ErfolgExtern => True);
                        Grafiktask.Eingaben.TextEingabe := False;
                        SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
                        
                     when False =>
                        null;
                  end case;
                     
               elsif
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEscape
               then
                  Abbruch;
                  
               else
                  null;
               end if;
               
            when Sf.Window.Event.sfEvtMouseButtonPressed =>
               if
                 TextEingegeben.mouseButton.button = Sf.Window.Mouse.sfMouseRight
               then
                  Abbruch;
                  
               else
                  null;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop TextSchleife;
      
   end Texteingabe;
   
   
   
   procedure Abbruch
   is begin
      
      SchreibeLogiktask.KompletteTexteingabe (EingabeExtern => SystemRecordKonstanten.LeerTexteingabe);
      Grafiktask.Eingaben.TextEingabe := False;
      SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
      
   end Abbruch;
   
   
   
   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
   is begin
            
      case
        Grafiktask.Spielstand.NameSpielstand
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
      
      SchreibeLogiktask.Texteingabe (TextExtern => (LeseLogiktask.Texteingabe & EingegebenesZeichenExtern));
      
   end ZeichenHinzufügen;
   
   
   
   function Spielstandnamen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean
   is begin
      
      case
        Projekteinstellungen.Debug.LinuxWindows
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
        To_Wide_Wide_String (Source => LeseLogiktask.Texteingabe)'Length >= SystemKonstanten.MaximaleZeichenlängeDateisystem
      then
         return False;
         
      else
         null;
      end if;
      
      case
        EingegebenesZeichenExtern
      is
         when '/' | NUL =>
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
        To_Wide_Wide_String (Source => LeseLogiktask.Texteingabe)'Length >= SystemKonstanten.MaximaleSpielstandlängeWindows
      then
         return False;
         
      else
         null;
      end if;
      
      case
        EingegebenesZeichenExtern
      is
         when '\' | '/' | ':' | '*' | '?' | '"' | '<' | '>' | '|' | NUL .. US =>
            return False;
            
         when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | Space | Hyphen | Low_Line | Full_Stop =>
            return True;
            
         when others =>
            return False; -- True;
      end case;
      
   end SpielstandnamenWindows;
   
   
   
   function Extraprüfungen
     return Boolean
   is begin
      
      VerboteneNamenSchleife:
      for VerboteneNamenSchleifenwert in BetriebssystemKonstanten.VerboteneNamen'Range loop
         
         if
           To_Wide_Wide_String (Source => LeseLogiktask.Texteingabe) = To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneNamen (VerboteneNamenSchleifenwert))
         then
            return False;
         
         else
            null;
         end if;
         
      end loop VerboteneNamenSchleife;
      
      case
        Projekteinstellungen.Debug.LinuxWindows
      is
         when True =>
            return True;
            
         when False =>
            return ExtraprüfungenWindows;
      end case;
      
   end Extraprüfungen;
      
      
      
   function ExtraprüfungenWindows
     return Boolean
   is begin
      
      PunktLeerzeichenSchleife:
      loop
         
         Text := LeseLogiktask.Texteingabe;
         
         if
           To_Wide_Wide_String (Source => Text)'Length = 0
         then
            return False;
            
         elsif
           -- Full_Stop = Period, nicht erlaubt am Ende unter Windows!
           Full_Stop = Element (Source => Text,
                                Index  => To_Wide_Wide_String (Source => Text)'Last)
         then
            SchreibeLogiktask.Texteingabe (TextExtern => Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                                                                     From    => To_Wide_Wide_String (Source => Text)'Last,
                                                                                                     Through => To_Wide_Wide_String (Source => Text)'Last));
            
         elsif
           -- Leerzeichen ist am Anfang unter Windows nicht erlaubt!
           Space = Element (Source => Text,
                            Index  => To_Wide_Wide_String (Source => Text)'First)
         then
            SchreibeLogiktask.Texteingabe (TextExtern => Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                                                                     From    => To_Wide_Wide_String (Source => Text)'First,
                                                                                                     Through => To_Wide_Wide_String (Source => Text)'First));
            
         elsif
           -- Leerzeichen ist am Ende unter Windows nicht erlaubt!
           Space = Element (Source => Text,
                            Index  => To_Wide_Wide_String (Source => Text)'Last)
         then
            SchreibeLogiktask.Texteingabe (TextExtern => Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                                                                     From    => To_Wide_Wide_String (Source => Text)'Last,
                                                                                                     Through => To_Wide_Wide_String (Source => Text)'Last));
            
         else
            exit PunktLeerzeichenSchleife;
         end if;
         
      end loop PunktLeerzeichenSchleife;
      
      
      
      VerboteneNamenSchleife:
      for VerboteneNamenSchleifenwert in BetriebssystemKonstanten.VerboteneWindowsnamenGroß'Range loop
         
         Text := LeseLogiktask.Texteingabe;
         
         if
           To_Wide_Wide_String (Source => Text)'Length < To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Length
         then
            Erlaubt := True;
            
         elsif
           To_Wide_Wide_String (Source => Text) = To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))
           or
             To_Wide_Wide_String (Source => Text) = To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenKlein (VerboteneNamenSchleifenwert))
         then
            return False;
               
         else
            Erlaubt := False;
                     
            WörterSchleife:
            for WörterSchleifenwert in To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Range loop
         
               if
                 To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert)) (WörterSchleifenwert) = Element (Source => Text,
                                                                                                                                                                     Index  => WörterSchleifenwert)
                 or
                   To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenKlein (VerboteneNamenSchleifenwert)) (WörterSchleifenwert) = Element (Source => Text,
                                                                                                                                                                       Index  => WörterSchleifenwert)
               then
                  null;
               
               else
                  Erlaubt := True;
                  exit WörterSchleife;
               end if;
                
            end loop WörterSchleife;
         end if;
            
         case
           Erlaubt
         is
            when True =>
               null;
               
            when False =>
               if
                 To_Wide_Wide_String (Source => Text)'Length < To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Last + 1
               then
                  return False;
                  
               elsif
                 Full_Stop = To_Wide_Wide_String (Source => Text) (To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Last + 1)
               then
                  return False;
                     
               else
                  null;
               end if;
         end case;
         
      end loop VerboteneNamenSchleife;
      
      return True;
      
   end ExtraprüfungenWindows;
       
   
   
   procedure ZeichenEntfernen
   is begin
      
      Text := LeseLogiktask.Texteingabe;
      
      case
        To_Wide_Wide_String (Source => Text)'Length
      is
         when 0 =>
            null;
         
         when others =>
            SchreibeLogiktask.Texteingabe (TextExtern => Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                                                                     From    => To_Wide_Wide_String (Source => Text)'Last,
                                                                                                     Through => To_Wide_Wide_String (Source => Text)'Last));
      end case;
      
   end ZeichenEntfernen;

end TexteingabeGrafik;
