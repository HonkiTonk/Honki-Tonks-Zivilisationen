with Projekteinstellungen;
with BetriebssystemKonstanten;

with SchreibeLogiktask;

with Fehlermeldungssystem;
with UmwandlungenAdaEigenes;

package body VerzeichnisDateinamenTests is

   -- Bei Linux nur den Dateinamen übergeben, bei Windows zusätzlich noch den gesamten Pfad der Unterverzeichnisse.
   function GültigeZeichenlänge
     (LinuxTextExtern : in Unbounded_Wide_Wide_String;
      WindowsTextExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when BetriebssystemDatentypen.Linux_Enum =>
            if
              To_Wide_Wide_String (Source => LinuxTextExtern)'Length <= BetriebssystemKonstanten.MaximaleZeichenlängeDateisystem
            then
               return True;
               
            else
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "VerzeichnisDateinamenTests.GültigeZeichenlänge: Gültige Zeichenlänge überschritten: " & To_Wide_Wide_String (Source => WindowsTextExtern));
               return False;
            end if;
            
         when BetriebssystemDatentypen.Windows_Enum =>
            if
              To_Wide_Wide_String (Source => WindowsTextExtern)'Length <= BetriebssystemKonstanten.MaximaleZeichenlängeDateisystem - LängeAktuellesVerzeichnis
            then
               return True;
               
            else
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "VerzeichnisDateinamenTests.GültigeZeichenlänge: Gültige Zeichenlänge überschritten: " & To_Wide_Wide_String (Source => WindowsTextExtern));
               return False;
            end if;
      end case;
      
   end GültigeZeichenlänge;
   
   
   
   function Standardeinleseprüfung
     (VerzeichnisDateinameExtern : in Wide_Wide_String)
     return Boolean
   is begin
      
      if
    --    False = GültigeZeichenlänge (TextExtern         => To_Unbounded_Wide_Wide_String (Source => VerzeichnisDateinameExtern),
   ----                                  ZeichenabzugExtern => SystemDatentypen.Text_Enum)
    --  then
    --     return False;
            
   --   elsif
        Exists (Name => UmwandlungenAdaEigenes.EigenesEncode (TextExtern => VerzeichnisDateinameExtern)) = False
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "VerzeichnisDateinamenTests.Standardeinleseprüfung: Es fehlt: " & VerzeichnisDateinameExtern);
         return False;
            
      else
         return True;
      end if;
      
   end Standardeinleseprüfung;
   
   
   
   function StandardeinleseprüfungNeu
     (LinuxTextExtern : in Wide_Wide_String;
      WindowsTextExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      if
        False = GültigeZeichenlänge (LinuxTextExtern   => To_Unbounded_Wide_Wide_String (Source => LinuxTextExtern),
                                       WindowsTextExtern => To_Unbounded_Wide_Wide_String (Source => WindowsTextExtern))
      then
         return False;
         
      elsif
        Exists (Name => UmwandlungenAdaEigenes.EigenesEncode (TextExtern => WindowsTextExtern)) = False
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "VerzeichnisDateinamenTests.Standardeinleseprüfung: Es fehlt: " & WindowsTextExtern);
         return False;
            
      else
         return True;
      end if;
      
   end StandardeinleseprüfungNeu;
   
   
   
   function StandardwerteEinleseprüfung
     (LinuxTextExtern : in Wide_Wide_String;
      WindowsTextExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      if
        False = GültigeZeichenlänge (LinuxTextExtern   => To_Unbounded_Wide_Wide_String (Source => LinuxTextExtern),
                                       WindowsTextExtern => To_Unbounded_Wide_Wide_String (Source => WindowsTextExtern))
      then
         return False;
            
      elsif
        Exists (Name => UmwandlungenAdaEigenes.EigenesEncode (TextExtern => WindowsTextExtern)) = False
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
         when BetriebssystemDatentypen.Linux_Enum =>
            case
              ZeichenExtern
            is
               when '/' | BetriebssystemKonstanten.NUL =>
                  return False;
            
               when others =>
                  return True;
            end case;
            
         when BetriebssystemDatentypen.Windows_Enum =>
            case
              ZeichenExtern
            is
               -- Die Zeichen auch mal in Konstante packen? äöü
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
      
      AllgemeinesSchleife:
      for AllgemeinesSchleifenwert in BetriebssystemKonstanten.VerboteneNamen'Range loop
        
         if
           NameExtern = BetriebssystemKonstanten.VerboteneNamen (AllgemeinesSchleifenwert)
         then
            return False;
            
         else
            null;
         end if;
        
      end loop AllgemeinesSchleife;
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when BetriebssystemDatentypen.Linux_Enum =>
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
            
         when BetriebssystemDatentypen.Windows_Enum =>
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
         when BetriebssystemDatentypen.Linux_Enum =>
            return True;
            
         when BetriebssystemDatentypen.Windows_Enum =>
            return NamenprüfungenWindows (TextExtern => TextExtern);
      end case;
      
   end Namensprüfungen;
   
   
   
   function NamenprüfungenWindows
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      Text := TextExtern;
      
      PunktLeerzeichenSchleife:
      loop
                  
         if
           To_Wide_Wide_String (Source => Text)'Length = 0
         then
            return False;
            
         elsif
           -- Full_Stop = Period, nicht erlaubt am Ende unter Windows!
           BetriebssystemKonstanten.Punkt = Element (Source => Text,
                                                     Index  => To_Wide_Wide_String (Source => Text)'Last)
         then
            Text := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                            From    => To_Wide_Wide_String (Source => Text)'Last,
                                                            Through => To_Wide_Wide_String (Source => Text)'Last);
            
         elsif
           -- Leerzeichen ist am Anfang unter Windows nicht erlaubt!
           BetriebssystemKonstanten.Leerzeichen = Element (Source => Text,
                                                           Index  => To_Wide_Wide_String (Source => Text)'First)
         then
            Text := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                            From    => To_Wide_Wide_String (Source => Text)'First,
                                                            Through => To_Wide_Wide_String (Source => Text)'First);
            
         elsif
           -- Leerzeichen ist am Ende unter Windows nicht erlaubt!
           BetriebssystemKonstanten.Leerzeichen = Element (Source => Text,
                                                           Index  => To_Wide_Wide_String (Source => Text)'Last)
         then
            Text := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                            From    => To_Wide_Wide_String (Source => Text)'Last,
                                                            Through => To_Wide_Wide_String (Source => Text)'Last);
            
         else
            exit PunktLeerzeichenSchleife;
         end if;
         
      end loop PunktLeerzeichenSchleife;
      
      SchreibeLogiktask.Texteingabe (TextExtern => Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                                                           From    => To_Wide_Wide_String (Source => Text)'Last,
                                                                                           Through => To_Wide_Wide_String (Source => Text)'Last));
                  
      VerboteneNamenSchleife:
      for VerboteneNamenSchleifenwert in BetriebssystemKonstanten.VerboteneWindowsnamenGroß'Range loop
                  
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
