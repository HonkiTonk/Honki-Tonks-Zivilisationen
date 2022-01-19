pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;

with GlobaleVariablen;
with SystemKonstanten;

with Fehler;

package body EinlesenText is

   procedure EinlesenDateien
   is begin
      
      TextdateienEinlesen := (others => SystemKonstanten.LeerUnboundedString);
      
      case
        Exists (Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.NutzerEinstellungen.Sprache)) & "/0")
      is
         when True =>
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.NutzerEinstellungen.Sprache)) & "/0");

         when False =>
            Fehler.LogikStopp (FehlermeldungExtern => "EinlesenText.EinlesenDateien - 0-Datei fehlt.");
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in TextdateienEinlesen'Range loop

         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheDateienSchleifenwert)
         is
            when True =>
               Fehler.LogikStopp (FehlermeldungExtern => "EinlesenText.EinlesenDateien - Nicht genug Zeilen in der 0-Datei.");
               
            when False =>
               TextdateienEinlesen (WelcheDateienSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
            
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateienSchleifenwert))))
         is
            when True =>
               null;
                  
            when False =>
               Fehler.LogikStopp (FehlermeldungExtern => "EinlesenText.EinlesenDateien - Fehlende Datei:" & To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateienSchleifenwert)));
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiTextEinlesen);
      
      EinlesenTexte;
      
   end EinlesenDateien;
   
   
   
   function VorzeitigesZeilenende
     (AktuelleZeileExtern : in Positive)
     return Boolean
   is begin
      
      case
        End_Of_File (File => DateiTextEinlesen)
      is
         when True =>
            return True;
               
         when False =>
            Set_Line (File => DateiTextEinlesen,
                      To   => Ada.Wide_Wide_Text_IO.Count (AktuelleZeileExtern));
            return False;
      end case;
      
   end VorzeitigesZeilenende;
   
   
   
   procedure EinlesenTexte
   is begin
      
      TexteSchleife:
      for WelcheDateiSchleifenwert in TextdateienEinlesen'Range loop
         
         Open (File => DateiTextEinlesen,
               Mode => In_File,
               Name => Encode (Item => To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateiSchleifenwert))));
         
         case
           WelcheDateiSchleifenwert
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
               JaNein;
               
            when 16 =>
               Rassen;
               
            when 17 =>
               Kartenfelder;
               
            when 18 =>
               Einheiten;
               
            when 19 =>
               Verbesserungen;
               
            when 20 =>
               Gebäude;
               
            when 21 =>
               Forschungen;
               
            when 22 =>
               Beschäftigungen;
               
            when 23 =>
               StädtenamenKI;
               
            when 24 =>
               Cheatmenü;
               
            when 25 =>
               AllgemeineInformationen;
               
            when 26 =>
               Würdigung;
               
            when 27 =>
               Diplomatiemenü;
               
            when 28 =>
               DiplomatieKI;
               
            when 29 =>
               Endmeldungen;
               
            when 30 =>
               Handelsmenü;
               
            when 31 =>
               DiplomatieStatus;
               
            when 32 =>
               Angebot;
               
            when 33 =>
               Fehlermeldung;
               
            when 34 =>
               Ladezeit;
               
            when 35 =>
               Frage;
               
            when 36 =>
               ZeugSachen;
               
            when 37 =>
               Editoren;
         end case;
            
         Close (File => DateiTextEinlesen);
         
      end loop TexteSchleife;
      
   end EinlesenTexte;
   
   
   
   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Hauptmenü'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Hauptmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Spielmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Optionsmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Grafikmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Soundmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Steuerungmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Sonstigesmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Kartengröße (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Kartenart (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Kartentemperatur (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Rassenauswahl (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Schwierigkeitsgrad (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Kartenform (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Ressourcenmenge (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
            when False =>
               GlobaleTexte.Ressourcenmenge (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop RessourcenmengeSchleife;
      
   end Ressourcenmenge;
   
   
   
   procedure JaNein
   is begin
      
      JaNeinSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.JaNein'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.JaNein (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
            when False =>
               GlobaleTexte.JaNein (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop JaNeinSchleife;
      
   end JaNein;
   
   
   
   procedure Rassen
   is begin
      
      RassenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Rassen'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Rassen (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Kartenfelder (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Einheiten (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Verbesserungen (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Gebäude (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Forschungen (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Beschäftigungen (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
            when False =>
               GlobaleTexte.Beschäftigungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure StädtenamenKI
   is begin
      
      StädtenamenKISchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.StädtenamenKI'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.StädtenamenKI (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
            when False =>
               GlobaleTexte.StädtenamenKI (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop StädtenamenKISchleife;
      
   end StädtenamenKI;
   
   
   
   procedure Cheatmenü
   is begin
      
      CheatmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Cheatmenü'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Cheatmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
            when False =>
               GlobaleTexte.Cheatmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop CheatmenüSchleife;
      
   end Cheatmenü;
   
   
   
   procedure AllgemeineInformationen
   is begin
      
      AllgemeineInformationenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.AllgemeineInformationen'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.AllgemeineInformationen (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Würdigung (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Diplomatiemenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.DiplomatieKI (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Endmeldungen (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Handelsmenü (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.DiplomatieStatus (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Angebot (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Fehlermeldung (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Ladezeit (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Frage (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
            when False =>
               GlobaleTexte.Frage (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop FrageSchleife;
      
   end Frage;
   
   
   
   procedure ZeugSachen
   is begin
      
      ZeugSachenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.ZeugSachen'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.ZeugSachen (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
            when False =>
               GlobaleTexte.ZeugSachen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop ZeugSachenSchleife;
      
   end ZeugSachen;
      
   
   
   procedure Editoren
   is begin
      
      EditorenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Editoren'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               GlobaleTexte.Editoren (WelcheZeileSchleifenwert) := NichtGenugZeilen;
               
            when False =>
               GlobaleTexte.Editoren (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop EditorenSchleife;
      
   end Editoren;

end EinlesenText;
