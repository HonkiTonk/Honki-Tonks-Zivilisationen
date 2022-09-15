pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;

with OptionenVariablen;
with VerzeichnisKonstanten;
with Menuetexte;
with Kartentexte;
with GlobaleTexte;
with Meldungstexte;
with Befehlstexte;

with Warnung;
with EinlesenAllgemein;
with Fehler;

package body EinlesenText is

   procedure EinlesenDateien
   is begin
            
      case
        Exists (Name => VerzeichnisKonstanten.SprachenStrich & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & VerzeichnisKonstanten.NullDatei)
      is
         when True =>
            Open (File => DateiVerzeichnisse,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SprachenStrich & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & VerzeichnisKonstanten.NullDatei);

         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien - 0-Datei fehlt.");
            return;
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in TextdateienEinlesen'Range loop

         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                    AktuelleZeileExtern => WelcheDateienSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien - 0-Datei zu kurz.");
               
            when False =>
               EinlesenAufteilen (WelcheDateiExtern => WelcheDateienSchleifenwert,
                                  VerzeichnisExtern => Get_Line (File => DateiVerzeichnisse));
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiVerzeichnisse);
      
   end EinlesenDateien;
   
   
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => VerzeichnisExtern))
      is
         when True =>
            Open (File => DateiText,
                  Mode => In_File,
                  Name => Encode (Item => VerzeichnisExtern));
            
         when False =>
            -- Warnung einbauen. äöü
            return;
      end case;
      
      case
        WelcheDateiExtern
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
            Kartenfelder;
               
         when 16 =>
            Verbesserungen;
               
         when 17 =>
            Beschäftigungen;
               
         when 18 =>
            Debugmenü;
               
         when 19 =>
            AllgemeineInformationen;
               
         when 20 =>
            Würdigung;
               
         when 21 =>
            Diplomatiemenü;
               
         when 22 =>
            DiplomatieKI;
               
         when 23 =>
            Endmeldungen;
               
         when 24 =>
            Handelsmenü;
               
         when 25 =>
            DiplomatieStatus;
               
         when 26 =>
            Angebot;
               
         when 27 =>
            Fehlermeldung;
               
         when 28 =>
            Ladezeit;
               
         when 29 =>
            Frage;
               
         when 30 =>
            ZeugSachen;
               
         when 31 =>
            Editoren;
               
         when 32 =>
            Wege;
               
         when 33 =>
            Kartenflüsse;
               
         when 34 =>
            Kartenressourcen;
               
         when 35 =>
            Einstellungen;
               
         when 36 =>
            Kartenpole;
            
         when 37 =>
            Stadtbefehle;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "EinlesenText.EinlesenAufteilen - Mehr Dateien eingelesen als möglich.");
      end case;
            
      Close (File => DateiText);
      
   end EinlesenAufteilen;
   
   
   
   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Hauptmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Hauptmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Hauptmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop HauptmenüSchleife;
      
   end Hauptmenü;
   
   
   
   procedure Spielmenü
   is begin
      
      SpielmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Spielmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Spielmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Spielmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop SpielmenüSchleife;
      
   end Spielmenü;
   
   
   
   procedure Optionsmenü
   is begin
      
      OptionsmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Optionsmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Optionsmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Optionsmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop OptionsmenüSchleife;
      
   end Optionsmenü;
   
   
   
   procedure Grafikmenü
   is begin
      
      GrafikmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Grafikmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Grafikmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Grafikmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop GrafikmenüSchleife;
      
   end Grafikmenü;
   
   
   
   procedure Soundmenü
   is begin
      
      SoundmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Soundmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Soundmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Soundmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop SoundmenüSchleife;
      
   end Soundmenü;
   
   
   
   procedure Steuerungmenü
   is begin
      
      SteuerungmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Steuerungmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Steuerungmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Steuerungmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop SteuerungmenüSchleife;
      
   end Steuerungmenü;
   
   
   
   procedure Sonstigesmenü
   is begin
      
      SonstigesmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Sonstigesmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Sonstigesmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Sonstigesmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop SonstigesmenüSchleife;
      
   end Sonstigesmenü;
   
   
   
   procedure Kartengröße
   is begin
      
      KartengrößeSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartengröße'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartengröße -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartengröße (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop KartengrößeSchleife;
      
   end Kartengröße;
   
   
   
   procedure Kartenart
   is begin
      
      KartenartSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartenart'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenart -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartenart (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop KartenartSchleife;
      
   end Kartenart;
   
   
   
   procedure Kartentemperatur
   is begin
      
      KartentemperaturSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartentemperatur'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartentemperatur -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartentemperatur (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop KartentemperaturSchleife;
      
   end Kartentemperatur;
   
   
   
   procedure Rassenauswahl
   is begin
      
      RassenauswahlSchleife:
      for ZeileSchleifenwert in Menuetexte.Rassenauswahl'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Rassenauswahl -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Rassenauswahl (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop RassenauswahlSchleife;
      
   end Rassenauswahl;
   
   
   
   procedure Schwierigkeitsgrad
   is begin
      
      SchwierigkeitsgradSchleife:
      for ZeileSchleifenwert in Menuetexte.Schwierigkeitsgrad'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Schwierigkeitsgrad -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Schwierigkeitsgrad (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end Schwierigkeitsgrad;
   
   
   
   procedure Kartenform
   is begin
      
      KartenformSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartenform'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenform -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartenform (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop KartenformSchleife;
      
   end Kartenform;
   
   
   
   procedure Ressourcenmenge
   is begin
      
      RessourcenmengeSchleife:
      for ZeileSchleifenwert in Menuetexte.Ressourcenmenge'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Ressourcenmenge -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Ressourcenmenge (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop RessourcenmengeSchleife;
      
   end Ressourcenmenge;
   
   
   
   procedure Kartenfelder
   is begin
      
      KartenfelderSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenfelder'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenfelder -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Kartenfelder (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop KartenfelderSchleife;
      
   end Kartenfelder;
   
   
   
   procedure Verbesserungen
   is begin
      
      VerbesserungenSchleife:
      for ZeileSchleifenwert in Kartentexte.Verbesserungen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Verbesserungen -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Verbesserungen (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop VerbesserungenSchleife;
      
   end Verbesserungen;
   
   
   
   procedure Beschäftigungen
   is begin
      
      BeschäftigungenSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Beschäftigungen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Beschäftigungen -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Beschäftigungen (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure Debugmenü
   is begin
      
      DebugmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Debugmenü'Range loop
                  
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Debugmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Debugmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop DebugmenüSchleife;
      
   end Debugmenü;
   
   
   
   procedure AllgemeineInformationen
   is begin
      
      AllgemeineInformationenSchleife:
      for ZeileSchleifenwert in GlobaleTexte.AllgemeineInformationen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.AllgemeineInformationen -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.AllgemeineInformationen (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop AllgemeineInformationenSchleife;
      
   end AllgemeineInformationen;
   
   
   
   procedure Würdigung
   is begin
      
      WürdigungSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Würdigung'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Würdigung -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Würdigung (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop WürdigungSchleife;
      
   end Würdigung;
   
   
   
   procedure Diplomatiemenü
   is begin
      
      DiplomatiemenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Diplomatiemenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Diplomatiemenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Diplomatiemenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop DiplomatiemenüSchleife;
      
   end Diplomatiemenü;
   
   
   
   procedure DiplomatieKI
   is begin
      
      DiplomatieKISchleife:
      for ZeileSchleifenwert in GlobaleTexte.DiplomatieKI'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.DiplomatieKI -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.DiplomatieKI (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop DiplomatieKISchleife;
      
   end DiplomatieKI;
   
   
   
   procedure Endmeldungen
   is begin
      
      EndmeldungenSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Endmeldungen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Endmeldungen -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Endmeldungen (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop EndmeldungenSchleife;
      
   end Endmeldungen;
   
   
   
   procedure Handelsmenü
   is begin
      
      HandelsmenüSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Handelsmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Handelsmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Handelsmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop HandelsmenüSchleife;
      
   end Handelsmenü;
   
   
   
   procedure DiplomatieStatus
   is begin
      
      DiplomatieStatusSchleife:
      for ZeileSchleifenwert in GlobaleTexte.DiplomatieStatus'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.DiplomatieStatus -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop DiplomatieStatusSchleife;
      
   end DiplomatieStatus;
   
   
   
   procedure Angebot
   is begin
      
      AngebotSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Angebot'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Spielmenü -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Angebot (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop AngebotSchleife;
      
   end Angebot;
   
   
   
   procedure Fehlermeldung
   is begin
      
      FehlermeldungSchleife:
      for ZeileSchleifenwert in Meldungstexte.Meldung'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Fehlermeldung -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Meldungstexte.Meldung (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop FehlermeldungSchleife;
      
   end Fehlermeldung;
   
   
   
   procedure Ladezeit
   is begin
      
      LadezeitSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Ladezeit'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Ladezeit -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Ladezeit (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop LadezeitSchleife;
      
   end Ladezeit;
   
   
   
   procedure Frage
   is begin
      
      FrageSchleife:
      for ZeileSchleifenwert in Meldungstexte.Frage'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Frage -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Meldungstexte.Frage (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop FrageSchleife;
      
   end Frage;
   
   
   
   procedure ZeugSachen
   is begin
      
      ZeugSachenSchleife:
      for ZeileSchleifenwert in Meldungstexte.Zeug'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.ZeugSachen -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Meldungstexte.Zeug (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop ZeugSachenSchleife;
      
   end ZeugSachen;
      
   
   
   procedure Editoren
   is begin
      
      EditorenSchleife:
      for ZeileSchleifenwert in Menuetexte.Editoren'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Editoren -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Editoren (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop EditorenSchleife;
      
   end Editoren;
      
   
   
   procedure Wege
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Wege'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Wege -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Wege (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop WegeSchleife;
      
   end Wege;
      
   
   
   procedure Kartenflüsse
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenflüsse'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenflüsse -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Kartenflüsse (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop WegeSchleife;
      
   end Kartenflüsse;
      
   
   
   procedure Kartenressourcen
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenressourcen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenressourcen -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Kartenressourcen (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop WegeSchleife;
      
   end Kartenressourcen;
   
   
   
   procedure Einstellungen
   is begin
      
      EinstellungenSchleife:
      for ZeileSchleifenwert in Menuetexte.Einstellungsmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Einstellungen -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Einstellungsmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop EinstellungenSchleife;
      
   end Einstellungen;
   
   
   
   procedure Kartenpole
   is begin
      
      KartenpoleSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartenpole'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenpole -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartenpole (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop KartenpoleSchleife;
      
   end Kartenpole;
   
   
   
   procedure Stadtbefehle
   is begin
      
      StadtbefehleSchleife:
      for ZeileSchleifenwert in Befehlstexte.Stadtbefehle'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                    AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Stadtbefehle -" & ZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Befehlstexte.Stadtbefehle (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop StadtbefehleSchleife;
      
   end Stadtbefehle;

end EinlesenText;
