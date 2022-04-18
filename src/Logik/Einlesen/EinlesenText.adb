pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with OptionenVariablen;
with TextKonstanten;

with Warnung;

package body EinlesenText is

   procedure EinlesenDateien
   is begin
      
      TextdateienEinlesen := (others => TextKonstanten.LeerUnboundedString);
      
      case
        Exists (Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & "/0")
      is
         when True =>
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => OptionenVariablen.NutzerEinstellungen.Sprache)) & "/0");

         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien - 0-Datei fehlt.");
            return;
      end case;
      
      EinlesenMöglich := True;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in TextdateienEinlesen'Range loop

         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheDateienSchleifenwert)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien - Nicht genug Zeilen in der 0-Datei.");
               EinlesenMöglich := False;
               exit EinlesenSchleife;
               
            when False =>
               TextdateienEinlesen (WelcheDateienSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
            
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateienSchleifenwert))))
         is
            when True =>
               null;
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenText.EinlesenDateien - Fehlende Datei:" & To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateienSchleifenwert)));
               EinlesenMöglich := False;
               exit EinlesenSchleife;
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiTextEinlesen);
      
      case
        EinlesenMöglich
      is
         when False =>
            null;
            
         when True =>
            EinlesenTexte;
      end case;
      
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
               Debugmenü;
               
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
               
            when 38 =>
               Wege;
               
            when 39 =>
               Kartenflüsse;
               
            when 40 =>
               Kartenressourcen;
               
            when 41 =>
               Einstellungen;
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
               Put_Line ("EinlesenText.Hauptmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Spielmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Optionsmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Grafikmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Soundmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Steuerungmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Sonstigesmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Kartengröße -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Kartenart -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Kartentemperatur -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Rassenauswahl -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Schwierigkeitsgrad -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Kartenform -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Ressourcenmenge -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.JaNein -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Rassen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Kartenfelder -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Einheiten -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Verbesserungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Gebäude -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Forschungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Beschäftigungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.StädtenamenKI -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.StädtenamenKI (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop StädtenamenKISchleife;
      
   end StädtenamenKI;
   
   
   
   procedure Debugmenü
   is begin
      
      DebugmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Debugmenü'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Put_Line ("EinlesenText.Debugmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Put_Line ("EinlesenText.AllgemeineInformationen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Würdigung -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Diplomatiemenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.DiplomatieKI -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Endmeldungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Handelsmenü -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.DiplomatieStatus -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Angebot -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Fehlermeldung -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Ladezeit -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Frage -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.ZeugSachen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
               Put_Line ("EinlesenText.Editoren -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Put_Line ("EinlesenText.Wege -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Put_Line ("EinlesenText.Kartenflüsse -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Put_Line ("EinlesenText.Kartenressourcen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
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
           VorzeitigesZeilenende (AktuelleZeileExtern => WelcheZeileSchleifenwert)
         is
            when True =>
               Put_Line ("EinlesenText.Einstellungen -" & WelcheZeileSchleifenwert'Wide_Wide_Image);
               
            when False =>
               GlobaleTexte.Einstellungsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
      end loop EinstellungenSchleife;
      
   end Einstellungen;

end EinlesenText;
