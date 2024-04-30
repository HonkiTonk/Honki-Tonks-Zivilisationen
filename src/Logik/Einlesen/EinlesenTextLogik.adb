with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with SpeziesKonstanten;
with StadtDatentypen;
with ForschungenDatentypen;
with EinheitenDatentypen;

with LeseOptionen;

with Fehlermeldungssystem;
with EinlesenAllgemeinesLogik;

with VerzeichnisDateinamenTests;

-- Bei allen Einlesungen noch eine Pfadbegrenzung auf 256 Zeichen einbauen! äöü
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
      
            Debugmenü;
            
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
         
               if
                 EinlesenAllgemeinesLogik.VerboteneVerzeichnissnamen (NameExtern => Simple_Name (Directory_Entry => Verzeichnis)) = True
               then
                  null;
            
               elsif
                 -- Das hier noch durch eine Windows uns eine Linuxversion ersetzen. äöü
                 -- Kann das nicht einfach raus wenn irgendwann einmal Wide_Wide_Directories da ist? äöü
                 -- Das ist je nur vorhandene Ordner durchgehen und man kann ja keine Dateien/Ordner anlegen die das Dateisystem nicht unterstützen. äöü
                 VerzeichnisDateinamenTests.GültigerNamen (NameExtern => Decode (Item => Simple_Name (Directory_Entry => Verzeichnis))) = False
               then
                  null;
             
               elsif
                 -- Das ausgeklammerte funktioniert unter Windwos nicht, wenn man Sonderzeichen verwendet.
                 -- EinlesenAllgemeinesLogik.LeeresVerzeichnis (VerzeichnisExtern => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis)) = True
                 Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.NullDatei) = False
               then
                  null;
            
               else
                  Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & Decode (Item => Simple_Name (Directory_Entry => Verzeichnis)) & "/"),
                            EinsprachigExtern => EinsprachigExtern);
               end if;
               
            end loop SprachenSchleife;
            
            End_Search (Search => Suche);
      end case;
      
   end EinlesenDateien;
   
   
   
   procedure Debugmenü
   is begin
      
      Menuetexte.Debugmenü (1) := To_Unbounded_Wide_Wide_String (Source => "Debugmenü");
      Menuetexte.Debugmenü (2) := To_Unbounded_Wide_Wide_String (Source => "Karte aufdecken");
      Menuetexte.Debugmenü (3) := To_Unbounded_Wide_Wide_String (Source => "Alle Technologien");
      Menuetexte.Debugmenü (4) := To_Unbounded_Wide_Wide_String (Source => "Mensch/KI tauschen");
      Menuetexte.Debugmenü (5) := To_Unbounded_Wide_Wide_String (Source => "Diplomatischen Status ändern");
      Menuetexte.Debugmenü (6) := To_Unbounded_Wide_Wide_String (Source => "Volle Forschung");
      Menuetexte.Debugmenü (7) := To_Unbounded_Wide_Wide_String (Source => "Einheit erzeugen");
      Menuetexte.Debugmenü (8) := To_Unbounded_Wide_Wide_String (Source => "Einsprachig/Mehrsprachig");
      Menuetexte.Debugmenü (9) := To_Unbounded_Wide_Wide_String (Source => "Teststopp");
      Menuetexte.Debugmenü (10) := To_Unbounded_Wide_Wide_String (Source => "Eingelesene Texte ausgeben");
      Menuetexte.Debugmenü (11) := To_Unbounded_Wide_Wide_String (Source => "Fertig");
      
   end Debugmenü;
      
      
      
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                            AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Einlesen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Einlesen: Fehlende Zeilen, aktuelle Zeile: " & WelcheDateienSchleifenwert'Wide_Wide_Image);
               exit EinlesenSchleife;
               
            when False =>
               EinlesenAufteilen (WelcheDateiExtern => WelcheDateienSchleifenwert,
                                  VerzeichnisExtern => VerzeichnisExtern & EinlesenAllgemeinesLogik.TextEinlesen (DateiExtern         => DateiVerzeichnisse,
                                                                                                                  AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                                                                                  DateinameExtern     => "EinlesenTextLogik.Einlesen"),
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
            AllgemeineTexte (DateiExtern       => DateiText,
                             EinsprachigExtern => EinsprachigExtern);
            
         when 4 =>
            Sequenzen (DateiExtern       => DateiText,
                       EinsprachigExtern => EinsprachigExtern);
               
         when 5 =>
            Karte (DateiExtern       => DateiText,
                   EinsprachigExtern => EinsprachigExtern);
            
         when 5 + SpeziesKonstanten.Speziesanfang .. 5 + SpeziesKonstanten.Speziesende =>
            Spezies (DateiExtern       => DateiText,
                     EinsprachigExtern => EinsprachigExtern,
                     SpeziesExtern     => SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (WelcheDateiExtern - 5));
            
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Ersetzungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Ersetzungen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => EinzulesendeZeile,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Ersetzungen");
               EinzulesendeZeile := EinzulesendeZeile + 1;
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Menüs")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Menüs: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := TextErsetzen (TextExtern => EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                DateinameExtern     => "EinlesenTextLogik.Menüs"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
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
                  Menuetexte.Spieleinstellungsmenü (AktuelleZeile - Steuerungsmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                      EingelesenerTextExtern => Zwischenspeicher,
                                                                                                      VorhandenerTextExtern  => Menuetexte.Spieleinstellungsmenü (AktuelleZeile - Steuerungsmenü));
                  
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
                  
               elsif
                 AktuelleZeile in Editorenmenü + 1 .. Handelsmenü
               then
                  Menuetexte.Handelsmenü (AktuelleZeile - Editorenmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Editorenmenü (AktuelleZeile - Editorenmenü));
                  
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Menüs: Außerhalb des Einlesebereichs");
                  return;
               end if;
               
               if
                 AktuelleZeile < Handelsmenü
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop MenüSchleife;
      
   end Menüs;
   
   
   
   procedure AllgemeineTexte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      MeldungSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.AllgemeineTexte")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Meldungen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := TextErsetzen (TextExtern => EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                DateinameExtern     => "EinlesenTextLogik.AllgemeineTexte"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Fragen
               then
                  Spieltexte.Fragen (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                    VorhandenerTextExtern  => Spieltexte.Fragen (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Fragen + 1 .. Meldungen
               then
                  Spieltexte.Meldungen (AktuelleZeile - Fragen) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                EingelesenerTextExtern => Zwischenspeicher,
                                                                                VorhandenerTextExtern  => Spieltexte.Meldungen (AktuelleZeile - Fragen));
                  
               elsif
                 AktuelleZeile in Meldungen + 1 .. Würdigungen
               then
                  Spieltexte.Würdigungen (AktuelleZeile - Meldungen) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                                    VorhandenerTextExtern  => Spieltexte.Würdigungen (AktuelleZeile - Meldungen));
                  
               elsif
                 AktuelleZeile in Würdigungen + 1 .. Zeug
               then
                  Spieltexte.Zeug (AktuelleZeile - Würdigungen) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                 VorhandenerTextExtern  => Spieltexte.Zeug (AktuelleZeile - Würdigungen));
                  
               elsif
                 AktuelleZeile in Zeug + 1 .. Stadtbefehle
               then
                  Spieltexte.Stadtbefehle (AktuelleZeile - Zeug) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                 VorhandenerTextExtern  => Spieltexte.Stadtbefehle (AktuelleZeile - Zeug));
                  
               elsif
                 AktuelleZeile in Stadtbefehle + 1 .. Ladezeiten
               then
                  Spieltexte.Ladezeiten (AktuelleZeile - Stadtbefehle) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                                     VorhandenerTextExtern  => Spieltexte.Ladezeiten (AktuelleZeile - Stadtbefehle));
                  
               elsif
                 AktuelleZeile in Ladezeiten + 1 .. Beschäftigungen
               then
                  Spieltexte.Beschäftigungen (AktuelleZeile - Ladezeiten) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                           EingelesenerTextExtern => Zwischenspeicher,
                                                                                           VorhandenerTextExtern  => Spieltexte.Beschäftigungen (AktuelleZeile - Ladezeiten));
                  
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.AllgemeineTexte: Außerhalb des Einlesebereichs");
                  return;
               end if;
               
               if
                 AktuelleZeile < Beschäftigungen
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop MeldungSchleife;
      
   end AllgemeineTexte;
   
   
   
   procedure Sequenzen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      SequenzenSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Sequenzen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Sequenzen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := TextErsetzen (TextExtern => EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                DateinameExtern     => "EinlesenTextLogik.Sequenzen"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Intro
               then
                  Sequenzentexte.Intro (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                       VorhandenerTextExtern  => Sequenzentexte.Intro (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Intro + 1 .. Outro
               then
                  Sequenzentexte.Outro (AktuelleZeile - Intro) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                               VorhandenerTextExtern  => Sequenzentexte.Outro (AktuelleZeile - Intro));
                  
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Sequenzen: Außerhalb des Einlesebereichs");
                  return;
               end if;
               
               if
                 AktuelleZeile < Outro
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop SequenzenSchleife;
      
   end Sequenzen;
   
   
   
   procedure Karte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      KarteSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Karte")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Karte: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := TextErsetzen (TextExtern => EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                DateinameExtern     => "EinlesenTextLogik.Karte"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Basisgrund
               then
                  Kartentexte.Basisgrund (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                         EingelesenerTextExtern => Zwischenspeicher,
                                                                         VorhandenerTextExtern  => Kartentexte.Basisgrund (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Basisgrund + 1 .. Zusatzgrund
               then
                  Kartentexte.Zusatzgrund (AktuelleZeile - Basisgrund) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                                       VorhandenerTextExtern  => Kartentexte.Zusatzgrund (AktuelleZeile - Basisgrund));
                  
               elsif
                 AktuelleZeile in Zusatzgrund + 1 .. Flüsse
               then
                  Kartentexte.Flüsse (AktuelleZeile - Zusatzgrund) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                                    VorhandenerTextExtern  => Kartentexte.Flüsse (AktuelleZeile - Zusatzgrund));
                  
               elsif
                 AktuelleZeile in Flüsse + 1 .. Ressourcen
               then
                  Kartentexte.Ressourcen (AktuelleZeile - Flüsse) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                   EingelesenerTextExtern => Zwischenspeicher,
                                                                                   VorhandenerTextExtern  => Kartentexte.Ressourcen (AktuelleZeile - Flüsse));
                  
               elsif
                 AktuelleZeile in Ressourcen + 1 .. Feldeffekte
               then
                  Kartentexte.Feldeffekte (AktuelleZeile - Ressourcen) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                                       VorhandenerTextExtern  => Kartentexte.Feldeffekte (AktuelleZeile - Ressourcen));
                  
               elsif
                 AktuelleZeile in Feldeffekte + 1 .. Verbesserungen
               then
                  Kartentexte.Verbesserungen (AktuelleZeile - Feldeffekte) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                           EingelesenerTextExtern => Zwischenspeicher,
                                                                                           VorhandenerTextExtern  => Kartentexte.Verbesserungen (AktuelleZeile - Feldeffekte));
                  
               elsif
                 AktuelleZeile in Verbesserungen + 1 .. Wege
               then
                  Kartentexte.Wege (AktuelleZeile - Verbesserungen) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                                    VorhandenerTextExtern  => Kartentexte.Wege (AktuelleZeile - Verbesserungen));
                  
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Karte: Außerhalb des Einlesebereichs");
                  return;
               end if;
               
               if
                 AktuelleZeile < Wege
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop KarteSchleife;
      
   end Karte;
   
   
   
   procedure Spezies
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      ZeilenumwandlungsabzugForschungen := 0;
      ZeilenumwandlungsabzugEinheiten := 0;
      ZeilenumwandlungsabzugGebäude := 0;
      
      SpeziesSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Spezies")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spezies: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := TextErsetzen (TextExtern => EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                DateinameExtern     => "EinlesenTextLogik.Spezies"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= NameBeschreibung
               then
                  Speziestexte.NameBeschreibung (SpeziesExtern, AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                               VorhandenerTextExtern  => Speziestexte.NameBeschreibung (SpeziesExtern, AktuelleZeile));
                  
               elsif
                 AktuelleZeile in NameBeschreibung + 1 .. Städtenamen
               then
                  Speziestexte.Städtenamen (SpeziesExtern, StadtDatentypen.StädtebereichVorhanden (AktuelleZeile - NameBeschreibung))
                    := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                    EingelesenerTextExtern => Zwischenspeicher,
                                    VorhandenerTextExtern  => Speziestexte.Städtenamen (SpeziesExtern, StadtDatentypen.StädtebereichVorhanden (AktuelleZeile - NameBeschreibung)));
                  
               elsif
                 AktuelleZeile in Städtenamen + 1 .. Forschungen
               then
                  case
                    AktuelleZeile mod 2
                  is
                     when 0 =>
                        ZeilenumwandlungsabzugForschungen := ZeilenumwandlungsabzugForschungen + 1;
                        ZeilenumwandlungForschungen := AktuelleZeile - Städtenamen - ZeilenumwandlungsabzugForschungen;
                        
                        Speziestexte.Forschungen (SpeziesExtern, ForschungenDatentypen.ForschungIDVorhanden (ZeilenumwandlungForschungen), 2)
                          := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                          EingelesenerTextExtern => Zwischenspeicher,
                                          VorhandenerTextExtern  => Speziestexte.Forschungen (SpeziesExtern, ForschungenDatentypen.ForschungIDVorhanden (ZeilenumwandlungForschungen), 2));
                        
                     when others =>
                        ZeilenumwandlungForschungen := AktuelleZeile - Städtenamen - ZeilenumwandlungsabzugForschungen;
                        
                        Speziestexte.Forschungen (SpeziesExtern, ForschungenDatentypen.ForschungIDVorhanden (ZeilenumwandlungForschungen), 1)
                          := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                          EingelesenerTextExtern => Zwischenspeicher,
                                          VorhandenerTextExtern  => Speziestexte.Forschungen (SpeziesExtern, ForschungenDatentypen.ForschungIDVorhanden (ZeilenumwandlungForschungen), 1));
                  end case;
                  
               elsif
                 AktuelleZeile in Forschungen + 1 .. Einheiten
               then
                  case
                    AktuelleZeile mod 2
                  is
                     when 0 =>
                        ZeilenumwandlungsabzugEinheiten := ZeilenumwandlungsabzugEinheiten + 1;
                        ZeilenumwandlungEinheiten := AktuelleZeile - Forschungen - ZeilenumwandlungsabzugEinheiten;
                        
                        Speziestexte.Einheiten (SpeziesExtern, EinheitenDatentypen.EinheitenID (ZeilenumwandlungEinheiten), 2)
                          := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                          EingelesenerTextExtern => Zwischenspeicher,
                                          VorhandenerTextExtern  => Speziestexte.Einheiten (SpeziesExtern, EinheitenDatentypen.EinheitenID (ZeilenumwandlungEinheiten), 2));
                        
                     when others =>
                        ZeilenumwandlungEinheiten := AktuelleZeile - Forschungen - ZeilenumwandlungsabzugEinheiten;
                        
                        Speziestexte.Einheiten (SpeziesExtern, EinheitenDatentypen.EinheitenID (ZeilenumwandlungEinheiten), 1)
                          := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                          EingelesenerTextExtern => Zwischenspeicher,
                                          VorhandenerTextExtern  => Speziestexte.Einheiten (SpeziesExtern, EinheitenDatentypen.EinheitenID (ZeilenumwandlungEinheiten), 1));
                  end case;
                  
               elsif
                 AktuelleZeile in Einheiten + 1 .. Gebäude
               then
                  case
                    AktuelleZeile mod 2
                  is
                     when 0 =>
                        ZeilenumwandlungsabzugGebäude := ZeilenumwandlungsabzugGebäude + 1;
                        ZeilenumwandlungGebäude := AktuelleZeile - Einheiten - ZeilenumwandlungsabzugGebäude;
                        
                        Speziestexte.Gebäude (SpeziesExtern, StadtDatentypen.GebäudeIDVorhanden (ZeilenumwandlungGebäude), 2)
                          := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                          EingelesenerTextExtern => Zwischenspeicher,
                                          VorhandenerTextExtern  => Speziestexte.Gebäude (SpeziesExtern, StadtDatentypen.GebäudeIDVorhanden (ZeilenumwandlungGebäude), 2));
                        
                     when others =>
                        ZeilenumwandlungGebäude := AktuelleZeile - Einheiten - ZeilenumwandlungsabzugGebäude;
                        
                        Speziestexte.Gebäude (SpeziesExtern, StadtDatentypen.GebäudeIDVorhanden (ZeilenumwandlungGebäude), 1)
                          := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                          EingelesenerTextExtern => Zwischenspeicher,
                                          VorhandenerTextExtern  => Speziestexte.Gebäude (SpeziesExtern, StadtDatentypen.GebäudeIDVorhanden (ZeilenumwandlungGebäude), 1));
                  end case;
                                                                                                                                                
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spezies: Außerhalb des Einlesebereichs");
                  return;
               end if;
                                                                                                                                                
               if
                 AktuelleZeile < Gebäude
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop SpeziesSchleife;
      
   end Spezies;
   
   
   
   function TextErsetzen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String
   is begin
      
      ErsetzungSchleife:
      for ErsetzungSchleifenwert in ErsetzungenEingelesenArray'Range loop
         
         if
           TextExtern = '~' & ZahlAlsString (ZahlExtern => ErsetzungSchleifenwert) & '~'
         then
            return ErsetzungenEingelesen (ErsetzungSchleifenwert);
            
         else
            null;
         end if;
         
      end loop ErsetzungSchleife;
        
      return TextExtern;
      
   end TextErsetzen;
   
   
   
   -- Das nach EinlesenAllgemeinesLogik verschieben? äöü
   -- Wird vermutlich nur hier jemals gebraucht werden, also hier lassen? äöü
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
                -- Sollte das nicht besser nach der grafischen Länge statt der Anzahl der Zeichen beurteilt werden? äöü
              To_Wide_Wide_String (Source => VorhandenerTextExtern)'Length < To_Wide_Wide_String (Source => EingelesenerTextExtern)'Length
            then
               return EingelesenerTextExtern;
                  
            else
               return VorhandenerTextExtern;
            end if;
      end case;
      
   end Einsprachig;

end EinlesenTextLogik;
