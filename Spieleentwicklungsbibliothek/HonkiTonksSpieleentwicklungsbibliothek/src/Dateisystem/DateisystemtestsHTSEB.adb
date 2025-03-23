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
      
      
      
      VerbotenenamenDreiSchleife:
      for VerbotenenamenDreiSchleifenwert in BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenDrei'Range loop
         DreiEinsSchleife:
         for DreiEinsSchleifenwert in Boolean'Range loop
            DreiZweiSchleife:
            for DreiZweiSchleifenwert in Boolean'Range loop
               DreiDreiSchleife:
               for DreiDreiSchleifenwert in Boolean'Range loop
                                    
                  -- Standard ist alles groß.
                  DreierText := To_Wide_Wide_String (Source => BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenDrei (VerbotenenamenDreiSchleifenwert));
                  
                  case
                    DreiEinsSchleifenwert
                  is
                     when True =>
                        DreierText (1) := To_Lower (Item => DreierText) (1);
                        
                     when False =>
                        null;
                  end case;
                  
                  case
                    DreiZweiSchleifenwert
                  is
                     when True =>
                        DreierText (2) := To_Lower (Item => DreierText) (2);
                        
                     when False =>
                        null;
                  end case;
                  
                  case
                    DreiDreiSchleifenwert
                  is
                     when True =>
                        DreierText (3) := To_Lower (Item => DreierText) (3);
                        
                     when False =>
                        null;
                  end case;
                 
                  if
                    Text = DreierText
                  then
                     return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
            
                  elsif
                    To_Wide_Wide_String (Source => Text)'Length > DreierText'Length
                    and then
                      To_Wide_Wide_String (Source => Text) (1 .. DreierText'Length + 1) = DreierText & "."
                  then
                     return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
            
                  else
                     null;
                  end if;
                  
               end loop DreiDreiSchleife;
            end loop DreiZweiSchleife;
         end loop DreiEinsSchleife;
      end loop VerbotenenamenDreiSchleife;
      
      
      
      VerbotenenamenVierSchleife:
      for VerbotenenamenVierSchleifenwert in BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenVier'Range loop
         VierEinsSchleife:
         for VierEinsSchleifenwert in Boolean'Range loop
            VierZweiSchleife:
            for VierZweiSchleifenwert in Boolean'Range loop
               VierDreiSchleife:
               for VierDreiSchleifenwert in Boolean'Range loop
                                    
                  -- Standard ist alles groß.
                  ViererText := To_Wide_Wide_String (Source => BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenVier (VerbotenenamenVierSchleifenwert));
                  
                  case
                    VierEinsSchleifenwert
                  is
                     when True =>
                        ViererText (1) := To_Lower (Item => ViererText) (1);
                        
                     when False =>
                        null;
                  end case;
                  
                  case
                    VierZweiSchleifenwert
                  is
                     when True =>
                        ViererText (2) := To_Lower (Item => ViererText) (2);
                        
                     when False =>
                        null;
                  end case;
                  
                  case
                    VierDreiSchleifenwert
                  is
                     when True =>
                        ViererText (3) := To_Lower (Item => ViererText) (3);
                        
                     when False =>
                        null;
                  end case;
                 
                  if
                    Text = ViererText
                  then
                     return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
            
                  elsif
                    To_Wide_Wide_String (Source => Text)'Length > ViererText'Length
                    and then
                      To_Wide_Wide_String (Source => Text) (1 .. ViererText'Length + 1) = ViererText & "."
                  then
                     return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
            
                  else
                     null;
                  end if;
                  
               end loop VierDreiSchleife;
            end loop VierZweiSchleife;
         end loop VierEinsSchleife;
      end loop VerbotenenamenVierSchleife;
      
      
      
      -- VerbotenenamenFünfSchleife:
      -- for VerbotenenamenFünfSchleifenwert in BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenFünf'Range loop
      FünfEinsSchleife:
      for FünfEinsSchleifenwert in Boolean'Range loop
         FünfZweiSchleife:
         for FünfZweiSchleifenwert in Boolean'Range loop
            FünfDreiSchleife:
            for FünfDreiSchleifenwert in Boolean'Range loop
               FünfVierSchleife:
               for FünfVierSchleifenwert in Boolean'Range loop
                  FünfFünfSchleife:
                  for FünfFünfSchleifenwert in Boolean'Range loop
                                    
                     -- Standard ist alles groß.
                     FünferText := To_Wide_Wide_String (Source => BetriebssystemKonstantenHTSEB.VerboteneWindowsnamenFünf (1));
                  
                     case
                       FünfEinsSchleifenwert
                     is
                        when True =>
                           FünferText (1) := To_Lower (Item => FünferText) (1);
                        
                        when False =>
                           null;
                     end case;
                  
                     case
                       FünfZweiSchleifenwert
                     is
                        when True =>
                           FünferText (2) := To_Lower (Item => FünferText) (2);
                        
                        when False =>
                           null;
                     end case;
                  
                     case
                       FünfDreiSchleifenwert
                     is
                        when True =>
                           FünferText (3) := To_Lower (Item => FünferText) (3);
                        
                        when False =>
                           null;
                     end case;
                  
                     case
                       FünfVierSchleifenwert
                     is
                        when True =>
                           FünferText (4) := To_Lower (Item => FünferText) (4);
                        
                        when False =>
                           null;
                     end case;
                  
                     case
                       FünfFünfSchleifenwert
                     is
                        when True =>
                           FünferText (5) := To_Lower (Item => FünferText) (5);
                        
                        when False =>
                           null;
                     end case;
                 
                     if
                       Text = FünferText
                     then
                        return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
            
                     elsif
                       To_Wide_Wide_String (Source => Text)'Length > FünferText'Length
                       and then
                         To_Wide_Wide_String (Source => Text) (1 .. FünferText'Length + 1) = FünferText & "."
                     then
                        return SystemRecordsKonstantenHTSEB.LeerTexteingabe;
            
                     else
                        null;
                     end if;
                  
                  end loop FünfFünfSchleife;
               end loop FünfVierSchleife;
            end loop FünfDreiSchleife;
         end loop FünfZweiSchleife;
      end loop FünfEinsSchleife;
      -- end loop VerbotenenamenFünfSchleife;
      
      return (True, Text);
         
   end NamenprüfungenWindows;

end DateisystemtestsHTSEB;
