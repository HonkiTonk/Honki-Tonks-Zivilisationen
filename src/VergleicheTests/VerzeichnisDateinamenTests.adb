with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Projekteinstellungen;
with BetriebssystemKonstanten;

with SchreibeLogiktask;
with LeseLogiktask;

with Fehlermeldungssystem;

package body VerzeichnisDateinamenTests is

   function GültigeZeichenlänge
     (TextExtern : in Unbounded_Wide_Wide_String;
      ZeichenabzugExtern : in SystemDatentypen.Zeichenabzug_Enum)
      return Boolean
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Linux_Enum =>
            if
              To_Wide_Wide_String (Source => TextExtern)'Length <= BetriebssystemKonstanten.MaximaleZeichenlängeDateisystem
            then
               return True;
               
            else
               return False;
            end if;
            
         when SystemDatentypen.Windows_Enum =>
            if
              To_Wide_Wide_String (Source => TextExtern)'Length <= BetriebssystemKonstanten.MaximaleZeichenlängeDateisystem - Current_Directory'Length
              - Zeichenabzug (Projekteinstellungen.Einstellungen.Betriebssystem, ZeichenabzugExtern)
            then
               return True;
               
            else
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "VerzeichnisDateinamenTests.GültigeZeichenlänge: Gültige Zeichenlänge überschritten: " & To_Wide_Wide_String (Source => TextExtern));
               return False;
            end if;
      end case;
      
   end GültigeZeichenlänge;
   
   

   function GültigeZeichenlängeNeu
     (TextExtern : in Unbounded_Wide_Wide_String;
      ZusatztextExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Linux_Enum =>
            if
              To_Wide_Wide_String (Source => TextExtern)'Length <= BetriebssystemKonstanten.MaximaleZeichenlängeDateisystem
            then
               return True;
               
            else
               return False;
            end if;
            
         when SystemDatentypen.Windows_Enum =>
            if
              To_Wide_Wide_String (Source => TextExtern)'Length <= BetriebssystemKonstanten.MaximaleZeichenlängeDateisystem - Current_Directory'Length - ZusatztextExtern'Length
            then
               return True;
               
            else
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "VerzeichnisDateinamenTests.GültigeZeichenlänge: Gültige Zeichenlänge überschritten: " & To_Wide_Wide_String (Source => TextExtern));
               return False;
            end if;
      end case;
      
   end GültigeZeichenlängeNeu;
   
   
   
   function Standardeinleseprüfung
     (VerzeichnisDateinameExtern : in Wide_Wide_String)
     return Boolean
   is begin
      
      if
        False = GültigeZeichenlänge (TextExtern         => To_Unbounded_Wide_Wide_String (Source => VerzeichnisDateinameExtern),
                                     ZeichenabzugExtern => SystemDatentypen.Text_Enum)
      then
         return False;
            
      elsif
        Exists (Name => Encode (Item => VerzeichnisDateinameExtern)) = False
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "VerzeichnisDateinamenTests.Standardeinleseprüfung: Es fehlt: " & VerzeichnisDateinameExtern);
         return False;
            
      else
         return True;
      end if;
      
   end Standardeinleseprüfung;
   
   
   
   function StandardwerteEinleseprüfung
     (VerzeichnisDateinameExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      if
        False = GültigeZeichenlänge (TextExtern         => To_Unbounded_Wide_Wide_String (Source => VerzeichnisDateinameExtern),
                                       ZeichenabzugExtern => SystemDatentypen.Text_Enum)
      then
         return False;
            
      elsif
        Exists (Name => Encode (Item => VerzeichnisDateinameExtern)) = False
      then
         return False;
            
      else
         return True;
      end if;
      
   end StandardwerteEinleseprüfung;
   
   
   
   function GültigesZeichen
     (ZeichenExtern : in Wide_Wide_Character)
      return Boolean
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Linux_Enum =>
            case
              ZeichenExtern
            is
               when '/' | BetriebssystemKonstanten.NUL =>
                  return False;
            
               when others =>
                  return True;
            end case;
            
         when SystemDatentypen.Windows_Enum =>
            case
              ZeichenExtern
            is
               when '\' | '/' | ':' | '*' | '?' | '"' | '<' | '>' | '|' | BetriebssystemKonstanten.NUL .. BetriebssystemKonstanten.US =>
                  return False;
            
               when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | BetriebssystemKonstanten.Leerzeichen | BetriebssystemKonstanten.Bindestrich | BetriebssystemKonstanten.Unterstrich | BetriebssystemKonstanten.Punkt =>
                  return True;
            
               when others =>
                  -- Für den Fall das ich irgendwann einmal Wide_Wide_Directories haben kann ich hier True zurückgeben und damit alle Zeichen erlauben die nicht verboten sind. äöü
                  return False; -- True;
            end case;
      end case;
      
   end GültigesZeichen;
   
   
   
   function GültigerNamen
     (NameExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Linux_Enum =>
            LinuxprüfungSchleife:
            for LinuxprüfungSchleifenwert in NameExtern'Range loop
         
               case
                 NameExtern (LinuxprüfungSchleifenwert)
               is
                  when '/' | BetriebssystemKonstanten.NUL =>
                     return False;
               
                  when others =>
                     null;
               end case;
         
            end loop LinuxprüfungSchleife;
            
         when SystemDatentypen.Windows_Enum =>
            WindowsprüfungSchleife:
            for WindowsprüfungSchleifenwert in NameExtern'Range loop
         
               case
                 NameExtern (WindowsprüfungSchleifenwert)
               is
                  when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | BetriebssystemKonstanten.Leerzeichen | BetriebssystemKonstanten.Bindestrich | BetriebssystemKonstanten.Unterstrich | BetriebssystemKonstanten.Punkt =>
                     null;
               
                  when others =>
                     return False;
               end case;
         
            end loop WindowsprüfungSchleife;
      end case;
      
      return True;
      
   end GültigerNamen;
   
   
   
   function Namensprüfungen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      VerboteneNamenSchleife:
      for VerboteneNamenSchleifenwert in BetriebssystemKonstanten.VerboteneNamen'Range loop
         
         if
           To_Wide_Wide_String (Source => TextExtern) = To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneNamen (VerboteneNamenSchleifenwert))
         then
            return False;
         
         else
            null;
         end if;
         
      end loop VerboteneNamenSchleife;
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Linux_Enum =>
            return True;
            
         when SystemDatentypen.Windows_Enum =>
            return NamenprüfungenWindows (TextExtern => TextExtern);
      end case;
      
   end Namensprüfungen;
   
   
   
   function NamenprüfungenWindows
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      PunktLeerzeichenSchleife:
      loop
         
         Text := TextExtern;
         
         if
           To_Wide_Wide_String (Source => Text)'Length = 0
         then
            return False;
            
         elsif
           -- Full_Stop = Period, nicht erlaubt am Ende unter Windows!
           BetriebssystemKonstanten.Punkt = Element (Source => Text,
                                                     Index  => To_Wide_Wide_String (Source => Text)'Last)
         then
            SchreibeLogiktask.Texteingabe (TextExtern => Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                                                                 From    => To_Wide_Wide_String (Source => Text)'Last,
                                                                                                 Through => To_Wide_Wide_String (Source => Text)'Last));
            
         elsif
           -- Leerzeichen ist am Anfang unter Windows nicht erlaubt!
           BetriebssystemKonstanten.Leerzeichen = Element (Source => Text,
                                                           Index  => To_Wide_Wide_String (Source => Text)'First)
         then
            SchreibeLogiktask.Texteingabe (TextExtern => Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                                                                 From    => To_Wide_Wide_String (Source => Text)'First,
                                                                                                 Through => To_Wide_Wide_String (Source => Text)'First));
            
         elsif
           -- Leerzeichen ist am Ende unter Windows nicht erlaubt!
           BetriebssystemKonstanten.Leerzeichen = Element (Source => Text,
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
                 BetriebssystemKonstanten.Punkt = To_Wide_Wide_String (Source => Text) (To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Last + 1)
               then
                  return False;
                     
               else
                  null;
               end if;
         end case;
         
      end loop VerboteneNamenSchleife;
      
      return True;
      
   end NamenprüfungenWindows;

end VerzeichnisDateinamenTests;
