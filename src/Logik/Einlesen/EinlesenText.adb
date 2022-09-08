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
with TextKonstanten;
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
            TextdateienEinlesen := (others => TextKonstanten.LeerUnboundedString);
            
            Ada.Wide_Wide_Text_IO.Open (File => DateiTextEinlesen,
                                        Mode => Ada.Wide_Wide_Text_IO.In_File,
                                        Name => VerzeichnisKonstanten.SprachenStrich & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & VerzeichnisKonstanten.NullDatei);

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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien - 0-Datei zu kurz.");
               
            when False =>
               TextdateienEinlesen (WelcheDateienSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;

      end loop EinlesenSchleife;

      Ada.Wide_Wide_Text_IO.Close (File => DateiTextEinlesen);
      
      EinlesenTexte;
      
   end EinlesenDateien;
   
   
   
   -- Hier und auch bei den anderen Einlesevorgängen noch einen Check einbauen ob die Dateien wirklich existieren bevor ich sie einlese? äöü
   procedure EinlesenTexte
   is begin
      
      TexteSchleife:
      for WelcheDateiSchleifenwert in TextdateienEinlesen'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateiSchleifenwert))))
         is
            when True =>
               Ada.Wide_Wide_Text_IO.Open (File => DateiTextEinlesen,
                                           Mode => Ada.Wide_Wide_Text_IO.In_File,
                                           Name => Encode (Item => To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateiSchleifenwert))));
               
               EinlesenAufteilen (WelcherDateiExtern => WelcheDateiSchleifenwert);
            
               Ada.Wide_Wide_Text_IO.Close (File => DateiTextEinlesen);
               
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
      
   end EinlesenAufteilen;
   
   
   
   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Hauptmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Hauptmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Hauptmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop HauptmenüSchleife;
      
   end Hauptmenü;
   
   
   
   procedure Spielmenü
   is begin
      
      SpielmenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Spielmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Spielmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Spielmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SpielmenüSchleife;
      
   end Spielmenü;
   
   
   
   procedure Optionsmenü
   is begin
      
      OptionsmenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Optionsmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Optionsmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Optionsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop OptionsmenüSchleife;
      
   end Optionsmenü;
   
   
   
   procedure Grafikmenü
   is begin
      
      GrafikmenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Grafikmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Grafikmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Grafikmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop GrafikmenüSchleife;
      
   end Grafikmenü;
   
   
   
   procedure Soundmenü
   is begin
      
      SoundmenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Soundmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Soundmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Soundmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SoundmenüSchleife;
      
   end Soundmenü;
   
   
   
   procedure Steuerungmenü
   is begin
      
      SteuerungmenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Steuerungmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Steuerungmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Steuerungmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SteuerungmenüSchleife;
      
   end Steuerungmenü;
   
   
   
   procedure Sonstigesmenü
   is begin
      
      SonstigesmenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Sonstigesmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Sonstigesmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Sonstigesmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SonstigesmenüSchleife;
      
   end Sonstigesmenü;
   
   
   
   procedure Kartengröße
   is begin
      
      KartengrößeSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Kartengröße'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartengröße -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartengröße (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartengrößeSchleife;
      
   end Kartengröße;
   
   
   
   procedure Kartenart
   is begin
      
      KartenartSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Kartenart'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenart -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartenart (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartenartSchleife;
      
   end Kartenart;
   
   
   
   procedure Kartentemperatur
   is begin
      
      KartentemperaturSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Kartentemperatur'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartentemperatur -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartentemperatur (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartentemperaturSchleife;
      
   end Kartentemperatur;
   
   
   
   procedure Rassenauswahl
   is begin
      
      RassenauswahlSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Rassenauswahl'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Rassenauswahl -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Rassenauswahl (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop RassenauswahlSchleife;
      
   end Rassenauswahl;
   
   
   
   procedure Schwierigkeitsgrad
   is begin
      
      SchwierigkeitsgradSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Schwierigkeitsgrad'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Schwierigkeitsgrad -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Schwierigkeitsgrad (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end Schwierigkeitsgrad;
   
   
   
   procedure Kartenform
   is begin
      
      KartenformSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Kartenform'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenform -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartenform (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartenformSchleife;
      
   end Kartenform;
   
   
   
   procedure Ressourcenmenge
   is begin
      
      RessourcenmengeSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Ressourcenmenge'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Ressourcenmenge -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Ressourcenmenge (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop RessourcenmengeSchleife;
      
   end Ressourcenmenge;
   
   
   
   procedure Kartenfelder
   is begin
      
      KartenfelderSchleife:
      for WelcheZeileSchleifenwert in Kartentexte.Kartenfelder'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenfelder -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Kartenfelder (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartenfelderSchleife;
      
   end Kartenfelder;
   
   
   
   procedure Verbesserungen
   is begin
      
      VerbesserungenSchleife:
      for WelcheZeileSchleifenwert in Kartentexte.Verbesserungen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Verbesserungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Verbesserungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop VerbesserungenSchleife;
      
   end Verbesserungen;
   
   
   
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
               GlobaleTexte.Beschäftigungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure Debugmenü
   is begin
      
      DebugmenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Debugmenü'Range loop
                  
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Debugmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Debugmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
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
               GlobaleTexte.AllgemeineInformationen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
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
               GlobaleTexte.Würdigung (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop WürdigungSchleife;
      
   end Würdigung;
   
   
   
   procedure Diplomatiemenü
   is begin
      
      DiplomatiemenüSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Diplomatiemenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Diplomatiemenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Diplomatiemenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
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
               GlobaleTexte.DiplomatieKI (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
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
               GlobaleTexte.Endmeldungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
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
               GlobaleTexte.Handelsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
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
               GlobaleTexte.DiplomatieStatus (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
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
               GlobaleTexte.Angebot (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop AngebotSchleife;
      
   end Angebot;
   
   
   
   procedure Fehlermeldung
   is begin
      
      FehlermeldungSchleife:
      for WelcheZeileSchleifenwert in Meldungstexte.Meldung'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Fehlermeldung -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Meldungstexte.Meldung (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
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
               GlobaleTexte.Ladezeit (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop LadezeitSchleife;
      
   end Ladezeit;
   
   
   
   procedure Frage
   is begin
      
      FrageSchleife:
      for WelcheZeileSchleifenwert in Meldungstexte.Frage'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Frage -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Meldungstexte.Frage (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop FrageSchleife;
      
   end Frage;
   
   
   
   procedure ZeugSachen
   is begin
      
      ZeugSachenSchleife:
      for WelcheZeileSchleifenwert in Meldungstexte.Zeug'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.ZeugSachen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Meldungstexte.Zeug (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop ZeugSachenSchleife;
      
   end ZeugSachen;
      
   
   
   procedure Editoren
   is begin
      
      EditorenSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Editoren'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Editoren -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Editoren (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop EditorenSchleife;
      
   end Editoren;
      
   
   
   procedure Wege
   is begin
      
      WegeSchleife:
      for WelcheZeileSchleifenwert in Kartentexte.Wege'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Wege -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Wege (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop WegeSchleife;
      
   end Wege;
      
   
   
   procedure Kartenflüsse
   is begin
      
      WegeSchleife:
      for WelcheZeileSchleifenwert in Kartentexte.Kartenflüsse'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenflüsse -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Kartenflüsse (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop WegeSchleife;
      
   end Kartenflüsse;
      
   
   
   procedure Kartenressourcen
   is begin
      
      WegeSchleife:
      for WelcheZeileSchleifenwert in Kartentexte.Kartenressourcen'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenressourcen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Kartentexte.Kartenressourcen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop WegeSchleife;
      
   end Kartenressourcen;
   
   
   
   procedure Einstellungen
   is begin
      
      EinstellungenSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Einstellungsmenü'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Einstellungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Einstellungsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop EinstellungenSchleife;
      
   end Einstellungen;
   
   
   
   procedure Kartenpole
   is begin
      
      KartenpoleSchleife:
      for WelcheZeileSchleifenwert in Menuetexte.Kartenpole'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenpole -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Menuetexte.Kartenpole (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop KartenpoleSchleife;
      
   end Kartenpole;
   
   
   
   procedure Stadtbefehle
   is begin
      
      StadtbefehleSchleife:
      for WelcheZeileSchleifenwert in Befehlstexte.Stadtbefehle'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Stadtbefehle -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               Befehlstexte.Stadtbefehle (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop StadtbefehleSchleife;
      
   end Stadtbefehle;

end EinlesenText;
