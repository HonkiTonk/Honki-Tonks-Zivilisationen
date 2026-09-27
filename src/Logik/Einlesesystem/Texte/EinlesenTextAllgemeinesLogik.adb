with EinlesenAllgemeinesHTSEB;
with TextKonstantenHTSEB;
with MeldungssystemHTSEB;

with EinlesenTextSonstigesLogik;

package body EinlesenTextAllgemeinesLogik is
   
   procedure AllgemeineTexte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      MeldungSchleife:
      loop
         
         case
           EinlesenAllgemeinesHTSEB.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextAllgemeinesLogik.AllgemeineTexte")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextAllgemeinesLogik.AllgemeineTexte: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenTextSonstigesLogik.TextErsetzen (TextExtern => EinlesenAllgemeinesHTSEB.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                                           AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                                           DateinameExtern     => "EinlesenTextAllgemeinesLogik.AllgemeineTexte"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstantenHTSEB.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Fragen
               then
                  Spieltexte.Fragen (AktuelleZeile) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                               VorhandenerTextExtern  => Spieltexte.Fragen (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Fragen + 1 .. Meldungen
               then
                  Spieltexte.Meldungen (AktuelleZeile - Fragen) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                           EingelesenerTextExtern => Zwischenspeicher,
                                                                                                           VorhandenerTextExtern  => Spieltexte.Meldungen (AktuelleZeile - Fragen));
                  
               elsif
                 AktuelleZeile in Meldungen + 1 .. Würdigungen
               then
                  Spieltexte.Würdigungen (AktuelleZeile - Meldungen) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                 VorhandenerTextExtern  => Spieltexte.Würdigungen (AktuelleZeile - Meldungen));
                  
               elsif
                 AktuelleZeile in Würdigungen + 1 .. Zeug
               then
                  Spieltexte.Zeug (AktuelleZeile - Würdigungen) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                            EingelesenerTextExtern => Zwischenspeicher,
                                                                                                            VorhandenerTextExtern  => Spieltexte.Zeug (AktuelleZeile - Würdigungen));
                  
               elsif
                 AktuelleZeile in Zeug + 1 .. Stadtbefehle
               then
                  Spieltexte.Stadtbefehle (AktuelleZeile - Zeug) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                            EingelesenerTextExtern => Zwischenspeicher,
                                                                                                            VorhandenerTextExtern  => Spieltexte.Stadtbefehle (AktuelleZeile - Zeug));
                  
               elsif
                 AktuelleZeile in Stadtbefehle + 1 .. Ladezeiten
               then
                  Spieltexte.Ladezeiten (AktuelleZeile - Stadtbefehle) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                  EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                  VorhandenerTextExtern  => Spieltexte.Ladezeiten (AktuelleZeile - Stadtbefehle));
                  
               elsif
                 AktuelleZeile in Ladezeiten + 1 .. Beschäftigungen
               then
                  Spieltexte.Beschäftigungen (AktuelleZeile - Ladezeiten) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                      EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                      VorhandenerTextExtern  => Spieltexte.Beschäftigungen (AktuelleZeile - Ladezeiten));
                  
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextAllgemeinesLogik.AllgemeineTexte: Außerhalb des Einlesebereichs");
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

end EinlesenTextAllgemeinesLogik;
