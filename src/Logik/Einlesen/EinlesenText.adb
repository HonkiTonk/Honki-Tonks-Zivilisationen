pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with OptionenVariablen;
with RassenDatentypen;
with TextKonstanten;

with Warnung;
with EinlesenAllgemein;
with Fehler;

package body EinlesenText is

   procedure EinlesenDateien
   is begin
            
      case
        Exists (Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & "/0")
      is
         when True =>
            TextdateienEinlesen := (others => TextKonstanten.LeerUnboundedString);
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & "/0");

         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien - 0-Datei fehlt.");
            return;
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in TextdateienEinlesen'Range loop

         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheDateienSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien - Nicht genug Zeilen in 0-Datei.");
               
            when False =>
               TextdateienEinlesen (WelcheDateienSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiTextEinlesen);
      
      EinlesenTexte;
      
   end EinlesenDateien;
   
   
   
   procedure EinlesenTexte
   is begin
      
      TexteSchleife:
      for WelcheDateiSchleifenwert in TextdateienEinlesen'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateiSchleifenwert))))
         is
            when True =>
               Open (File => DateiTextEinlesen,
                     Mode => In_File,
                     Name => Encode (Item => To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateiSchleifenwert))));
               
               EinlesenAufteilen (WelcherDateiExtern => WelcheDateiSchleifenwert);
            
               Close (File => DateiTextEinlesen);
               
            when False =>
               null;
         end case;
         
      end loop TexteSchleife;
      
   end EinlesenTexte;
   
   
   
   procedure EinlesenAufteilen
     (WelcherDateiExtern : in Positive)
   is begin
      
      case
        WelcherDateiExtern
      is
         when 1 =>
            Hauptmenü;
               
         when 2 =>
            Spielmenü;
               
         when 3 =>
            Optionsmenü;
               
         when 4 =>
            Grafikmenü;
               
         when 5 =>
            Soundmenü;
               
         when 6 =>
            Steuerungmenü;
               
         when 7 =>
            Sonstigesmenü;
               
         when 8 =>
            Kartengröße;
               
         when 9 =>
            Kartenart;
               
         when 10 =>
            Kartentemperatur;
               
         when 11 =>
            Rassenauswahl;
               
         when 12 =>
            Schwierigkeitsgrad;
               
         when 13 =>
            Kartenform;
               
         when 14 =>
            Ressourcenmenge;
               
         when 15 =>
            Rassen;
               
         when 16 =>
            Kartenfelder;
               
         when 17 =>
            Einheiten;
               
         when 18 =>
            Verbesserungen;
               
         when 19 =>
            Gebäude;
               
         when 20 =>
            Forschungen;
               
         when 21 =>
            Beschäftigungen;
               
         when 22 =>
            StädtenamenKI;
               
         when 23 =>
            Debugmenü;
               
         when 24 =>
            AllgemeineInformationen;
               
         when 25 =>
            Würdigung;
               
         when 26 =>
            Diplomatiemenü;
               
         when 27 =>
            DiplomatieKI;
               
         when 28 =>
            Endmeldungen;
               
         when 29 =>
            Handelsmenü;
               
         when 30 =>
            DiplomatieStatus;
               
         when 31 =>
            Angebot;
               
         when 32 =>
            Fehlermeldung;
               
         when 33 =>
            Ladezeit;
               
         when 34 =>
            Frage;
               
         when 35 =>
            ZeugSachen;
               
         when 36 =>
            Editoren;
               
         when 37 =>
            Wege;
               
         when 38 =>
            Kartenflüsse;
               
         when 39 =>
            Kartenressourcen;
               
         when 40 =>
            Einstellungen;
               
         when 41 =>
            Kartenpole;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "EinlesenText.EinlesenAufteilen - Mehr Dateien eingelesen als möglich.");
      end case;
      
   end EinlesenAufteilen;
   
   
   
   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Hauptmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Hauptmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Hauptmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop HauptmenüSchleife;
      
   end Hauptmenü;
   
   
   
   procedure Spielmenü
   is begin
      
      SpielmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Spielmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Spielmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Spielmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SpielmenüSchleife;
      
   end Spielmenü;
   
   
   
   procedure Optionsmenü
   is begin
      
      OptionsmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Optionsmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Optionsmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Optionsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop OptionsmenüSchleife;
      
   end Optionsmenü;
   
   
   
   procedure Grafikmenü
   is begin
      
      GrafikmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Grafikmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Grafikmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Grafikmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop GrafikmenüSchleife;
      
   end Grafikmenü;
   
   
   
   procedure Soundmenü
   is begin
      
      SoundmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Soundmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Soundmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Soundmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SoundmenüSchleife;
      
   end Soundmenü;
   
   
   
   procedure Steuerungmenü
   is begin
      
      SteuerungmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Steuerungmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Steuerungmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Steuerungmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SteuerungmenüSchleife;
      
   end Steuerungmenü;
   
   
   
   procedure Sonstigesmenü
   is begin
      
      SonstigesmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Sonstigesmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Sonstigesmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Sonstigesmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SonstigesmenüSchleife;
      
   end Sonstigesmenü;
   
   
   
   procedure Kartengröße
   is begin
      
      KartengrößeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartengröße'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartengröße -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Kartengröße (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartengrößeSchleife;
      
   end Kartengröße;
   
   
   
   procedure Kartenart
   is begin
      
      KartenartSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenart'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenart -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Kartenart (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartenartSchleife;
      
   end Kartenart;
   
   
   
   procedure Kartentemperatur
   is begin
      
      KartentemperaturSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartentemperatur'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartentemperatur -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Kartentemperatur (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartentemperaturSchleife;
      
   end Kartentemperatur;
   
   
   
   procedure Rassenauswahl
   is begin
      
      RassenauswahlSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Rassenauswahl'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Rassenauswahl -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Rassenauswahl (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop RassenauswahlSchleife;
      
   end Rassenauswahl;
   
   
   
   procedure Schwierigkeitsgrad
   is begin
      
      SchwierigkeitsgradSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Schwierigkeitsgrad'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Schwierigkeitsgrad -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Schwierigkeitsgrad (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end Schwierigkeitsgrad;
   
   
   
   procedure Kartenform
   is begin
      
      KartenformSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenform'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenform -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Kartenform (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartenformSchleife;
      
   end Kartenform;
   
   
   
   procedure Ressourcenmenge
   is begin
      
      RessourcenmengeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Ressourcenmenge'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Ressourcenmenge -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Ressourcenmenge (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop RessourcenmengeSchleife;
      
   end Ressourcenmenge;
   
   
   
   procedure Rassen
   is begin
      
      RassenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Rassen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Rassen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Rassen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop RassenSchleife;
      
   end Rassen;
   
   
   
   procedure Kartenfelder
   is begin
      
      KartenfelderSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenfelder'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenfelder -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Kartenfelder (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartenfelderSchleife;
      
   end Kartenfelder;
   
   
   
   procedure Einheiten
   is begin
      
      EinheitenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Einheiten'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Einheiten -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Einheiten (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop EinheitenSchleife;
      
   end Einheiten;
   
   
   
   procedure Verbesserungen
   is begin
      
      VerbesserungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Verbesserungen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Verbesserungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Verbesserungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop VerbesserungenSchleife;
      
   end Verbesserungen;
   
   
   
   procedure Gebäude
   is begin
      
      GebäudeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Gebäude'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Gebäude -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Gebäude (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop GebäudeSchleife;
      
   end Gebäude;
   
   
   
   procedure Forschungen
   is begin
      
      ForschungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Forschungen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Forschungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Forschungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop ForschungenSchleife;
      
   end Forschungen;
   
   
   
   procedure Beschäftigungen
   is begin
      
      BeschäftigungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Beschäftigungen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Beschäftigungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Beschäftigungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure StädtenamenKI
   is begin
      
      AktuelleZeile := 1;
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         StädtenamenKISchleife:
         for WelcheZeileSchleifenwert in GlobaleTexte.StädtenamenKI'Range (2) loop
         
            case
              EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                       AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.StädtenamenKI -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
               when False =>
                  GlobaleTexte.StädtenamenKI (RasseSchleifenwert, WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
            end case;
            
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop StädtenamenKISchleife;
      end loop RassenSchleife;
      
   end StädtenamenKI;
   
   
   
   procedure Debugmenü
   is begin
      
      DebugmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Debugmenü'Range loop
                  
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Debugmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Debugmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop DebugmenüSchleife;
      
   end Debugmenü;
   
   
   
   procedure AllgemeineInformationen
   is begin
      
      AllgemeineInformationenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.AllgemeineInformationen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.AllgemeineInformationen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.AllgemeineInformationen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop AllgemeineInformationenSchleife;
      
   end AllgemeineInformationen;
   
   
   
   procedure Würdigung
   is begin
      
      WürdigungSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Würdigung'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Würdigung -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Würdigung (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop WürdigungSchleife;
      
   end Würdigung;
   
   
   
   procedure Diplomatiemenü
   is begin
      
      DiplomatiemenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Diplomatiemenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Diplomatiemenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Diplomatiemenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop DiplomatiemenüSchleife;
      
   end Diplomatiemenü;
   
   
   
   procedure DiplomatieKI
   is begin
      
      DiplomatieKISchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.DiplomatieKI'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.DiplomatieKI -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.DiplomatieKI (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop DiplomatieKISchleife;
      
   end DiplomatieKI;
   
   
   
   procedure Endmeldungen
   is begin
      
      EndmeldungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Endmeldungen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Endmeldungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Endmeldungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop EndmeldungenSchleife;
      
   end Endmeldungen;
   
   
   
   procedure Handelsmenü
   is begin
      
      HandelsmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Handelsmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Handelsmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Handelsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop HandelsmenüSchleife;
      
   end Handelsmenü;
   
   
   
   procedure DiplomatieStatus
   is begin
      
      DiplomatieStatusSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.DiplomatieStatus'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.DiplomatieStatus -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.DiplomatieStatus (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop DiplomatieStatusSchleife;
      
   end DiplomatieStatus;
   
   
   
   procedure Angebot
   is begin
      
      AngebotSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Angebot'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Spielmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Angebot (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop AngebotSchleife;
      
   end Angebot;
   
   
   
   procedure Fehlermeldung
   is begin
      
      FehlermeldungSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Fehlermeldung'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Fehlermeldung -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Fehlermeldung (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop FehlermeldungSchleife;
      
   end Fehlermeldung;
   
   
   
   procedure Ladezeit
   is begin
      
      LadezeitSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Ladezeit'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Ladezeit -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Ladezeit (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop LadezeitSchleife;
      
   end Ladezeit;
   
   
   
   procedure Frage
   is begin
      
      FrageSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Frage'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Frage -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Frage (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop FrageSchleife;
      
   end Frage;
   
   
   
   procedure ZeugSachen
   is begin
      
      ZeugSachenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Zeug'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.ZeugSachen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Zeug (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop ZeugSachenSchleife;
      
   end ZeugSachen;
      
   
   
   procedure Editoren
   is begin
      
      EditorenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Editoren'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Editoren -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Editoren (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop EditorenSchleife;
      
   end Editoren;
      
   
   
   procedure Wege
   is begin
      
      WegeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Wege'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Wege -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Wege (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop WegeSchleife;
      
   end Wege;
      
   
   
   procedure Kartenflüsse
   is begin
      
      WegeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenflüsse'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenflüsse -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Kartenflüsse (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop WegeSchleife;
      
   end Kartenflüsse;
      
   
   
   procedure Kartenressourcen
   is begin
      
      WegeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenressourcen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenressourcen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Kartenressourcen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop WegeSchleife;
      
   end Kartenressourcen;
   
   
   
   procedure Einstellungen
   is begin
      
      EinstellungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Einstellungsmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Einstellungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Einstellungsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop EinstellungenSchleife;
      
   end Einstellungen;
   
   
   
   procedure Kartenpole
   is begin
      
      KartenpoleSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenpole'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenpole -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Kartenpole (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartenpoleSchleife;
      
   end Kartenpole;

end EinlesenText;
