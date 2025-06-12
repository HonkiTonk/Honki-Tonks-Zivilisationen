with Ada.Wide_Wide_Characters.Handling;

with BetriebssystemKonstantenHTSEB;
with BetriebssystemDatentypenHTSEB;
with SystemRecordsKonstantenHTSEB;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;
with DateisystemvariablenHTSEB;

-- So umbauen dass die Zusammenfassung von Linux und Windows den Gesamtpfad ergibt? äöü
package body DateisystemtestsHTSEB is

   -- Bei Linux nur den Dateinamen übergeben, bei Windows zusätzlich noch den gesamten Pfad der Unterverzeichnisse.
   function GültigeZeichenlänge
     (LinuxTextExtern : in Unbounded_Wide_Wide_String;
      WindowsTextExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      case
        DateisystemvariablenHTSEB.BetriebssystemAbfragen
      is
         when BetriebssystemDatentypenHTSEB.Linux_Enum =>
            if
              To_Wide_Wide_String (Source => LinuxTextExtern)'Length <= BetriebssystemKonstantenHTSEB.MaximaleZeichenlängeDateisystem
            then
               return True;
               
            else
               MeldungssystemHTSEB.Logik (MeldungExtern => "DateisystemtestsHTSEB.GültigeZeichenlänge: Gültige Zeichenlänge überschritten: " & To_Wide_Wide_String (Source => WindowsTextExtern));
               return False;
            end if;
            
         when BetriebssystemDatentypenHTSEB.Windows_Enum =>
            if
              To_Wide_Wide_String (Source => WindowsTextExtern)'Length <= BetriebssystemKonstantenHTSEB.MaximaleZeichenlängeDateisystem - LängeAktuellesVerzeichnis
            then
               return True;
               
            else
               MeldungssystemHTSEB.Logik (MeldungExtern => "DateisystemtestsHTSEB.GültigeZeichenlänge: Gültige Zeichenlänge überschritten: " & To_Wide_Wide_String (Source => WindowsTextExtern));
               return False;
            end if;
      end case;
      
   end GültigeZeichenlänge;
   
   
   
   function Standardeinleseprüfung
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
        Exists (Name => UmwandlungssystemHTSEB.Encode (TextExtern => WindowsTextExtern)) = False
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "DateisystemtestsHTSEB.Standardeinleseprüfung: Es fehlt: " & WindowsTextExtern);
         return False;
            
      else
         return True;
      end if;
      
   end Standardeinleseprüfung;
   
   
   
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
        Exists (Name => UmwandlungssystemHTSEB.Encode (TextExtern => WindowsTextExtern)) = False
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
        DateisystemvariablenHTSEB.BetriebssystemAbfragen
      is
         when BetriebssystemDatentypenHTSEB.Linux_Enum =>
            case
              ZeichenExtern
            is
               when '/' | BetriebssystemKonstantenHTSEB.NUL =>
                  return False;
            
               when others =>
                  return True;
            end case;
            
         when BetriebssystemDatentypenHTSEB.Windows_Enum =>
            case
              ZeichenExtern
            is
               -- Die Zeichen auch mal in Konstante packen? äöü
               when '\' | '/' | ':' | '*' | '?' | '"' | '<' | '>' | '|' | BetriebssystemKonstantenHTSEB.NUL .. BetriebssystemKonstantenHTSEB.US =>
                  return False;
            
               when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | BetriebssystemKonstantenHTSEB.Leerzeichen | BetriebssystemKonstantenHTSEB.Bindestrich
                  | BetriebssystemKonstantenHTSEB.Unterstrich | BetriebssystemKonstantenHTSEB.Punkt =>
                  return True;
            
               when others =>
                  -- Für den Fall das ich irgendwann einmal Wide_Wide_Directories haben kann ich hier True zurückgeben und damit alle Zeichen erlauben die nicht verboten sind. äöü
                  return False;
            end case;
      end case;
      
   end GültigesZeichen;
   
   
   
   function GültigerNamen
     (NameExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      AllgemeinesSchleife:
      for AllgemeinesSchleifenwert in BetriebssystemKonstantenHTSEB.VerboteneNamen'Range loop
        
         if
           NameExtern = BetriebssystemKonstantenHTSEB.VerboteneNamen (AllgemeinesSchleifenwert)
         then
            return False;
            
         else
            null;
         end if;
        
      end loop AllgemeinesSchleife;
      
      case
        DateisystemvariablenHTSEB.BetriebssystemAbfragen
      is
         when BetriebssystemDatentypenHTSEB.Linux_Enum =>
            LinuxprüfungSchleife:
            for LinuxprüfungSchleifenwert in NameExtern'Range loop
         
               case
                 NameExtern (LinuxprüfungSchleifenwert)
               is
                  when '/' | BetriebssystemKonstantenHTSEB.NUL =>
                     return False;
               
                  when others =>
                     null;
               end case;
         
            end loop LinuxprüfungSchleife;
            
         when BetriebssystemDatentypenHTSEB.Windows_Enum =>
            WindowsprüfungSchleife:
            for WindowsprüfungSchleifenwert in NameExtern'Range loop
         
               case
                 NameExtern (WindowsprüfungSchleifenwert)
               is
                  when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | BetriebssystemKonstantenHTSEB.Leerzeichen | BetriebssystemKonstantenHTSEB.Bindestrich
                     | BetriebssystemKonstantenHTSEB.Unterstrich | BetriebssystemKonstantenHTSEB.Punkt =>
                     null;
                     
                  when '\' | '/' | ':' | '*' | '?' | '"' | '<' | '>' | '|' | BetriebssystemKonstantenHTSEB.NUL .. BetriebssystemKonstantenHTSEB.US =>
                     return False;
               
                  when others =>
                     return False;
               end case;
         
            end loop WindowsprüfungSchleife;
      end case;
      
      return True;
      
   end GültigerNamen;
   
   
   
   function Namensprüfungen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return SystemRecordsHTSEB.TextEingabeRecord
   is begin
      
      VerboteneNamenSchleife:
      for VerboteneNamenSchleifenwert in BetriebssystemKonstantenHTSEB.VerboteneNamen'Range loop
         
         if
           TextExtern = BetriebssystemKonstantenHTSEB.VerboteneNamen (VerboteneNamenSchleifenwert)
         then
            return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
         
         else
            null;
         end if;
         
      end loop VerboteneNamenSchleife;
      
      case
        DateisystemvariablenHTSEB.BetriebssystemAbfragen
      is
         when BetriebssystemDatentypenHTSEB.Linux_Enum =>
            return (True, TextExtern);
            
         when BetriebssystemDatentypenHTSEB.Windows_Enum =>
            return NamenprüfungenWindows (TextExtern => TextExtern);
      end case;
      
   end Namensprüfungen;
   
   
   
   function NamenprüfungenWindows
     (TextExtern : in Unbounded_Wide_Wide_String)
      return SystemRecordsHTSEB.TextEingabeRecord
   is
      use Ada.Wide_Wide_Characters.Handling;
   begin
      
      Text := TextExtern;
      
      PunktLeerzeichenSchleife:
      loop
                  
         if
           To_Wide_Wide_String (Source => Text)'Length = 0
         then
            return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
            
         elsif
           -- Full_Stop = Period, nicht erlaubt am Ende unter Windows!
           BetriebssystemKonstantenHTSEB.Punkt = Element (Source => Text,
                                                          Index  => To_Wide_Wide_String (Source => Text)'Last)
         then
            Text := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                            From    => To_Wide_Wide_String (Source => Text)'Last,
                                                            Through => To_Wide_Wide_String (Source => Text)'Last);
            
         elsif
           -- Leerzeichen ist am Anfang unter Windows nicht erlaubt!
           BetriebssystemKonstantenHTSEB.Leerzeichen = Element (Source => Text,
                                                                Index  => To_Wide_Wide_String (Source => Text)'First)
         then
            Text := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                            From    => To_Wide_Wide_String (Source => Text)'First,
                                                            Through => To_Wide_Wide_String (Source => Text)'First);
            
         elsif
           -- Leerzeichen ist am Ende unter Windows nicht erlaubt!
           BetriebssystemKonstantenHTSEB.Leerzeichen = Element (Source => Text,
                                                                Index  => To_Wide_Wide_String (Source => Text)'Last)
         then
            Text := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                            From    => To_Wide_Wide_String (Source => Text)'Last,
                                                            Through => To_Wide_Wide_String (Source => Text)'Last);
            
         else
            exit PunktLeerzeichenSchleife;
         end if;
         
      end loop PunktLeerzeichenSchleife;
      
      
      
      -- Standard ist alles groß.
      VerbotenenamenDreiSchleife:
      for VerbotenenamenDreiSchleifenwert in BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenDrei'Range loop
                                    
         case
           PrüfungDrei (TextExtern           => To_Wide_Wide_String (Source => Text),
                         VerbotenerTextExtern => To_Wide_Wide_String (Source => BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenDrei (VerbotenenamenDreiSchleifenwert)))
         is
            when False =>
               return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
               
            when True =>
               null;
         end case;
         
      end loop VerbotenenamenDreiSchleife;
      
      
      
      -- Standard ist alles groß.
      VerbotenenamenVierSchleife:
      for VerbotenenamenVierSchleifenwert in BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenVier'Range loop
         
         case
           PrüfungDrei (TextExtern           => To_Wide_Wide_String (Source => Text),
                         VerbotenerTextExtern => To_Wide_Wide_String (Source => BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenVier (VerbotenenamenVierSchleifenwert)))
         is
            when False =>
               return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
               
            when True =>
               null;
         end case;
         
      end loop VerbotenenamenVierSchleife;
      
      
      
      -- Standard ist alles groß.
      VerbotenenamenFünfSchleife:
      for VerbotenenamenFünfSchleifenwert in BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenFünf'Range loop
         VierSchleife:
         for VierSchleifenwert in Boolean'Range loop
            FünfSchleife:
            for FünfSchleifenwert in Boolean'Range loop
                                    
               FünferText := To_Wide_Wide_String (Source => BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenFünf (VerbotenenamenFünfSchleifenwert));
               
               case
                 VierSchleifenwert
               is
                  when True =>
                     FünferText (4) := To_Lower (Item => FünferText) (4);
                        
                  when False =>
                     null;
               end case;
                  
               case
                 FünfSchleifenwert
               is
                  when True =>
                     FünferText (5) := To_Lower (Item => FünferText) (5);
                        
                  when False =>
                     null;
               end case;
               
               case
                 PrüfungDrei (TextExtern           => To_Wide_Wide_String (Source => Text),
                               VerbotenerTextExtern => FünferText)
               is
                  when False =>
                     return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
               
                  when True =>
                     null;
               end case;
                  
            end loop FünfSchleife;
         end loop VierSchleife;
      end loop VerbotenenamenFünfSchleife;
      
      return (True, Text);
         
   end NamenprüfungenWindows;
   
   
   
   function PrüfungDrei
     (TextExtern : in Wide_Wide_String;
      VerbotenerTextExtern : in Wide_Wide_String)
      return Boolean
   is
      use Ada.Wide_Wide_Characters.Handling;
   begin
      
      Zwischenspeicher := VerbotenerTextExtern (VerbotenerTextExtern'First .. VerbotenerTextExtern'First + 2);
      
      EinsSchleife:
      for EinsSchleifenwert in Boolean'Range loop
         ZweiSchleife:
         for ZweiSchleifenwert in Boolean'Range loop
            DreiSchleife:
            for DreiSchleifenwert in Boolean'Range loop
               
               case
                 EinsSchleifenwert
               is
                  when True =>
                     Zwischenspeicher (1) := To_Lower (Item => Zwischenspeicher) (1);
                        
                  when False =>
                     null;
               end case;
                  
               case
                 ZweiSchleifenwert
               is
                  when True =>
                     Zwischenspeicher (2) := To_Lower (Item => Zwischenspeicher) (2);
                        
                  when False =>
                     null;
               end case;
                  
               case
                 DreiSchleifenwert
               is
                  when True =>
                     Zwischenspeicher (3) := To_Lower (Item => Zwischenspeicher) (3);
                        
                  when False =>
                     null;
               end case;
               
               case
                 VerbotenerTextExtern'Length
               is
                  when 3 =>
                     if
                       TextExtern = Zwischenspeicher
                     then
                        return False;
            
                     elsif
                       TextExtern'Length > VerbotenerTextExtern'Length
                       and then
                         TextExtern (TextExtern'First .. TextExtern'First - 1 + VerbotenerTextExtern'Length + 1) = Zwischenspeicher & "."
                     then
                        return False;
            
                     else
                        null;
                     end if;
                     
                  when 4 =>
                     if
                       TextExtern = Zwischenspeicher & VerbotenerTextExtern (VerbotenerTextExtern'Last)
                     then
                        return False;
            
                     elsif
                       TextExtern'Length > VerbotenerTextExtern'Length
                       and then
                         TextExtern (TextExtern'First .. TextExtern'First - 1 + VerbotenerTextExtern'Length + 1) = Zwischenspeicher & VerbotenerTextExtern (VerbotenerTextExtern'Last) & "."
                     then
                        return False;
            
                     else
                        null;
                     end if;
                     
                  when 5 =>
                     if
                       TextExtern = Zwischenspeicher & VerbotenerTextExtern (VerbotenerTextExtern'Last - 1 .. VerbotenerTextExtern'Last)
                     then
                        return False;
            
                     elsif
                       TextExtern'Length > VerbotenerTextExtern'Length
                       and then
                         TextExtern (TextExtern'First .. TextExtern'First - 1 + VerbotenerTextExtern'Length + 1)
                       = Zwischenspeicher & VerbotenerTextExtern (VerbotenerTextExtern'Last - 1 .. VerbotenerTextExtern'Last) & "."
                     then
                        return False;
                                                                                                                                                            
                     else
                        null;
                     end if;
                     
                  when others =>
                     return False;
               end case;
                  
            end loop DreiSchleife;
         end loop ZweiSchleife;
      end loop EinsSchleife;
      
      return True;
      
   end PrüfungDrei;

end DateisystemtestsHTSEB;
