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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiEins,
                                                            AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                            DateinameExtern     => "EinlesenSpeziestexteLogik.SpeziestexteEinlesen")
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
                                    DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & EinlesenAllgemeinesLogik.TextEinlesen (DateiExtern         => DateiEins,
                                                                                                                                            AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                                                                                                            DateinameExtern     => "EinlesenSpeziestexteLogik.SpeziestexteEinlesen"));
                  
               elsif
                 Teilerrest = 2
               then
                  Städtenamen (SpeziesExtern   => AktuelleSpezies,
                                DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & EinlesenAllgemeinesLogik.TextEinlesen (DateiExtern         => DateiEins,
                                                                                                                                        AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                                                                                                        DateinameExtern     => "EinlesenSpeziestexteLogik.SpeziestexteEinlesen"));
                  
               elsif
                 Teilerrest = 3
               then
                  Forschungen (SpeziesExtern   => AktuelleSpezies,
                               DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & EinlesenAllgemeinesLogik.TextEinlesen (DateiExtern         => DateiEins,
                                                                                                                                       AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                                                                                                       DateinameExtern     => "EinlesenSpeziestexteLogik.SpeziestexteEinlesen"));
                  
               elsif
                 Teilerrest = 4
               then
                  Einheiten (SpeziesExtern   => AktuelleSpezies,
                             DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & EinlesenAllgemeinesLogik.TextEinlesen (DateiExtern         => DateiEins,
                                                                                                                                     AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                                                                                                     DateinameExtern     => "EinlesenSpeziestexteLogik.SpeziestexteEinlesen"));
               
               else
                  Gebäude (SpeziesExtern   => AktuelleSpezies,
                            DateinameExtern => To_Wide_Wide_String (Source => Dateienpfad) & EinlesenAllgemeinesLogik.TextEinlesen (DateiExtern         => DateiEins,
                                                                                                                                    AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                                                                                                    DateinameExtern     => "EinlesenSpeziestexteLogik.SpeziestexteEinlesen"));
                  
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiNameBeschreibung,
                                                            AktuelleZeileExtern => NameBeschreibungSchleifenwert,
                                                            DateinameExtern     => "EinlesenSpeziestexteLogik.NameBeschreibung")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.NameBeschreibung: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & NameBeschreibungSchleifenwert'Wide_Wide_Image);
               exit NameBeschreibungSchleife;
               
            when False =>
               Speziestexte.NameBeschreibung (SpeziesExtern, NameBeschreibungSchleifenwert) := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiNameBeschreibung,
                                                                                                                                                AktuelleZeileExtern => NameBeschreibungSchleifenwert,
                                                                                                                                                DateinameExtern     => "EinlesenSpeziestexteLogik.NameBeschreibung");
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
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Städtenamen: Es fehlt: " & DateinameExtern);
            return;
            
         when True =>
            Open (File => DateiStädtenamen,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
      end case;
      
      StädtenamenSchleife:
      for StädtenamenSchleifenwert in Speziestexte.StädtenamenArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiStädtenamen,
                                                            AktuelleZeileExtern => Positive (StädtenamenSchleifenwert),
                                                            DateinameExtern     => "EinlesenSpeziestexteLogik.Städtenamen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Städtenamen: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & StädtenamenSchleifenwert'Wide_Wide_Image);
               exit StädtenamenSchleife;
               
            when False =>
               Speziestexte.Städtenamen (SpeziesExtern, StädtenamenSchleifenwert) := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiStädtenamen,
                                                                                                                                        AktuelleZeileExtern => Positive (StädtenamenSchleifenwert),
                                                                                                                                        DateinameExtern     => "EinlesenSpeziestexteLogik.Städtenamen");
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
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Forschungen: Es fehlt: " & DateinameExtern);
            return;
            
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiForschungen,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
      end case;
      
      ForschungenSchleife:
      for ForschungenSchleifenwert in Speziestexte.ForschungenArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Speziestexte.ForschungenArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiForschungen,
                                                               AktuelleZeileExtern => AktuelleZeile,
                                                               DateinameExtern     => "EinlesenSpeziestexteLogik.Forschungen")
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Forschungen: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
                  exit ForschungenSchleife;
               
               when False =>
                  Speziestexte.Forschungen (SpeziesExtern, ForschungenSchleifenwert, TextSchleifenwert) := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiForschungen,
                                                                                                                                                            AktuelleZeileExtern => AktuelleZeile,
                                                                                                                                                            DateinameExtern     => "EinlesenSpeziestexteLogik.Forschungen");
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
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Einheiten: Es fehlt: " & DateinameExtern);
            return;
            
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiEinheiten,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
      end case;
      
      EinheitenSchleife:
      for EinheitSchleifenwert in Speziestexte.EinheitenArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Speziestexte.EinheitenArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiEinheiten,
                                                               AktuelleZeileExtern => AktuelleZeile,
                                                               DateinameExtern     => "EinlesenSpeziestexteLogik.Einheiten")
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Einheiten: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
                  exit EinheitenSchleife;
               
               when False =>
                  Speziestexte.Einheiten (SpeziesExtern, EinheitSchleifenwert, TextSchleifenwert) := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiEinheiten,
                                                                                                                                                      AktuelleZeileExtern => AktuelleZeile,
                                                                                                                                                      DateinameExtern     => "EinlesenSpeziestexteLogik.Einheiten");
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
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Gebäude: Es fehlt: " & DateinameExtern);
            return;
            
         when True =>
            AktuelleZeile := 1;
      
            Open (File => DateiGebäude,
                  Mode => In_File,
                  Name => Encode (Item => DateinameExtern),
                  Form => "WCEM=8");
      end case;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in Speziestexte.GebäudeArray'Range (2) loop
         TextSchleife:
         for TextSchleifenwert in Speziestexte.GebäudeArray'Range (3) loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiGebäude,
                                                               AktuelleZeileExtern => AktuelleZeile,
                                                               DateinameExtern     => "EinlesenSpeziestexteLogik.Gebäude")
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSpeziestexteLogik.Gebäude: Fehlende Zeilen: " & DateinameExtern & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
                  exit GebäudeSchleife;
               
               when False =>
                  Speziestexte.Gebäude (SpeziesExtern, GebäudeSchleifenwert, TextSchleifenwert) := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiGebäude,
                                                                                                                                                      AktuelleZeileExtern => AktuelleZeile,
                                                                                                                                                      DateinameExtern     => "EinlesenSpeziestexteLogik.Gebäude");
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop TextSchleife;
      end loop GebäudeSchleife;
      
      Close (File => DateiGebäude);
      
   end Gebäude;

end EinlesenSpeziestexteLogik;
