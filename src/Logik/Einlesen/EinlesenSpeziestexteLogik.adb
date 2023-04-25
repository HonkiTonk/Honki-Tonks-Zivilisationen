with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;

with Speziestexte;
with VerzeichnisKonstanten;

with LeseOptionen;

with EinlesenAllgemeinesLogik;
with Fehlermeldungssystem;

package body EinlesenSpeziestexteLogik is

   procedure SpeziestexteEinlesen
   is begin
            
      Einspfad := VerzeichnisKonstanten.Sprachenordner & LeseOptionen.Sprache & "/1";
      
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Einspfad)))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.SpeziestexteEinlesen: Es fehlt: " & To_Wide_Wide_String (Source => Einspfad));
            return;
            
         when True =>
            AktuelleSpezies := SpeziesDatentypen.Spezies_Verwendet_Enum'First;
            Dateienpfad := VerzeichnisKonstanten.Sprachenordner & LeseOptionen.Sprache & "/";
            
            Open (File => DateiEins,
                  Mode => In_File,
                  Name => Encode (Item => To_Wide_Wide_String (Source => Einspfad)),
                  Form => "WCEM=8");
      end case;
            
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in 1 .. 5 * SpeziesDatentypen.SpeziesnummernVorhanden'Last loop

         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiEins,
                                                           AktuelleZeileExtern => WelcheDateienSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.SpeziestexteEinlesen: Fehlende Zeilen, aktuelle Zeile: " & WelcheDateienSchleifenwert'Wide_Wide_Image);
               exit EinlesenSchleife;
               
            when False =>
               Teilerrest := WelcheDateienSchleifenwert mod 5;
               
               if
                 Teilerrest = 1
               then
                  NameBeschreibung (SpeziesExtern   => AktuelleSpezies,
                                    DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & Get_Line (File => DateiEins));
                  
               elsif
                 Teilerrest = 2
               then
                  Städtenamen (SpeziesExtern   => AktuelleSpezies,
                                DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & Get_Line (File => DateiEins));
                  
               elsif
                 Teilerrest = 3
               then
                  Forschungen (SpeziesExtern   => AktuelleSpezies,
                               DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & Get_Line (File => DateiEins));
                  
               elsif
                 Teilerrest = 4
               then
                  Einheiten (SpeziesExtern   => AktuelleSpezies,
                             DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & Get_Line (File => DateiEins));
               
               else
                  Gebäude (SpeziesExtern   => AktuelleSpezies,
                            DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & Get_Line (File => DateiEins));
                  
                  case
                    AktuelleSpezies
                  is
                     when SpeziesDatentypen.Spezies_Verwendet_Enum'Last =>
                        null;
                        
                     when others =>
                        AktuelleSpezies := SpeziesDatentypen.Spezies_Enum'Succ (AktuelleSpezies);
                  end case;
               end if;
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiEins);
      
   end SpeziestexteEinlesen;
   
   
   
   -- Wäre es nicht immer besser die Rückgabeposition bei True/False cases zuerst zu positionieren? äöü
   procedure NameBeschreibung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.NameBeschreibung: Es fehlt: " & DateinameExtern);
            return;
            
         when True =>
            Open (File => DateiNameBeschreibung,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
      end case;
      
      NameBeschreibungSchleife:
      for NameBeschreibungSchleifenwert in Speziestexte.NameBeschreibungArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiNameBeschreibung,
                                                           AktuelleZeileExtern => Positive (NameBeschreibungSchleifenwert))
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.NameBeschreibung: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & NameBeschreibungSchleifenwert'Wide_Wide_Image);
               exit NameBeschreibungSchleife;
               
            when False =>
               Speziestexte.NameBeschreibung (SpeziesExtern, NameBeschreibungSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNameBeschreibung));
         end case;
         
      end loop NameBeschreibungSchleife;
      
      Close (File => DateiNameBeschreibung);
      
   end NameBeschreibung;
   
   
   
   procedure Städtenamen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            Open (File => DateiStädtenamen,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Städtenamen: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      StädtenamenSchleife:
      for StädtenamenSchleifenwert in Speziestexte.StädtenamenArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiStädtenamen,
                                                           AktuelleZeileExtern => Positive (StädtenamenSchleifenwert))
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Städtenamen: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & StädtenamenSchleifenwert'Wide_Wide_Image);
               exit StädtenamenSchleife;
               
            when False =>
               Speziestexte.Städtenamen (SpeziesExtern, StädtenamenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiStädtenamen));
         end case;
         
      end loop StädtenamenSchleife;
      
      Close (File => DateiStädtenamen);
            
   end Städtenamen;
   
   
   
   procedure Forschungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiForschungen,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Forschungen: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      ForschungenSchleife:
      for ForschungenSchleifenwert in Speziestexte.ForschungenArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Speziestexte.ForschungenArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiForschungen,
                                                              AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Forschungen: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
                  exit ForschungenSchleife;
               
               when False =>
                  Speziestexte.Forschungen (SpeziesExtern, ForschungenSchleifenwert, TextSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiForschungen));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop ForschungenSchleife;
      
      Close (File => DateiForschungen);
      
   end Forschungen;
   
   
   
   procedure Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiEinheiten,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Einheiten: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      EinheitenSchleife:
      for EinheitSchleifenwert in Speziestexte.EinheitenArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Speziestexte.EinheitenArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiEinheiten,
                                                              AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Einheiten: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
                  exit EinheitenSchleife;
               
               when False =>
                  Speziestexte.Einheiten (SpeziesExtern, EinheitSchleifenwert, TextSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiEinheiten));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop EinheitenSchleife;
      
      Close (File => DateiEinheiten);
      
   end Einheiten;
   
   
   
   procedure Gebäude
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => DateinameExtern))
      is
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiGebäude,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Gebäude: Es fehlt: " & DateinameExtern);
            return;
      end case;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in Speziestexte.GebäudeArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Speziestexte.GebäudeArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiGebäude,
                                                              AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Gebäude: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
                  exit GebäudeSchleife;
               
               when False =>
                  Speziestexte.Gebäude (SpeziesExtern, GebäudeSchleifenwert, TextSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiGebäude));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop GebäudeSchleife;
      
      Close (File => DateiGebäude);
      
   end Gebäude;

end EinlesenSpeziestexteLogik;
