pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories;

with Rassentexte;
with TextKonstanten;

with OptionenVariablen;
with EinlesenAllgemein;
with Warnung;

package body EinlesenRassentexte is

   procedure RassentexteEinlesen
   is begin
      
      Rassentexte.NameBeschreibung (RassenDatentypen.Menschen_Enum, 1) := Rassentexte.NameBeschreibung (RassenDatentypen.Menschen_Enum, 2);
      
      -- Diese Prüfung mal auslagern und sie dann entsprachend überall verwenden? äöü
      case
        Ada.Directories.Exists (Name => TextKonstanten.SprachenStrich
                                & Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (Item => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache))
                                & TextKonstanten.Rassen & TextKonstanten.NullDatei)
      is
         when True =>
            Hauptdatei := (others => TextKonstanten.LeerUnboundedString);
            
            Ada.Wide_Wide_Text_IO.Open (File => DateiNull,
                                        Mode => Ada.Wide_Wide_Text_IO.In_File,
                                        Name => TextKonstanten.SprachenStrich
                                        & Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (Item => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache))
                                        & TextKonstanten.Rassen & TextKonstanten.NullDatei);

         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.RassentexteEinlesen - 0-Datei fehlt.");
            return;
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in HauptdateiArray'Range loop

         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiNull,
                                                    AktuelleZeileExtern => RassenDatentypen.Rassen_Verwendet_Enum'Pos (WelcheDateienSchleifenwert))
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.RassentexteEinlesen - 0-Datei zu kurz.");
               
            when False =>
               Hauptdatei (WelcheDateienSchleifenwert) := Ada.Strings.Wide_Wide_Unbounded.To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiNull));
         end case;

      end loop EinlesenSchleife;

      Ada.Wide_Wide_Text_IO.Close (File => DateiNull);
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
         Ada.Wide_Wide_Text_IO.Open (File => DateiUnternull,
                                     Mode => Ada.Wide_Wide_Text_IO.In_File,
                                     Name => Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (Item => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => Hauptdatei (RasseSchleifenwert))));
         
         UnterdateienSchleife:
         for UnterdateiSchleifenwert in RassendateienArray'Range loop
            
            case
              EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiUnternull,
                                                       AktuelleZeileExtern => UnterdateiSchleifenwert)
            is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.RassentexteEinlesen - 0-Datei zu kurz.");
               
            when False =>
               Rassendateien (UnterdateiSchleifenwert) := Ada.Strings.Wide_Wide_Unbounded.To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiUnternull));
            end case;
            
         end loop UnterdateienSchleife;
         
         Ada.Wide_Wide_Text_IO.Close (File => DateiUnternull);
         
         NameBeschreibung (RasseExtern => RasseSchleifenwert);
         Städtenamen (RasseExtern => RasseSchleifenwert);
         Forschungen (RasseExtern => RasseSchleifenwert);
         Einheiten (RasseExtern => RasseSchleifenwert);
         Gebäude (RasseExtern => RasseSchleifenwert);
         
      end loop RassenSchleife;
      
   end RassentexteEinlesen;
   
   
   
   -- Hier und auch bei den anderen Einlesevorgängen noch einen Check einbauen ob die Dateien wirklich existieren bevor ich sie einlese? äöü
   procedure NameBeschreibung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Ada.Wide_Wide_Text_IO.Open (File => DateiNameBeschreibung,
                                  Mode => Ada.Wide_Wide_Text_IO.In_File,
                                  Name => Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (Item => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => Rassendateien (1))));
      
      NameBeschreibungSchleife:
      for NameBeschreibungSchleifenwert in Rassentexte.NameBeschreibungArray'Range (2) loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiNameBeschreibung,
                                                    AktuelleZeileExtern => Positive (NameBeschreibungSchleifenwert))
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.NameBeschreibung - 0-Datei zu kurz.");
               
            when False =>
               Rassentexte.NameBeschreibung (RasseExtern, NameBeschreibungSchleifenwert)
                 := Ada.Strings.Wide_Wide_Unbounded.To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiNameBeschreibung));
         end case;
         
      end loop NameBeschreibungSchleife;
      
      Ada.Wide_Wide_Text_IO.Close (File => DateiNameBeschreibung);
      
   end NameBeschreibung;
   
   
   
   procedure Städtenamen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Ada.Wide_Wide_Text_IO.Open (File => DateiStädtenamen,
                                  Mode => Ada.Wide_Wide_Text_IO.In_File,
                                  Name => Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (Item => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => Rassendateien (2))));
      
      StädtenamenSchleife:
      for StädtenamenSchleifenwert in Rassentexte.StädtenamenArray'Range (2) loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiStädtenamen,
                                                    AktuelleZeileExtern => Positive (StädtenamenSchleifenwert))
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Städtenamen - 0-Datei zu kurz.");
               
            when False =>
               Rassentexte.Städtenamen (RasseExtern, StädtenamenSchleifenwert)
                 := Ada.Strings.Wide_Wide_Unbounded.To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiStädtenamen));
         end case;
         
      end loop StädtenamenSchleife;
      
      Ada.Wide_Wide_Text_IO.Close (File => DateiStädtenamen);
            
   end Städtenamen;
   
   
   
   procedure Forschungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleZeile := 1;
      
      Ada.Wide_Wide_Text_IO.Open (File => DateiForschungen,
                                  Mode => Ada.Wide_Wide_Text_IO.In_File,
                                  Name => Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (Item => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => Rassendateien (3))));
      
      ForschungenSchleife:
      for ForschungenSchleifenwert in Rassentexte.ForschungenArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Rassentexte.ForschungenArray'Range (3) loop
         
            case
              EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiForschungen,
                                                       AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Forschungen - 0-Datei zu kurz.");
               
               when False =>
                  Rassentexte.Forschungen (RasseExtern, ForschungenSchleifenwert, TextSchleifenwert)
                    := Ada.Strings.Wide_Wide_Unbounded.To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiForschungen));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop ForschungenSchleife;
      
      Ada.Wide_Wide_Text_IO.Close (File => DateiForschungen);
      
   end Forschungen;
   
   
   
   procedure Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleZeile := 1;
      
      Ada.Wide_Wide_Text_IO.Open (File => DateiEinheiten,
                                  Mode => Ada.Wide_Wide_Text_IO.In_File,
                                  Name => Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (Item => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => Rassendateien (4))));
      
      EinheitenSchleife:
      for EinheitSchleifenwert in Rassentexte.EinheitenArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Rassentexte.EinheitenArray'Range (3) loop
         
            case
              EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiEinheiten,
                                                       AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Einheiten - 0-Datei zu kurz.");
               
               when False =>
                  Rassentexte.Einheiten (RasseExtern, EinheitSchleifenwert, TextSchleifenwert)
                    := Ada.Strings.Wide_Wide_Unbounded.To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiEinheiten));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop EinheitenSchleife;
      
      Ada.Wide_Wide_Text_IO.Close (File => DateiEinheiten);
      
   end Einheiten;
   
   
   
   procedure Gebäude
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleZeile := 1;
      
      Ada.Wide_Wide_Text_IO.Open (File => DateiGebäude,
                                  Mode => Ada.Wide_Wide_Text_IO.In_File,
                                  Name => Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (Item => Ada.Strings.Wide_Wide_Unbounded.To_Wide_Wide_String (Source => Rassendateien (5))));
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in Rassentexte.GebäudeArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Rassentexte.GebäudeArray'Range (3) loop
         
            case
              EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiGebäude,
                                                       AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenRassentexte.Gebäude - 0-Datei zu kurz.");
               
               when False =>
                  Rassentexte.Gebäude (RasseExtern, GebäudeSchleifenwert, TextSchleifenwert)
                    := Ada.Strings.Wide_Wide_Unbounded.To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiGebäude));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop GebäudeSchleife;
      
      Ada.Wide_Wide_Text_IO.Close (File => DateiGebäude);
      
   end Gebäude;

end EinlesenRassentexte;
