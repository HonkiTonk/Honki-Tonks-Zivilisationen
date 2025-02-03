with Ada.Wide_Wide_Characters.Handling; use Ada.Wide_Wide_Characters.Handling;

with Projekteinstellungen;
with BetriebssystemKonstanten;
with SystemRecordKonstanten;

with MeldungssystemHTB1;
with UmwandlungssystemHTB3;

-- So umbauen dass die Zusammenfassung von Linux und Windows den Gesamtpfad ergibt? äöü
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
               MeldungssystemHTB1.Logik (MeldungExtern => "VerzeichnisDateinamenTests.GültigeZeichenlänge: Gültige Zeichenlänge überschritten: " & To_Wide_Wide_String (Source => WindowsTextExtern));
               return False;
            end if;
            
         when BetriebssystemDatentypen.Windows_Enum =>
            if
              To_Wide_Wide_String (Source => WindowsTextExtern)'Length <= BetriebssystemKonstanten.MaximaleZeichenlängeDateisystem - LängeAktuellesVerzeichnis
            then
               return True;
               
            else
               MeldungssystemHTB1.Logik (MeldungExtern => "VerzeichnisDateinamenTests.GültigeZeichenlänge: Gültige Zeichenlänge überschritten: " & To_Wide_Wide_String (Source => WindowsTextExtern));
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
        Exists (Name => UmwandlungssystemHTB3.Encode (TextExtern => VerzeichnisDateinameExtern)) = False
      then
         MeldungssystemHTB1.Logik (MeldungExtern => "VerzeichnisDateinamenTests.Standardeinleseprüfung: Es fehlt: " & VerzeichnisDateinameExtern);
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
        Exists (Name => UmwandlungssystemHTB3.Encode (TextExtern => WindowsTextExtern)) = False
      then
         MeldungssystemHTB1.Logik (MeldungExtern => "VerzeichnisDateinamenTests.Standardeinleseprüfung: Es fehlt: " & WindowsTextExtern);
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
        Exists (Name => UmwandlungssystemHTB3.Encode (TextExtern => WindowsTextExtern)) = False
      then
         return False;
            
      else
         return True;
      end if;
      
   end StandardwerteEinleseprüfung;
   
   
   
   -- Das hier kann ausgelagert werden. äöü
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
                  return True; -- False; -- True;
            end case;
      end case;
      
   end GültigesZeichen;
   
   
   
   -- Das hier auch. äöü
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
                     
                  when '\' | '/' | ':' | '*' | '?' | '"' | '<' | '>' | '|' | BetriebssystemKonstanten.NUL .. BetriebssystemKonstanten.US =>
                     return False;
               
                  when others =>
                     null; -- return False;
               end case;
         
            end loop WindowsprüfungSchleife;
      end case;
      
      return True;
      
   end GültigerNamen;
   
   
   
   -- Das auch. äöü
   function Namensprüfungen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return SystemRecords.TextEingabeRecord
   is begin
      
      VerboteneNamenSchleife:
      for VerboteneNamenSchleifenwert in BetriebssystemKonstanten.VerboteneNamen'Range loop
         
         if
           TextExtern = BetriebssystemKonstanten.VerboteneNamen (VerboteneNamenSchleifenwert)
         then
            return SystemRecordKonstanten.LeerTexteingabe;
         
         else
            null;
         end if;
         
      end loop VerboteneNamenSchleife;
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when BetriebssystemDatentypen.Linux_Enum =>
            return (True, TextExtern);
            
         when BetriebssystemDatentypen.Windows_Enum =>
            return NamenprüfungenWindows (TextExtern => TextExtern);
      end case;
      
   end Namensprüfungen;
   
   
   
   -- Das auch. äöü
   function NamenprüfungenWindows
     (TextExtern : in Unbounded_Wide_Wide_String)
      return SystemRecords.TextEingabeRecord
   is begin
      
      Text := TextExtern;
      
      PunktLeerzeichenSchleife:
      loop
                  
         if
           To_Wide_Wide_String (Source => Text)'Length = 0
         then
            return SystemRecordKonstanten.LeerTexteingabe;
            
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
      
      
      
      VerbotenenamenDreiSchleife:
      for VerbotenenamenDreiSchleifenwert in BetriebssystemKonstanten.VerboteneWindowsnamenDrei'Range loop
         SchreibartenDreiSchleife:
         for SSchreibartenDreiSchleifenwert in 0 .. 7 loop
            
            -- Standard ist alles groß.
            DreierText := To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenDrei (VerbotenenamenDreiSchleifenwert));
            
            case
              SSchreibartenDreiSchleifenwert
            is
               when 0 =>
                  null;
                  
               when 1 =>
                DreierText (1) := To_Lower (Item => DreierText) (1);
                  
               when 2 =>
                DreierText (2) := To_Lower (Item => DreierText) (2);
                  
               when 3 =>
                DreierText (3) := To_Lower (Item => DreierText) (3);
                                                
               when 4 =>
                DreierText (1) := To_Lower (Item => DreierText) (1);
                DreierText (2) := To_Lower (Item => DreierText) (2);
                  
               when 5 =>
                DreierText (1) := To_Lower (Item => DreierText) (1);
                DreierText (3) := To_Lower (Item => DreierText) (3);
                  
               when 6 =>
                DreierText (2) := To_Lower (Item => DreierText) (2);
                DreierText (3) := To_Lower (Item => DreierText) (3);
                  
               when 7 =>
                DreierText (1) := To_Lower (Item => DreierText) (1);
                DreierText (2) := To_Lower (Item => DreierText) (2);
                DreierText (3) := To_Lower (Item => DreierText) (3);
            end case;
            
            if
              Text = DreierText
            then
               return SystemRecordKonstanten.LeerTexteingabe;
            
            elsif
              To_Wide_Wide_String (Source => Text)'Length > DreierText'Length
              and then
                To_Wide_Wide_String (Source => Text) (1 .. DreierText'Length + 1) = DreierText & "."
            then
               return SystemRecordKonstanten.LeerTexteingabe;
            
            else
               null;
            end if;
         
         end loop SchreibartenDreiSchleife;
      end loop VerbotenenamenDreiSchleife;
      
      
      
      VerbotenenamenVierSchleife:
      for VerbotenenamenVierSchleifenwert in BetriebssystemKonstanten.VerboteneWindowsnamenVier'Range loop
         SchreibartenVierSchleife:
         for SchreibartenVierSchleifenwert in 0 .. 7 loop
            
            -- Standard ist alles groß.
            ViererText := To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenVier (VerbotenenamenVierSchleifenwert));
            
            case
              SchreibartenVierSchleifenwert
            is
               when 0 =>
                  null;
                  
               when 1 =>
                ViererText (1) := To_Lower (Item => ViererText) (1);
                  
               when 2 =>
                ViererText (2) := To_Lower (Item => ViererText) (2);
                  
               when 3 =>
                ViererText (3) := To_Lower (Item => ViererText) (3);
                                                
               when 4 =>
                ViererText (1) := To_Lower (Item => ViererText) (1);
                ViererText (2) := To_Lower (Item => ViererText) (2);
                  
               when 5 =>
                ViererText (1) := To_Lower (Item => ViererText) (1);
                ViererText (3) := To_Lower (Item => ViererText) (3);
                  
               when 6 =>
                ViererText (2) := To_Lower (Item => ViererText) (2);
                ViererText (3) := To_Lower (Item => ViererText) (3);
                  
               when 7 =>
                ViererText (1) := To_Lower (Item => ViererText) (1);
                ViererText (2) := To_Lower (Item => ViererText) (2);
                ViererText (3) := To_Lower (Item => ViererText) (3);
            end case;
            
            if
              Text = ViererText
            then
               return SystemRecordKonstanten.LeerTexteingabe;
            
            elsif
              To_Wide_Wide_String (Source => Text)'Length > ViererText'Length
              and then
                To_Wide_Wide_String (Source => Text) (1 .. ViererText'Length + 1) = ViererText & "."
            then
               return SystemRecordKonstanten.LeerTexteingabe;
            
            else
               null;
            end if;
         
         end loop SchreibartenVierSchleife;
      end loop VerbotenenamenVierSchleife;
      
      
      
      VerbotenenamenFünfSchleife:
      for VerbotenenamenFünfSchleifenwert in BetriebssystemKonstanten.VerboteneWindowsnamenFünf'Range loop
         SchreibartenFünfSchleife:
         for SchreibartenFünfSchleifenwert in 0 .. 7 loop
            
            -- Standard ist alles groß.
            FünferText := To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenVier (VerbotenenamenFünfSchleifenwert));
            
            case
              SchreibartenFünfSchleifenwert
            is
               when 0 =>
                  null;
                  
               when 1 =>
                FünferText (1) := To_Lower (Item => FünferText) (1);
                  
               when 2 =>
                FünferText (2) := To_Lower (Item => FünferText) (2);
                  
               when 3 =>
                FünferText (3) := To_Lower (Item => FünferText) (3);
                                                
               when 4 =>
                FünferText (1) := To_Lower (Item => FünferText) (1);
                FünferText (2) := To_Lower (Item => FünferText) (2);
                  
               when 5 =>
                FünferText (1) := To_Lower (Item => FünferText) (1);
                FünferText (3) := To_Lower (Item => FünferText) (3);
                  
               when 6 =>
                FünferText (2) := To_Lower (Item => FünferText) (2);
                FünferText (3) := To_Lower (Item => FünferText) (3);
                  
               when 7 =>
                FünferText (1) := To_Lower (Item => FünferText) (1);
                FünferText (2) := To_Lower (Item => FünferText) (2);
                FünferText (3) := To_Lower (Item => FünferText) (3);
            end case;
            
            if
              Text = FünferText
            then
               return SystemRecordKonstanten.LeerTexteingabe;
            
            elsif
              To_Wide_Wide_String (Source => Text)'Length > FünferText'Length
              and then
                To_Wide_Wide_String (Source => Text) (1 .. FünferText'Length + 1) = FünferText & "."
            then
               return SystemRecordKonstanten.LeerTexteingabe;
            
            else
               null;
            end if;
         
         end loop SchreibartenFünfSchleife;
      end loop VerbotenenamenFünfSchleife;
      
      
      
      return (True, Text);
      
   end NamenprüfungenWindows;

end VerzeichnisDateinamenTests;
