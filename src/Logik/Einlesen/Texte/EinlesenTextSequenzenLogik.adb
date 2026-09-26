with EinlesenAllgemeinesHTSEB;
with TextKonstantenHTSEB;
with MeldungssystemHTSEB;

with EinlesenTextSonstigesLogik;

package body EinlesenTextSequenzenLogik is
   
   procedure Sequenzen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      SequenzenSchleife:
      loop
         
         case
           EinlesenAllgemeinesHTSEB.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextSequenzenLogik.Sequenzen")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextSequenzenLogik.Sequenzen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenTextSonstigesLogik.TextErsetzen (TextExtern => EinlesenAllgemeinesHTSEB.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                                           AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                                           DateinameExtern     => "EinlesenTextSequenzenLogik.Sequenzen"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstantenHTSEB.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Intro
               then
                  Sequenzentexte.Intro (AktuelleZeile) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                  EingelesenerTextExtern => Zwischenspeicher,
                                                                                                  VorhandenerTextExtern  => Sequenzentexte.Intro (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Intro + 1 .. Outro
               then
                  Sequenzentexte.Outro (AktuelleZeile - Intro) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                                          VorhandenerTextExtern  => Sequenzentexte.Outro (AktuelleZeile - Intro));
                  
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextSequenzenLogik.Sequenzen: Außerhalb des Einlesebereichs");
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

end EinlesenTextSequenzenLogik;
