with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;
with Menuetexte;
with Kartentexte;
with GlobaleTexte;
with Meldungstexte;
with Befehlstexte;
with Spieltexte;

with LeseOptionen;

with Fehlermeldungssystem;
with EinlesenAllgemeinesLogik;

package body EinlesenTextLogik is

   procedure EinlesenDateien
   is begin
      
      Nullpfad := VerzeichnisKonstanten.Sprachenordner & LeseOptionen.Sprache & "/0";
            
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Nullpfad)))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenDateien: Es fehlt: " & To_Wide_Wide_String (Source => Nullpfad));
            return;
            
         when True =>
            Dateienpfad := VerzeichnisKonstanten.Sprachenordner & LeseOptionen.Sprache & "/";
            
            Open (File => DateiVerzeichnisse,
                  Mode => In_File,
                  Name => Encode (Item => To_Wide_Wide_String (Source => Nullpfad)),
                  Form => "WCEM=8");
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in 1 .. AnzahlTextdateien loop

         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                           AktuelleZeileExtern => WelcheDateienSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenDateien: Fehlende Zeilen, aktuelle Zeile: " & WelcheDateienSchleifenwert'Wide_Wide_Image);
               exit EinlesenSchleife;
               
            when False =>
               EinlesenAufteilen (WelcheDateiExtern => WelcheDateienSchleifenwert,
                                  VerzeichnisExtern => To_Wide_Wide_String (Source => Dateienpfad) & Get_Line (File => DateiVerzeichnisse));
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiVerzeichnisse);
      
      Menuetexte.Debugmenü (1) := To_Unbounded_Wide_Wide_String (Source => "Debugmenü");
      Menuetexte.Debugmenü (2) := To_Unbounded_Wide_Wide_String (Source => "Karte aufdecken");
      Menuetexte.Debugmenü (3) := To_Unbounded_Wide_Wide_String (Source => "Alle Technologien");
      Menuetexte.Debugmenü (4) := To_Unbounded_Wide_Wide_String (Source => "Mensch/KI tauschen");
      Menuetexte.Debugmenü (5) := To_Unbounded_Wide_Wide_String (Source => "Debug");
      Menuetexte.Debugmenü (6) := To_Unbounded_Wide_Wide_String (Source => "Fertig");
      
   end EinlesenDateien;
   
   
   
   -- Verzeichnis hier in Datei umbenennen? äöü
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => VerzeichnisExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenAufteilen: Es fehlt: " & VerzeichnisExtern);
            return;
            
         when True =>
            Open (File => DateiText,
                  Mode => In_File,
                  Name => Encode (Item => VerzeichnisExtern),
                  Form => "WCEM=8");
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
            Speziesauswahl;
               
         when 12 =>
            Schwierigkeitsgrad;
               
         when 13 =>
            Kartenform;
               
         when 14 =>
            Ressourcenmenge;
               
         when 15 =>
            Basisgrund;
               
         when 16 =>
            Verbesserungen;
               
         when 17 =>
            Beschäftigungen;
               
         when 18 =>
            Würdigung;
               
         when 19 =>
            Diplomatiemenü;
               
         when 20 =>
            DiplomatieKI;
               
         when 21 =>
            Handelsmenü;
               
         when 22 =>
            DiplomatieStatus;
               
         when 23 =>
            Angebot;
               
         when 24 =>
            Fehlermeldung;
               
         when 25 =>
            Ladezeit;
               
         when 26 =>
            Frage;
               
         when 27 =>
            ZeugSachen;
               
         when 28 =>
            Editoren;
               
         when 29 =>
            Wege;
               
         when 30 =>
            Kartenflüsse;
               
         when 31 =>
            Kartenressourcen;
               
         when 32 =>
            Einstellungen;
               
         when 33 =>
            Kartenpole;
            
         when 34 =>
            Stadtbefehle;
            
         when 35 =>
            Spielstandmenü;
            
         when 36 =>
            Intro;
            
         when 37 =>
            Outro;
            
         when 38 =>
            Zusatzgrund;
            
         when 39 =>
            Feldeffekte;
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenAufteilen: Mehr eingelesen als möglich, Dateinummer: " & WelcheDateiExtern'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Hauptmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spielmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Optionsmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Grafikmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Soundmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Steuerungmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Sonstigesmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartengröße: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenart: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartentemperatur: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Menuetexte.Kartentemperatur (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop KartentemperaturSchleife;
      
   end Kartentemperatur;
   
   
   
   procedure Speziesauswahl
   is begin
      
      SpeziesauswahlSchleife:
      for ZeileSchleifenwert in Menuetexte.Speziesauswahl'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Speziesauswahl: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Menuetexte.Speziesauswahl (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop SpeziesauswahlSchleife;
      
   end Speziesauswahl;
   
   
   
   procedure Schwierigkeitsgrad
   is begin
      
      SchwierigkeitsgradSchleife:
      for ZeileSchleifenwert in Menuetexte.Schwierigkeitsgrad'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Schwierigkeitsgrad: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenform: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Ressourcenmenge: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Menuetexte.Ressourcenmenge (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop RessourcenmengeSchleife;
      
   end Ressourcenmenge;
   
   
   
   procedure Basisgrund
   is begin
      
      BasisgrundSchleife:
      for ZeileSchleifenwert in Kartentexte.Basisgrund'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Basisgrund: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Kartentexte.Basisgrund (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop BasisgrundSchleife;
      
   end Basisgrund;
   
   
   
   procedure Verbesserungen
   is begin
      
      VerbesserungenSchleife:
      for ZeileSchleifenwert in Kartentexte.Verbesserungen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Verbesserungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Beschäftigungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               GlobaleTexte.Beschäftigungen (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure Würdigung
   is begin
      
      WürdigungSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Würdigung'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Würdigung: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Diplomatiemenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.DiplomatieKI: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               GlobaleTexte.DiplomatieKI (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop DiplomatieKISchleife;
      
   end DiplomatieKI;
   
   
   
   procedure Handelsmenü
   is begin
      
      HandelsmenüSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Handelsmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Handelsmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.DiplomatieStatus: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spielmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Fehlermeldung: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Ladezeit: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Frage: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.ZeugSachen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Editoren: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Wege: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenflüsse: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenressourcen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Einstellungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenpole: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Stadtbefehle: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spielstandmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Menuetexte.Spielstandmenü (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop SpielstandmenüSchleife;
      
   end Spielstandmenü;
   
   
   
   procedure Intro
   is begin
      
      IntroSchleife:
      for ZeileSchleifenwert in Spieltexte.Intro'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Intro: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Spieltexte.Intro (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop IntroSchleife;
      
   end Intro;
   
   
   
   procedure Outro
   is begin
      
      OutroSchleife:
      for ZeileSchleifenwert in Spieltexte.Outro'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Outro: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Spieltexte.Outro (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop OutroSchleife;
      
   end Outro;
   
   
   
   procedure Zusatzgrund
   is begin
      
      ZusatzgrundSchleife:
      for ZeileSchleifenwert in Kartentexte.Zusatzgrund'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Zusatzgrund: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Kartentexte.Zusatzgrund (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop ZusatzgrundSchleife;
      
   end Zusatzgrund;
   
   
   
   procedure Feldeffekte
   is begin
      
      FeldeffekteSchleife:
      for ZeileSchleifenwert in Kartentexte.Feldeffekte'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiText,
                                                           AktuelleZeileExtern => ZeileSchleifenwert)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Feldeffekte: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Kartentexte.Feldeffekte (ZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
         end case;
         
      end loop FeldeffekteSchleife;
      
   end Feldeffekte;

end EinlesenTextLogik;
