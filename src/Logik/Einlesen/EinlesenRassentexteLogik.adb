pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;

with Rassentexte;
with TextKonstanten;
with VerzeichnisKonstanten;

with OptionenVariablen;
with EinlesenAllgemeinesLogik;
with Warnung;

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
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.RassentexteEinlesen: Es fehlt: " & Decode (Item => VerzeichnisKonstanten.SprachenStrich)
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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.RassentexteEinlesen: Fehlende Zeilen: " & Decode (Item => VerzeichnisKonstanten.SprachenStrich)
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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.RassentexteEinlesenZwei: Es fehlt: " & To_Wide_Wide_String (Source => Hauptdatei (RasseSchleifenwert)));
               
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
                        Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.RassentexteEinlesenZwei: Fehlende Zeilen: " & To_Wide_Wide_String (Source => Hauptdatei (RasseSchleifenwert)));
               
                     when False =>
                        Rassendateien (UnterdateiSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiUnternull));
                  end case;
            
               end loop UnterdateienSchleife;
         
               Close (File => DateiUnternull);
         
               NameBeschreibung (RasseExtern => RasseSchleifenwert);
               Städtenamen (RasseExtern => RasseSchleifenwert);
               Forschungen (RasseExtern => RasseSchleifenwert);
               Einheiten (RasseExtern => RasseSchleifenwert);
               Gebäude (RasseExtern => RasseSchleifenwert);
         end case;
         
      end loop RassenSchleife;
      
   end RassentexteEinlesen;
   
   
   
   -- Den Dateinamen hier überall von außen hineingeben. äöü
   procedure NameBeschreibung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (1))))
      is
         when True =>
            Open (File => DateiNameBeschreibung,
                  Mode => In_File,
                  Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (1))));
            
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.NameBeschreibung: Es fehlt: " & To_Wide_Wide_String (Source => Rassendateien (1)));
            return;
      end case;
      
      NameBeschreibungSchleife:
      for NameBeschreibungSchleifenwert in Rassentexte.NameBeschreibungArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiNameBeschreibung,
                                                           AktuelleZeileExtern => Positive (NameBeschreibungSchleifenwert))
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.NameBeschreibung: Fehlende Zeilen: " & To_Wide_Wide_String (Source => Rassendateien (1)));
               exit NameBeschreibungSchleife;
               
            when False =>
               Rassentexte.NameBeschreibung (RasseExtern, NameBeschreibungSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNameBeschreibung));
         end case;
         
      end loop NameBeschreibungSchleife;
      
      Close (File => DateiNameBeschreibung);
      
   end NameBeschreibung;
   
   
   
   procedure Städtenamen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (2))))
      is
         when True =>
            Open (File => DateiStädtenamen,
                  Mode => In_File,
                  Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (2))));
            
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Städtenamen: Es fehlt: " & To_Wide_Wide_String (Source => Rassendateien (2)));
            return;
      end case;
      
      StädtenamenSchleife:
      for StädtenamenSchleifenwert in Rassentexte.StädtenamenArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiStädtenamen,
                                                           AktuelleZeileExtern => Positive (StädtenamenSchleifenwert))
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Städtenamen: Fehlende Zeilen: " & To_Wide_Wide_String (Source => Rassendateien (2)));
               exit StädtenamenSchleife;
               
            when False =>
               Rassentexte.Städtenamen (RasseExtern, StädtenamenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiStädtenamen));
         end case;
         
      end loop StädtenamenSchleife;
      
      Close (File => DateiStädtenamen);
            
   end Städtenamen;
   
   
   
   procedure Forschungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (3))))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiForschungen,
                  Mode => In_File,
                  Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (3))));
            
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Forschungen: Es fehlt: " & To_Wide_Wide_String (Source => Rassendateien (3)));
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
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Forschungen: Fehlende Zeilen: " & To_Wide_Wide_String (Source => Rassendateien (3)));
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (4))))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiEinheiten,
                  Mode => In_File,
                  Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (4))));
            
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Einheiten: Es fehlt: " & To_Wide_Wide_String (Source => Rassendateien (4)));
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
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Einheiten: Fehlende Zeilen: " & To_Wide_Wide_String (Source => Rassendateien (4)));
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (5))))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiGebäude,
                  Mode => In_File,
                  Name => Encode (Item => To_Wide_Wide_String (Source => Rassendateien (5))));
            
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Gebäude: Es fehlt: " & To_Wide_Wide_String (Source => Rassendateien (4)));
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
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Gebäude: Fehlende Zeilen: " & To_Wide_Wide_String (Source => Rassendateien (5)));
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
