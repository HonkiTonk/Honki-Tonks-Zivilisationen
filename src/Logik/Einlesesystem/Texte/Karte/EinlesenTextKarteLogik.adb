with EinlesenAllgemeinesHTSEB;
with MeldungssystemHTSEB;
with TextKonstantenHTSEB;

with EinlesenTextSonstigesLogik;

package body EinlesenTextKarteLogik is
   
   procedure Karte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      KarteSchleife:
      loop
         
         case
           EinlesenAllgemeinesHTSEB.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextKarteLogik.Karte")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextKarteLogik.Karte: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenTextSonstigesLogik.TextErsetzen (TextExtern => EinlesenAllgemeinesHTSEB.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                                           AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                                           DateinameExtern     => "EinlesenTextKarteLogik.Karte"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstantenHTSEB.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Basisgrund
               then
                  Kartentexte.Basisgrund (AktuelleZeile) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                                                    VorhandenerTextExtern  => Kartentexte.Basisgrund (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Basisgrund + 1 .. Zusatzgrund
               then
                  Kartentexte.Zusatzgrund (AktuelleZeile - Basisgrund) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                  EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                  VorhandenerTextExtern  => Kartentexte.Zusatzgrund (AktuelleZeile - Basisgrund));
                  
               elsif
                 AktuelleZeile in Zusatzgrund + 1 .. Flüsse
               then
                  Kartentexte.Flüsse (AktuelleZeile - Zusatzgrund) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                                               VorhandenerTextExtern  => Kartentexte.Flüsse (AktuelleZeile - Zusatzgrund));
                  
               elsif
                 AktuelleZeile in Flüsse + 1 .. Feldeffekte
               then
                  Kartentexte.Feldeffekte (AktuelleZeile - Flüsse) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                                               VorhandenerTextExtern  => Kartentexte.Feldeffekte (AktuelleZeile - Flüsse));
                  
               elsif
                 AktuelleZeile in Feldeffekte + 1 .. Verbesserungen
               then
                  Kartentexte.Verbesserungen (AktuelleZeile - Feldeffekte) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                      EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                      VorhandenerTextExtern  => Kartentexte.Verbesserungen (AktuelleZeile - Feldeffekte));
                  
               elsif
                 AktuelleZeile in Verbesserungen + 1 .. Wege
               then
                  Kartentexte.Wege (AktuelleZeile - Verbesserungen) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                                               VorhandenerTextExtern  => Kartentexte.Wege (AktuelleZeile - Verbesserungen));
                  
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextKarteLogik.Karte: Außerhalb des Einlesebereichs");
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

end EinlesenTextKarteLogik;
