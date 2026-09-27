with EinlesenAllgemeinesHTSEB;
with MeldungssystemHTSEB;
with TextKonstantenHTSEB;

with EinlesenTextSonstigesLogik;

package body EinlesenTextMenuesLogik is
   
   procedure Menüs
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      MenüSchleife:
      loop
         
         case
           EinlesenAllgemeinesHTSEB.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextMenuesLogik.Menüs")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextMenuesLogik.Menüs: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenTextSonstigesLogik.TextErsetzen (TextExtern => EinlesenAllgemeinesHTSEB.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                                           AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                                           DateinameExtern     => "EinlesenTextMenuesLogik.Menüs"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstantenHTSEB.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Hauptmenü
               then
                  Menuetexte.Hauptmenü (AktuelleZeile) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                   EingelesenerTextExtern => Zwischenspeicher,
                                                                                                   VorhandenerTextExtern  => Menuetexte.Hauptmenü (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Hauptmenü + 1 .. Spielmenü
               then
                  Menuetexte.Spielmenü (AktuelleZeile - Hauptmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                VorhandenerTextExtern  => Menuetexte.Spielmenü (AktuelleZeile - Hauptmenü));
                  
               elsif
                 AktuelleZeile in Spielmenü + 1 .. Optionsmenü
               then
                  Menuetexte.Optionsmenü (AktuelleZeile - Spielmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                  EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                  VorhandenerTextExtern  => Menuetexte.Optionsmenü (AktuelleZeile - Spielmenü));
                  
               elsif
                 AktuelleZeile in Optionsmenü + 1 .. Grafikmenü
               then
                  Menuetexte.Grafikmenü (AktuelleZeile - Optionsmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                   EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                   VorhandenerTextExtern  => Menuetexte.Grafikmenü (AktuelleZeile - Optionsmenü));
                  
               elsif
                 AktuelleZeile in Grafikmenü + 1 .. Soundmenü
               then
                  Menuetexte.Soundmenü (AktuelleZeile - Grafikmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                 VorhandenerTextExtern  => Menuetexte.Soundmenü (AktuelleZeile - Grafikmenü));
                  
               elsif
                 AktuelleZeile in Soundmenü + 1 .. Steuerungsmenü
               then
                  Menuetexte.Steuerungsmenü (AktuelleZeile - Soundmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                     VorhandenerTextExtern  => Menuetexte.Steuerungsmenü (AktuelleZeile - Soundmenü));
                  
               elsif
                 AktuelleZeile in Steuerungsmenü + 1 .. Sonstigesmenü
               then
                  Menuetexte.Spieleinstellungsmenü (AktuelleZeile - Steuerungsmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                                 VorhandenerTextExtern  => Menuetexte.Spieleinstellungsmenü (AktuelleZeile - Steuerungsmenü));
                  
               elsif
                 AktuelleZeile in Sonstigesmenü + 1 .. Kartengröße
               then
                  Menuetexte.Kartengröße (AktuelleZeile - Sonstigesmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                       VorhandenerTextExtern  => Menuetexte.Kartengröße (AktuelleZeile - Sonstigesmenü));
                  
               elsif
                 AktuelleZeile in Kartengröße + 1 .. Kartenebene
               then
                  Menuetexte.Kartenebene (AktuelleZeile - Kartengröße) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                    VorhandenerTextExtern  => Menuetexte.Kartenebene (AktuelleZeile - Kartengröße));
                  
               elsif
                 AktuelleZeile in Kartenebene + 1 .. Kartenart
               then
                  Menuetexte.Kartenart (AktuelleZeile - Kartenebene) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                VorhandenerTextExtern  => Menuetexte.Kartenart (AktuelleZeile - Kartenebene));
                  
               elsif
                 AktuelleZeile in Kartenart + 1 .. Kartentemperatur
               then
                  Menuetexte.Kartentemperatur (AktuelleZeile - Kartenart) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                     VorhandenerTextExtern  => Menuetexte.Kartentemperatur (AktuelleZeile - Kartenart));
                  
               elsif
                 AktuelleZeile in Kartentemperatur + 1 .. Speziesauswahl
               then
                  Menuetexte.Speziesauswahl (AktuelleZeile - Kartentemperatur) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                          VorhandenerTextExtern  => Menuetexte.Speziesauswahl (AktuelleZeile - Kartentemperatur));
                  
               elsif
                 AktuelleZeile in Speziesauswahl + 1 .. Schwierigkeitsgrad
               then
                  Menuetexte.Schwierigkeitsgrad (AktuelleZeile - Speziesauswahl) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                            EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                            VorhandenerTextExtern  => Menuetexte.Schwierigkeitsgrad (AktuelleZeile - Speziesauswahl));
                  
               elsif
                 AktuelleZeile in Schwierigkeitsgrad + 1 .. Kartenform
               then
                  Menuetexte.Kartenform (AktuelleZeile - Schwierigkeitsgrad) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                        EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                        VorhandenerTextExtern  => Menuetexte.Kartenform (AktuelleZeile - Schwierigkeitsgrad));
                  
               elsif
                 AktuelleZeile in Kartenform + 1 .. Rohstoffemenge
               then
                  Menuetexte.Rohstoffemenge (AktuelleZeile - Kartenform) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                    VorhandenerTextExtern  => Menuetexte.Rohstoffemenge (AktuelleZeile - Kartenform));
                  
               elsif
                 AktuelleZeile in Rohstoffemenge + 1 .. Diplomatiemenü
               then
                  Menuetexte.Diplomatiemenü (AktuelleZeile - Rohstoffemenge) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                         EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                         VorhandenerTextExtern  => Menuetexte.Diplomatiemenü (AktuelleZeile - Rohstoffemenge));
                  
               elsif
                 AktuelleZeile in Diplomatiemenü + 1 .. Einstellungsmenü
               then
                  Menuetexte.Einstellungsmenü (AktuelleZeile - Diplomatiemenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                            EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                            VorhandenerTextExtern  => Menuetexte.Einstellungsmenü (AktuelleZeile - Diplomatiemenü));
                  
               elsif
                 AktuelleZeile in Einstellungsmenü + 1 .. Kartenpole
               then
                  Menuetexte.Kartenpole (AktuelleZeile - Einstellungsmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                       VorhandenerTextExtern  => Menuetexte.Kartenpole (AktuelleZeile - Einstellungsmenü));
                  
               elsif
                 AktuelleZeile in Kartenpole + 1 .. Spielstandmenü
               then
                  Menuetexte.Spielstandmenü (AktuelleZeile - Kartenpole) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                     VorhandenerTextExtern  => Menuetexte.Spielstandmenü (AktuelleZeile - Kartenpole));
                  
               elsif
                 AktuelleZeile in Spielstandmenü + 1 .. Editorenmenü
               then
                  Menuetexte.Editorenmenü (AktuelleZeile - Spielstandmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                        EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                        VorhandenerTextExtern  => Menuetexte.Editorenmenü (AktuelleZeile - Spielstandmenü));
                  
               elsif
                 AktuelleZeile in Editorenmenü + 1 .. Handelsmenü
               then
                  Menuetexte.Handelsmenü (AktuelleZeile - Editorenmenü) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                     VorhandenerTextExtern  => Menuetexte.Editorenmenü (AktuelleZeile - Editorenmenü));
                  
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextMenuesLogik.Menüs: Außerhalb des Einlesebereichs");
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

end EinlesenTextMenuesLogik;
