with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;

with Rassentexte;
with TextKonstanten;
with VerzeichnisKonstanten;

with OptionenVariablen;
with EinlesenAllgemeinesLogik;
with Fehlermeldungssystem;

package body EinlesenRassentexteLogik is

   procedure RassentexteEinlesen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.SprachenStrich & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & VerzeichnisKonstanten.Rassen
                & VerzeichnisKonstanten.NullDatei)
      is
         when True =>
            Hauptdatei := (others => TextKonstanten.LeerUnboundedString);
            
            Open (File => DateiNull,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SprachenStrich & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & VerzeichnisKonstanten.Rassen
                  & VerzeichnisKonstanten.NullDatei);

         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.RassentexteEinlesen: Es fehlt: " & Decode (Item => VerzeichnisKonstanten.SprachenStrich)
                                  & To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache) & Decode (Item => VerzeichnisKonstanten.Rassen & VerzeichnisKonstanten.NullDatei));
            return;
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in HauptdateiArray'Range loop

         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiNull,
                                                           AktuelleZeileExtern => RassenDatentypen.Rassen_Verwendet_Enum'Pos (WelcheDateienSchleifenwert))
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.RassentexteEinlesen: Fehlende Zeilen: " & Decode (Item => VerzeichnisKonstanten.SprachenStrich)
                                     & To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache) & Decode (Item => VerzeichnisKonstanten.Rassen & VerzeichnisKonstanten.NullDatei));
               
            when False =>
               Hauptdatei (WelcheDateienSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNull));
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiNull);
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Hauptdatei (RasseSchleifenwert))))
         is
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.RassentexteEinlesenZwei: Es fehlt: " & To_Wide_Wide_String (Source => Hauptdatei (RasseSchleifenwert)));
               
            when True =>
               Open (File => DateiUnternull,
                     Mode => In_File,
                     Name => Encode (Item => To_Wide_Wide_String (Source => Hauptdatei (RasseSchleifenwert))));
         
               UnterdateienSchleife:
               for UnterdateiSchleifenwert in RassendateienArray'Range loop
            
                  case
                    EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiUnternull,
                                                                    AktuelleZeileExtern => UnterdateiSchleifenwert)
                  is
                     when True =>
                        Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.RassentexteEinlesenZwei: Fehlende Zeilen: " & To_Wide_Wide_String (Source => Hauptdatei (RasseSchleifenwert)));
               
                     when False =>
                        Rassendateien (UnterdateiSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiUnternull));
                  end case;
            
               end loop UnterdateienSchleife;
         
               Close (File => DateiUnternull);
         
               NameBeschreibung (RasseExtern     => RasseSchleifenwert,
                                 DateinameExtern => To_Wide_Wide_String (Source => Rassendateien (1)));
               
               Städtenamen (RasseExtern     => RasseSchleifenwert,
                            DateinameExtern => To_Wide_Wide_String (Source => Rassendateien (2)));
               
               Forschungen (RasseExtern     => RasseSchleifenwert,
                            DateinameExtern => To_Wide_Wide_String (Source => Rassendateien (3)));
               
               Einheiten (RasseExtern     => RasseSchleifenwert,
                          DateinameExtern => To_Wide_Wide_String (Source => Rassendateien (4)));
               
               Gebäude (RasseExtern     => RasseSchleifenwert,
                        DateinameExtern => To_Wide_Wide_String (Source => Rassendateien (5)));
         end case;
         
      end loop RassenSchleife;
      
   end RassentexteEinlesen;
   
   
   
   procedure NameBeschreibung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            Open (File => DateiNameBeschreibung,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern));
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.NameBeschreibung: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      NameBeschreibungSchleife:
      for NameBeschreibungSchleifenwert in Rassentexte.NameBeschreibungArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiNameBeschreibung,
                                                           AktuelleZeileExtern => Positive (NameBeschreibungSchleifenwert))
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.NameBeschreibung: Fehlende Zeilen: " & DateinameExtern);
               exit NameBeschreibungSchleife;
               
            when False =>
               Rassentexte.NameBeschreibung (RasseExtern, NameBeschreibungSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNameBeschreibung));
         end case;
         
      end loop NameBeschreibungSchleife;
      
      Close (File => DateiNameBeschreibung);
      
   end NameBeschreibung;
   
   
   
   procedure Städtenamen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            Open (File => DateiStädtenamen,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern));
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.Städtenamen: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      StädtenamenSchleife:
      for StädtenamenSchleifenwert in Rassentexte.StädtenamenArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiStädtenamen,
                                                           AktuelleZeileExtern => Positive (StädtenamenSchleifenwert))
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.Städtenamen: Fehlende Zeilen: " & DateinameExtern);
               exit StädtenamenSchleife;
               
            when False =>
               Rassentexte.Städtenamen (RasseExtern, StädtenamenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiStädtenamen));
         end case;
         
      end loop StädtenamenSchleife;
      
      Close (File => DateiStädtenamen);
            
   end Städtenamen;
   
   
   
   procedure Forschungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiForschungen,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern));
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.Forschungen: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      ForschungenSchleife:
      for ForschungenSchleifenwert in Rassentexte.ForschungenArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Rassentexte.ForschungenArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiForschungen,
                                                              AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.Forschungen: Fehlende Zeilen: " & DateinameExtern);
                  exit ForschungenSchleife;
               
               when False =>
                  Rassentexte.Forschungen (RasseExtern, ForschungenSchleifenwert, TextSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiForschungen));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop ForschungenSchleife;
      
      Close (File => DateiForschungen);
      
   end Forschungen;
   
   
   
   procedure Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiEinheiten,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern));
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.Einheiten: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      EinheitenSchleife:
      for EinheitSchleifenwert in Rassentexte.EinheitenArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Rassentexte.EinheitenArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiEinheiten,
                                                              AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.Einheiten: Fehlende Zeilen: " & DateinameExtern);
                  exit EinheitenSchleife;
               
               when False =>
                  Rassentexte.Einheiten (RasseExtern, EinheitSchleifenwert, TextSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiEinheiten));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop EinheitenSchleife;
      
      Close (File => DateiEinheiten);
      
   end Einheiten;
   
   
   
   procedure Gebäude
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiGebäude,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern));
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.Gebäude: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in Rassentexte.GebäudeArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Rassentexte.GebäudeArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiGebäude,
                                                              AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenRassentexte.Gebäude: Fehlende Zeilen: " & DateinameExtern);
                  exit GebäudeSchleife;
               
               when False =>
                  Rassentexte.Gebäude (RasseExtern, GebäudeSchleifenwert, TextSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiGebäude));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop GebäudeSchleife;
      
      Close (File => DateiGebäude);
      
   end Gebäude;

end EinlesenRassentexteLogik;
