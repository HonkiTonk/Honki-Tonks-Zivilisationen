with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
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
     (EinsprachigExtern : in Boolean)
   is begin
      
      case
        EinsprachigExtern
      is
         when True =>
            Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & To_Wide_Wide_String (Source => LeseOptionen.Sprache) & "/"),
                      EinsprachigExtern => EinsprachigExtern);
      
            Menuetexte.Debugmenü (1) := To_Unbounded_Wide_Wide_String (Source => "Debugmenü");
            Menuetexte.Debugmenü (2) := To_Unbounded_Wide_Wide_String (Source => "Karte aufdecken");
            Menuetexte.Debugmenü (3) := To_Unbounded_Wide_Wide_String (Source => "Alle Technologien");
            Menuetexte.Debugmenü (4) := To_Unbounded_Wide_Wide_String (Source => "Mensch/KI tauschen");
            Menuetexte.Debugmenü (5) := To_Unbounded_Wide_Wide_String (Source => "Diplomatischen Status ändern");
            Menuetexte.Debugmenü (6) := To_Unbounded_Wide_Wide_String (Source => "Volle Forschung");
            Menuetexte.Debugmenü (7) := To_Unbounded_Wide_Wide_String (Source => "Einheit erzeugen");
            Menuetexte.Debugmenü (8) := To_Unbounded_Wide_Wide_String (Source => "Einsprachig/Mehrsprachig");
            Menuetexte.Debugmenü (9) := To_Unbounded_Wide_Wide_String (Source => "Fertig");
            
         when False =>
            Start_Search (Search    => Suche,
                          Directory => VerzeichnisKonstanten.Sprachen,
                          Pattern   => "",
                          Filter    => (Directory => True,
                                        others    => False));
      
            SprachenSchleife:
            while More_Entries (Search => Suche) = True loop
      
               Get_Next_Entry (Search          => Suche,
                               Directory_Entry => Verzeichnis);
         
               -- Das hier doch einmal auslagern? äöü
               if
                 Simple_Name (Directory_Entry => Verzeichnis) = "."
                 or
                   Simple_Name (Directory_Entry => Verzeichnis) = ".."
                 or
                   Simple_Name (Directory_Entry => Verzeichnis) = "Fonts"
               then
                  null;
            
               elsif
                 -- Das hier noch durch eine Windows uns eine Linuxversion ersetzen. äöü
                 -- Kann das nicht einfach raus wenn irgendwann einmal Wide_Wide_Directories da ist? äöü
                 -- Das ist je nur vorhandene Ordner durchgehen und man kann ja keine Dateien/Ordner anlegen die das Dateisystem nicht unterstützen. äöü
                 EinlesenAllgemeinesLogik.NamensprüfungWindows (NameExtern => Decode (Item => Simple_Name (Directory_Entry => Verzeichnis))) = False
               then
                  null;
             
               elsif
                 -- Das ausgeklammerte funktioniert unter Windwos nicht, wenn man Sonderzeichen verwendet.
                 -- EinlesenAllgemeinesLogik.LeeresVerzeichnis (VerzeichnisExtern => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis)) = True
                 Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.NullDatei) = False
                 or
                   Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.EinsDatei) = False
               then
                  null;
            
               else
                  Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & Decode (Item => Simple_Name (Directory_Entry => Verzeichnis)) & "/"),
                            EinsprachigExtern => EinsprachigExtern);
               end if;
               
            end loop SprachenSchleife;
      end case;
      
   end EinlesenDateien;
      
      
      
   procedure Einlesen
     (VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
   is begin
      
      case
        Exists (Name => Encode (Item => VerzeichnisExtern & "0"))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Einlesen: Es fehlt: " & VerzeichnisExtern & "0");
            return;
            
         when True =>
            Open (File => DateiVerzeichnisse,
                  Mode => In_File,
                  Name => Encode (Item => VerzeichnisExtern & "0"),
                  Form => "WCEM=8");
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in 1 .. AnzahlTextdateien loop

         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                           AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Einlesen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Einlesen: Fehlende Zeilen, aktuelle Zeile: " & WelcheDateienSchleifenwert'Wide_Wide_Image);
               exit EinlesenSchleife;
               
            when False =>
               EinlesenAufteilen (WelcheDateiExtern => WelcheDateienSchleifenwert,
                                  VerzeichnisExtern => VerzeichnisExtern & Get_Line (File => DateiVerzeichnisse),
                                  EinsprachigExtern => EinsprachigExtern);
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiVerzeichnisse);
      
   end Einlesen;
   
   
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
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
            Ersetzungen (DateiExtern       => DateiText,
                         EinsprachigExtern => EinsprachigExtern);
            
         when 2 =>
            Menüs (DateiExtern       => DateiText,
                    EinsprachigExtern => EinsprachigExtern);
               
         when 3 =>
            Basisgrund (DateiExtern => DateiText,
                        EinsprachigExtern => EinsprachigExtern);
               
         when 4 =>
            Verbesserungen (DateiExtern => DateiText,
                            EinsprachigExtern => EinsprachigExtern);
               
         when 5 =>
            Beschäftigungen (DateiExtern => DateiText,
                              EinsprachigExtern => EinsprachigExtern);
               
         when 6 =>
            Würdigung (DateiExtern => DateiText,
                        EinsprachigExtern => EinsprachigExtern);
               
         when 7 =>
            DiplomatieKI (DateiExtern => DateiText,
                          EinsprachigExtern => EinsprachigExtern);
               
         when 8 =>
            Handelsmenü (DateiExtern => DateiText,
                          EinsprachigExtern => EinsprachigExtern);
               
         when 9 =>
            DiplomatieStatus (DateiExtern => DateiText,
                              EinsprachigExtern => EinsprachigExtern);
               
         when 10 =>
            Angebot (DateiExtern => DateiText,
                     EinsprachigExtern => EinsprachigExtern);
               
         when 11 =>
            Fehlermeldung (DateiExtern => DateiText,
                           EinsprachigExtern => EinsprachigExtern);
               
         when 12 =>
            Ladezeit (DateiExtern => DateiText,
                      EinsprachigExtern => EinsprachigExtern);
               
         when 13 =>
            Frage (DateiExtern => DateiText,
                   EinsprachigExtern => EinsprachigExtern);
               
         when 14 =>
            ZeugSachen (DateiExtern => DateiText,
                        EinsprachigExtern => EinsprachigExtern);
               
         when 15 =>
            Wege (DateiExtern => DateiText,
                  EinsprachigExtern => EinsprachigExtern);
               
         when 16 =>
            Kartenflüsse (DateiExtern => DateiText,
                           EinsprachigExtern => EinsprachigExtern);
               
         when 17 =>
            Kartenressourcen (DateiExtern => DateiText,
                              EinsprachigExtern => EinsprachigExtern);
            
         when 18 =>
            Stadtbefehle (DateiExtern => DateiText,
                          EinsprachigExtern => EinsprachigExtern);
            
         when 19 =>
            Intro (DateiExtern => DateiText,
                   EinsprachigExtern => EinsprachigExtern);
            
         when 20 =>
            Outro (DateiExtern => DateiText,
                   EinsprachigExtern => EinsprachigExtern);
            
         when 21 =>
            Zusatzgrund (DateiExtern => DateiText,
                         EinsprachigExtern => EinsprachigExtern);
            
         when 22 =>
            Feldeffekte (DateiExtern => DateiText,
                         EinsprachigExtern => EinsprachigExtern);
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenAufteilen: Mehr eingelesen als möglich, Dateinummer: " & WelcheDateiExtern'Wide_Wide_Image);
      end case;
            
      Close (File => DateiText);
      
   end EinlesenAufteilen;
   
   
   
   procedure Ersetzungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      ErsetzungenSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => EinzulesendeZeile,
                                                           DateiExtern         => "EinlesenTextLogik.Ersetzungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Ersetzungen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               EinzulesendeZeile := EinzulesendeZeile + 1;
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               ErsetzungenEingelesen (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => ErsetzungenEingelesen (AktuelleZeile));
               
               if
                 AktuelleZeile < ErsetzungenEingelesenArray'Last
               then
                  AktuelleZeile := AktuelleZeile + 1;
                  
               else
                  return;
               end if;
         end case;
         
      end loop ErsetzungenSchleife;
      
   end Ersetzungen;
   
   
   
   procedure Menüs
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      MenüSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => EinzulesendeZeile,
                                                           DateiExtern         => "EinlesenTextLogik.Menüs")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Menüs: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               EinzulesendeZeile := EinzulesendeZeile + 1;
               Zwischenspeicher := TextErsetzen (TextExtern => Get_Line (File => DateiExtern));
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Hauptmenü
               then
                  Menuetexte.Hauptmenü (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                        EingelesenerTextExtern => Zwischenspeicher,
                                                                        VorhandenerTextExtern  => Menuetexte.Hauptmenü (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Hauptmenü + 1 .. Spielmenü
               then
                  Menuetexte.Spielmenü (AktuelleZeile - Hauptmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                                     VorhandenerTextExtern  => Menuetexte.Spielmenü (AktuelleZeile - Hauptmenü));
                  
               elsif
                 AktuelleZeile in Spielmenü + 1 .. Optionsmenü
               then
                  Menuetexte.Optionsmenü (AktuelleZeile - Spielmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                                       VorhandenerTextExtern  => Menuetexte.Optionsmenü (AktuelleZeile - Spielmenü));
                  
               elsif
                 AktuelleZeile in Optionsmenü + 1 .. Grafikmenü
               then
                  Menuetexte.Grafikmenü (AktuelleZeile - Optionsmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                        EingelesenerTextExtern => Zwischenspeicher,
                                                                                        VorhandenerTextExtern  => Menuetexte.Grafikmenü (AktuelleZeile - Optionsmenü));
                  
               elsif
                 AktuelleZeile in Grafikmenü + 1 .. Soundmenü
               then
                  Menuetexte.Soundmenü (AktuelleZeile - Grafikmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                      EingelesenerTextExtern => Zwischenspeicher,
                                                                                      VorhandenerTextExtern  => Menuetexte.Soundmenü (AktuelleZeile - Grafikmenü));
                  
               elsif
                 AktuelleZeile in Soundmenü + 1 .. Steuerungsmenü
               then
                  Menuetexte.Steuerungsmenü (AktuelleZeile - Soundmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Steuerungsmenü (AktuelleZeile - Soundmenü));
                  
               elsif
                 AktuelleZeile in Steuerungsmenü + 1 .. Sonstigesmenü
               then
                  Menuetexte.Sonstigesmenü (AktuelleZeile - Steuerungsmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                              EingelesenerTextExtern => Zwischenspeicher,
                                                                                              VorhandenerTextExtern  => Menuetexte.Sonstigesmenü (AktuelleZeile - Steuerungsmenü));
                  
               elsif
                 AktuelleZeile in Sonstigesmenü + 1 .. Kartengröße
               then
                  Menuetexte.Kartengröße (AktuelleZeile - Sonstigesmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                            EingelesenerTextExtern => Zwischenspeicher,
                                                                                            VorhandenerTextExtern  => Menuetexte.Kartengröße (AktuelleZeile - Sonstigesmenü));
                  
               elsif
                 AktuelleZeile in Kartengröße + 1 .. Kartenart
               then
                  Menuetexte.Kartenart (AktuelleZeile - Kartengröße) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                                       VorhandenerTextExtern  => Menuetexte.Kartenart (AktuelleZeile - Kartengröße));
                  
               elsif
                 AktuelleZeile in Kartenart + 1 .. Kartentemperatur
               then
                  Menuetexte.Kartentemperatur (AktuelleZeile - Kartenart) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Kartentemperatur (AktuelleZeile - Kartenart));
                  
               elsif
                 AktuelleZeile in Kartentemperatur + 1 .. Speziesauswahl
               then
                  Menuetexte.Speziesauswahl (AktuelleZeile - Kartentemperatur) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                               VorhandenerTextExtern  => Menuetexte.Speziesauswahl (AktuelleZeile - Kartentemperatur));
                  
               elsif
                 AktuelleZeile in Speziesauswahl + 1 .. Schwierigkeitsgrad
               then
                  Menuetexte.Schwierigkeitsgrad (AktuelleZeile - Speziesauswahl) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                                 VorhandenerTextExtern  => Menuetexte.Schwierigkeitsgrad (AktuelleZeile - Speziesauswahl));
                  
               elsif
                 AktuelleZeile in Schwierigkeitsgrad + 1 .. Kartenform
               then
                  Menuetexte.Kartenform (AktuelleZeile - Schwierigkeitsgrad) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                             EingelesenerTextExtern => Zwischenspeicher,
                                                                                             VorhandenerTextExtern  => Menuetexte.Kartenform (AktuelleZeile - Schwierigkeitsgrad));
                  
               elsif
                 AktuelleZeile in Kartenform + 1 .. Ressourcenmenge
               then
                  Menuetexte.Ressourcenmenge (AktuelleZeile - Kartenform) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Ressourcenmenge (AktuelleZeile - Kartenform));
                  
               elsif
                 AktuelleZeile in Ressourcenmenge + 1 .. Diplomatiemenü
               then
                  Menuetexte.Diplomatiemenü (AktuelleZeile - Ressourcenmenge) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                               VorhandenerTextExtern  => Menuetexte.Diplomatiemenü (AktuelleZeile - Ressourcenmenge));
                  
               elsif
                 AktuelleZeile in Diplomatiemenü + 1 .. Einstellungsmenü
               then
                  Menuetexte.Einstellungsmenü (AktuelleZeile - Diplomatiemenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                                 VorhandenerTextExtern  => Menuetexte.Einstellungsmenü (AktuelleZeile - Diplomatiemenü));
                  
               elsif
                 AktuelleZeile in Einstellungsmenü + 1 .. Kartenpole
               then
                  Menuetexte.Kartenpole (AktuelleZeile - Einstellungsmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                            EingelesenerTextExtern => Zwischenspeicher,
                                                                                            VorhandenerTextExtern  => Menuetexte.Kartenpole (AktuelleZeile - Einstellungsmenü));
                  
               elsif
                 AktuelleZeile in Kartenpole + 1 .. Spielstandmenü
               then
                  Menuetexte.Spielstandmenü (AktuelleZeile - Kartenpole) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Spielstandmenü (AktuelleZeile - Kartenpole));
                  
               elsif
                 AktuelleZeile in Spielstandmenü + 1 .. Editorenmenü
               then
                  Menuetexte.Editorenmenü (AktuelleZeile - Spielstandmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                             EingelesenerTextExtern => Zwischenspeicher,
                                                                                             VorhandenerTextExtern  => Menuetexte.Editorenmenü (AktuelleZeile - Spielstandmenü));
                  
                  -- Das else hier kann für das letzte Menü verwendet werden. äöü
               else
                  return;
               end if;
               
               if
                 AktuelleZeile < Editorenmenü
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop MenüSchleife;
      
   end Menüs;
   
   
   
   procedure Basisgrund
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      BasisgrundSchleife:
      for ZeileSchleifenwert in Kartentexte.Basisgrund'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Basisgrund")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Basisgrund: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Kartentexte.Basisgrund (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Basisgrund (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Basisgrund (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Basisgrund (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
                        
      end loop BasisgrundSchleife;
      
   end Basisgrund;
   
   
   
   procedure Verbesserungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      VerbesserungenSchleife:
      for ZeileSchleifenwert in Kartentexte.Verbesserungen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Verbesserungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Verbesserungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Kartentexte.Verbesserungen (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Verbesserungen (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Verbesserungen (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Verbesserungen (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop VerbesserungenSchleife;
      
   end Verbesserungen;
   
   
   
   procedure Beschäftigungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      BeschäftigungenSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Beschäftigungen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Beschäftigungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Beschäftigungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               GlobaleTexte.Beschäftigungen (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Beschäftigungen (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Beschäftigungen (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Beschäftigungen (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure Würdigung
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      WürdigungSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Würdigung'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Würdigung")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Würdigung: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               GlobaleTexte.Würdigung (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Würdigung (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Würdigung (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Würdigung (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WürdigungSchleife;
      
   end Würdigung;
   
   
   
   procedure DiplomatieKI
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      DiplomatieKISchleife:
      for ZeileSchleifenwert in GlobaleTexte.DiplomatieKI'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.DiplomatieKI")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.DiplomatieKI: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               GlobaleTexte.DiplomatieKI (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.DiplomatieKI (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.DiplomatieKI (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.DiplomatieKI (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop DiplomatieKISchleife;
      
   end DiplomatieKI;
   
   
   
   procedure Handelsmenü
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      HandelsmenüSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Handelsmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Handelsmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Handelsmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               GlobaleTexte.Handelsmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Handelsmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Handelsmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Handelsmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop HandelsmenüSchleife;
      
   end Handelsmenü;
   
   
   
   procedure DiplomatieStatus
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      DiplomatieStatusSchleife:
      for ZeileSchleifenwert in GlobaleTexte.DiplomatieStatus'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.DiplomatieStatus")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.DiplomatieStatus: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop DiplomatieStatusSchleife;
      
   end DiplomatieStatus;
   
   
   
   procedure Angebot
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      AngebotSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Angebot'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Spielmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spielmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               GlobaleTexte.Angebot (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Angebot (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Angebot (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Angebot (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop AngebotSchleife;
      
   end Angebot;
   
   
   
   procedure Fehlermeldung
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      FehlermeldungSchleife:
      for ZeileSchleifenwert in Meldungstexte.Meldung'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Fehlermeldung")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Fehlermeldung: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Meldungstexte.Meldung (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Meldungstexte.Meldung (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Meldungstexte.Meldung (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Meldungstexte.Meldung (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop FehlermeldungSchleife;
      
   end Fehlermeldung;
   
   
   
   procedure Ladezeit
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      LadezeitSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Ladezeit'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Ladezeit")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Ladezeit: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               GlobaleTexte.Ladezeit (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Ladezeit (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Ladezeit (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop LadezeitSchleife;
      
   end Ladezeit;
   
   
   
   procedure Frage
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      FrageSchleife:
      for ZeileSchleifenwert in Meldungstexte.Frage'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Frage")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Frage: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Meldungstexte.Frage (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Meldungstexte.Frage (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Meldungstexte.Frage (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Meldungstexte.Frage (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop FrageSchleife;
      
   end Frage;
   
   
   
   procedure ZeugSachen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      ZeugSachenSchleife:
      for ZeileSchleifenwert in Meldungstexte.Zeug'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.ZeugSachen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.ZeugSachen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Meldungstexte.Zeug (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Meldungstexte.Zeug (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Meldungstexte.Zeug (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Meldungstexte.Zeug (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop ZeugSachenSchleife;
      
   end ZeugSachen;
      
   
   
   procedure Wege
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Wege'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Wege")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Wege: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Kartentexte.Wege (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Wege (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Wege (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Wege (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WegeSchleife;
      
   end Wege;
      
   
   
   procedure Kartenflüsse
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenflüsse'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartenflüsse")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenflüsse: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Kartentexte.Kartenflüsse (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Kartenflüsse (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Kartenflüsse (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Kartenflüsse (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WegeSchleife;
      
   end Kartenflüsse;
      
   
   
   procedure Kartenressourcen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenressourcen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartenressourcen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenressourcen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Kartentexte.Kartenressourcen (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Kartenressourcen (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Kartenressourcen (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Kartenressourcen (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WegeSchleife;
      
   end Kartenressourcen;
   
   
   
   procedure Stadtbefehle
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      StadtbefehleSchleife:
      for ZeileSchleifenwert in Befehlstexte.Stadtbefehle'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Stadtbefehle")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Stadtbefehle: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Befehlstexte.Stadtbefehle (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Befehlstexte.Stadtbefehle (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Befehlstexte.Stadtbefehle (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Befehlstexte.Stadtbefehle (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop StadtbefehleSchleife;
      
   end Stadtbefehle;
   
   
   
   procedure Intro
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      IntroSchleife:
      for ZeileSchleifenwert in Spieltexte.Intro'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Intro")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Intro: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Spieltexte.Intro (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Spieltexte.Intro (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Spieltexte.Intro (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Spieltexte.Intro (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop IntroSchleife;
      
   end Intro;
   
   
   
   procedure Outro
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      OutroSchleife:
      for ZeileSchleifenwert in Spieltexte.Outro'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Outro")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Outro: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Spieltexte.Outro (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Spieltexte.Outro (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Spieltexte.Outro (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Spieltexte.Outro (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop OutroSchleife;
      
   end Outro;
   
   
   
   procedure Zusatzgrund
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      ZusatzgrundSchleife:
      for ZeileSchleifenwert in Kartentexte.Zusatzgrund'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Zusatzgrund")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Zusatzgrund: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Kartentexte.Zusatzgrund (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Zusatzgrund (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Zusatzgrund (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Zusatzgrund (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop ZusatzgrundSchleife;
      
   end Zusatzgrund;
   
   
   
   procedure Feldeffekte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      FeldeffekteSchleife:
      for ZeileSchleifenwert in Kartentexte.Feldeffekte'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Feldeffekte")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Feldeffekte: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Kartentexte.Feldeffekte (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Feldeffekte (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Feldeffekte (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Feldeffekte (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop FeldeffekteSchleife;
      
   end Feldeffekte;
   
   
   
   function TextErsetzen
     (TextExtern : in Wide_Wide_String)
      return Unbounded_Wide_Wide_String
   is begin
      
      ErsetzungSchleife:
      for ErsetzungSchleifenwert in ErsetzungenEingelesenArray'Range loop
         
         if
           TextExtern = ErsetzungSchleifenwert * '~'
         then
            return ErsetzungenEingelesen (TextExtern'Length);
            
         else
            null;
         end if;
         
      end loop ErsetzungSchleife;
        
      return To_Unbounded_Wide_Wide_String (Source => TextExtern);
      
   end TextErsetzen;
   
   
   
   -- Das nach EinlesenAllgemeinesLogik verschieben? äöü
   function Einsprachig
     (EinsprachigExtern : in Boolean;
      EingelesenerTextExtern : in Unbounded_Wide_Wide_String;
      VorhandenerTextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        EinsprachigExtern
      is
         when True =>
            return EingelesenerTextExtern;
               
         when False =>
            if
              VorhandenerTextExtern = TextKonstanten.FehlenderText
              or
                To_Wide_Wide_String (Source => VorhandenerTextExtern)'Length < To_Wide_Wide_String (Source => EingelesenerTextExtern)'Length
            then
               return EingelesenerTextExtern;
                  
            else
               return VorhandenerTextExtern;
            end if;
      end case;
      
   end Einsprachig;

end EinlesenTextLogik;
