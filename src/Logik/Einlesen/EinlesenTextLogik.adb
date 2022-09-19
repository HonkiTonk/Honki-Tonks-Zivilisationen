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
with EinlesenAllgemeinesLogik;
with Fehler;

package body EinlesenTextLogik is

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
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien: Es fehlt: " & Decode (Item => VerzeichnisKonstanten.SprachenStrich)
                                  & To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache) & Decode (Item => VerzeichnisKonstanten.NullDatei));
            return;
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in TextdateienEinlesen'Range loop

         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                           AktuelleZeileExtern => WelcheDateienSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien: Fehlende Zeilen: " & Decode (Item => VerzeichnisKonstanten.SprachenStrich)
                                     & To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache) & Decode (Item => VerzeichnisKonstanten.NullDatei));
               
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
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenAufteilen: Es fehlt: " & VerzeichnisExtern);
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
            
         when 38 =>
            Spielstandmenü;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "EinlesenText.EinlesenAufteilen: Mehr eingelesen als möglich.");
      end case;
            
      Close (File => DateiText);
      
   end EinlesenAufteilen;
   
   
   
   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Hauptmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Hauptmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Spielmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Optionsmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Grafikmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Soundmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Steuerungmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Sonstigesmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartengröße: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenart: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartentemperatur: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Rassenauswahl: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Schwierigkeitsgrad: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenform: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Ressourcenmenge: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenfelder: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Verbesserungen: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Beschäftigungen: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Debugmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.AllgemeineInformationen: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Würdigung: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Diplomatiemenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.DiplomatieKI: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Endmeldungen: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Handelsmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.DiplomatieStatus: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Spielmenü: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Fehlermeldung: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Ladezeit: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Frage: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.ZeugSachen: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Editoren: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Wege: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenflüsse: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenressourcen: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Einstellungen: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Kartenpole: Fehlende Zeilen.");
               return;
               
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
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Stadtbefehle: Fehlende Zeilen.");
               return;
               
            when False =>
               Befehlstexte.Stadtbefehle (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop StadtbefehleSchleife;
      
   end Stadtbefehle;
   
   
   
   procedure Spielstandmenü
   is begin
      
      SpielstandmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Spielstandmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.Spielstandmenü: Fehlende Zeilen.");
               return;
               
            when False =>
               Menuetexte.Spielstandmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop SpielstandmenüSchleife;
      
   end Spielstandmenü;

end EinlesenTextLogik;
