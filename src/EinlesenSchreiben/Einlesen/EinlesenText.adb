pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen;
with SystemKonstanten;

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
            raise Program_Error;
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in TextdateienEinlesen'Range loop

         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheDateienSchleifenwert);
         TextdateienEinlesen (WelcheDateienSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
            
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => TextdateienEinlesen (WelcheDateienSchleifenwert))))
         is
            when True =>
               null;
                  
            when False =>
               raise Program_Error;
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiTextEinlesen);
      
      EinlesenTexte;
      
   end EinlesenDateien;
   
   
   
   procedure DateiPrüfenZeileSetzen
     (AktuelleZeileExtern : in Positive)
   is begin
      
      case
        End_Of_File (File => DateiTextEinlesen)
      is
         when True =>
            raise Program_Error;
               
         when False =>
            Set_Line (File => DateiTextEinlesen,
                      To   => Ada.Wide_Wide_Text_IO.Count (AktuelleZeileExtern));
      end case;
      
   end DateiPrüfenZeileSetzen;
   
   
   
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
               Spieleranzahl;
               
            when 12 =>
               Rassenauswahl;
               
            when 13 =>
               Schwierigkeitsgrad;
               
            when 14 =>
               Kartenform;
               
            when 15 =>
               Ressourcenmenge;
               
            when 16 =>
               JaNein;
               
            when 17 =>
               Rassen;
               
            when 18 =>
               Kartenfelder;
               
            when 19 =>
               Einheiten;
               
            when 20 =>
               Verbesserungen;
               
            when 21 =>
               Gebäude;
               
            when 22 =>
               Forschungen;
               
            when 23 =>
               Beschäftigungen;
               
            when 24 =>
               StädtenamenKI;
               
            when 25 =>
               Cheatmenü;
               
            when 26 =>
               AllgemeineInformationen;
               
            when 27 =>
               Würdigung;
               
            when 28 =>
               Diplomatiemenü;
               
            when 29 =>
               DiplomatieKI;
               
            when 30 =>
               Endmeldungen;
               
            when 31 =>
               Handelsmenü;
               
            when 32 =>
               DiplomatieStatus;
               
            when 33 =>
               Angebot;
               
            when 34 =>
               Fehlermeldung;
               
            when 35 =>
               Ladezeit;
               
            when 36 =>
               Frage;
               
            when 37 =>
               ZeugSachen;
         end case;
            
         Close (File => DateiTextEinlesen);
         
      end loop TexteSchleife;
      
   end EinlesenTexte;
   
   
   
   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Hauptmenü'Range loop
         
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Hauptmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop HauptmenüSchleife;
      
   end Hauptmenü;
   
   
   
   procedure Spielmenü
   is begin
      
      SpielmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Spielmenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Spielmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop SpielmenüSchleife;
      
   end Spielmenü;
   
   
   
   procedure Optionsmenü
   is begin
      
      OptionsmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Optionsmenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Optionsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop OptionsmenüSchleife;
      
   end Optionsmenü;
   
   
   
   procedure Grafikmenü
   is begin
      
      GrafikmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Grafikmenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Grafikmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop GrafikmenüSchleife;
      
   end Grafikmenü;
   
   
   
   procedure Soundmenü
   is begin
      
      SoundmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Soundmenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Soundmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop SoundmenüSchleife;
      
   end Soundmenü;
   
   
   
   procedure Steuerungmenü
   is begin
      
      SteuerungmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Steuerungmenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Steuerungmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop SteuerungmenüSchleife;
      
   end Steuerungmenü;
   
   
   
   procedure Sonstigesmenü
   is begin
      
      SonstigesmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Sonstigesmenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Sonstigesmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop SonstigesmenüSchleife;
      
   end Sonstigesmenü;
   
   
   
   procedure Kartengröße
   is begin
      
      KartengrößeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartengröße'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Kartengröße (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop KartengrößeSchleife;
      
   end Kartengröße;
   
   
   
   procedure Kartenart
   is begin
      
      KartenartSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenart'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Kartenart (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop KartenartSchleife;
      
   end Kartenart;
   
   
   
   procedure Kartentemperatur
   is begin
      
      KartentemperaturSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartentemperatur'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Kartentemperatur (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop KartentemperaturSchleife;
      
   end Kartentemperatur;
   
   
   
   procedure Spieleranzahl
   is begin
      
      SpieleranzahlSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Spieleranzahl'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Spieleranzahl (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop SpieleranzahlSchleife;
      
   end Spieleranzahl;
   
   
   
   procedure Rassenauswahl
   is begin
      
      RassenauswahlSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Rassenauswahl'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Rassenauswahl (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop RassenauswahlSchleife;
      
   end Rassenauswahl;
   
   
   
   procedure Schwierigkeitsgrad
   is begin
      
      SchwierigkeitsgradSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Schwierigkeitsgrad'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Schwierigkeitsgrad (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop SchwierigkeitsgradSchleife;
      
   end Schwierigkeitsgrad;
   
   
   
   procedure Kartenform
   is begin
      
      KartenformSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenform'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Kartenform (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop KartenformSchleife;
      
   end Kartenform;
   
   
   
   procedure Ressourcenmenge
   is begin
      
      RessourcenmengeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Ressourcenmenge'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Ressourcenmenge (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop RessourcenmengeSchleife;
      
   end Ressourcenmenge;
   
   
   
   procedure JaNein
   is begin
      
      JaNeinSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.JaNein'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.JaNein (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop JaNeinSchleife;
      
   end JaNein;
   
   
   
   procedure Rassen
   is begin
      
      RassenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Rassen'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Rassen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop RassenSchleife;
      
   end Rassen;
   
   
   
   procedure Kartenfelder
   is begin
      
      KartenfelderSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Kartenfelder'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Kartenfelder (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop KartenfelderSchleife;
      
   end Kartenfelder;
   
   
   
   procedure Einheiten
   is begin
      
      EinheitenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Einheiten'Range loop
        
         -- DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         Set_Line (File => DateiTextEinlesen,
                   To   => Ada.Wide_Wide_Text_IO.Count (WelcheZeileSchleifenwert));
         GlobaleTexte.Einheiten (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop EinheitenSchleife;
      
   end Einheiten;
   
   
   
   procedure Verbesserungen
   is begin
      
      VerbesserungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Verbesserungen'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Verbesserungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop VerbesserungenSchleife;
      
   end Verbesserungen;
   
   
   
   procedure Gebäude
   is begin
      
      GebäudeSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Gebäude'Range loop
        
         -- DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         Set_Line (File => DateiTextEinlesen,
                   To   => Ada.Wide_Wide_Text_IO.Count (WelcheZeileSchleifenwert));
         GlobaleTexte.Gebäude (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop GebäudeSchleife;
      
   end Gebäude;
   
   
   
   procedure Forschungen
   is begin
      
      ForschungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Forschungen'Range loop
        
         -- DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         Set_Line (File => DateiTextEinlesen,
                   To   => Ada.Wide_Wide_Text_IO.Count (WelcheZeileSchleifenwert));
         GlobaleTexte.Forschungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop ForschungenSchleife;
      
   end Forschungen;
   
   
   
   procedure Beschäftigungen
   is begin
      
      BeschäftigungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Beschäftigungen'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Beschäftigungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure StädtenamenKI
   is begin
      
      StädtenamenKISchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.StädtenamenKI'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.StädtenamenKI (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop StädtenamenKISchleife;
      
   end StädtenamenKI;
   
   
   
   procedure Cheatmenü
   is begin
      
      CheatmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Cheatmenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Cheatmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop CheatmenüSchleife;
      
   end Cheatmenü;
   
   
   
   procedure AllgemeineInformationen
   is begin
      
      AllgemeineInformationenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.AllgemeineInformationen'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.AllgemeineInformationen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop AllgemeineInformationenSchleife;
      
   end AllgemeineInformationen;
   
   
   
   procedure Würdigung
   is begin
      
      WürdigungSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Würdigung'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Würdigung (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop WürdigungSchleife;
      
   end Würdigung;
   
   
   
   procedure Diplomatiemenü
   is begin
      
      DiplomatiemenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Diplomatiemenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Diplomatiemenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop DiplomatiemenüSchleife;
      
   end Diplomatiemenü;
   
   
   
   procedure DiplomatieKI
   is begin
      
      DiplomatieKISchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.DiplomatieKI'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.DiplomatieKI (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop DiplomatieKISchleife;
      
   end DiplomatieKI;
   
   
   
   procedure Endmeldungen
   is begin
      
      EndmeldungenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Endmeldungen'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Endmeldungen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop EndmeldungenSchleife;
      
   end Endmeldungen;
   
   
   
   procedure Handelsmenü
   is begin
      
      HandelsmenüSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Handelsmenü'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Handelsmenü (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop HandelsmenüSchleife;
      
   end Handelsmenü;
   
   
   
   procedure DiplomatieStatus
   is begin
      
      DiplomatieStatusSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.DiplomatieStatus'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.DiplomatieStatus (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop DiplomatieStatusSchleife;
      
   end DiplomatieStatus;
   
   
   
   procedure Angebot
   is begin
      
      AngebotSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Angebot'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Angebot (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop AngebotSchleife;
      
   end Angebot;
   
   
   
   procedure Fehlermeldung
   is begin
      
      FehlermeldungSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Fehlermeldung'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Fehlermeldung (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop FehlermeldungSchleife;
      
   end Fehlermeldung;
   
   
   
   procedure Ladezeit
   is begin
      
      LadezeitSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Ladezeit'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Ladezeit (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop LadezeitSchleife;
      
   end Ladezeit;
   
   
   
   procedure Frage
   is begin
      
      FrageSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.Frage'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.Frage (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop FrageSchleife;
      
   end Frage;
   
   
   
   procedure ZeugSachen
   is begin
      
      ZeugSachenSchleife:
      for WelcheZeileSchleifenwert in GlobaleTexte.ZeugSachen'Range loop
        
         DateiPrüfenZeileSetzen (AktuelleZeileExtern => WelcheZeileSchleifenwert);
         GlobaleTexte.ZeugSachen (WelcheZeileSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         
      end loop ZeugSachenSchleife;
      
   end ZeugSachen;

end EinlesenText;
