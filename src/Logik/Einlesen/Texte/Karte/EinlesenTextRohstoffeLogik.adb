with EinlesenAllgemeinesHTSEB;
with MeldungssystemHTSEB;
with TextKonstantenHTSEB;

with EinlesenTextSonstigesLogik;

package body EinlesenTextRohstoffeLogik is

   procedure Rohstoffe
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
                                                            DateinameExtern     => "EinlesenTextRohstoffeLogik.Rohstoffe")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextRohstoffeLogik.Rohstoffe: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenTextSonstigesLogik.TextErsetzen (TextExtern => EinlesenAllgemeinesHTSEB.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                                           AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                                           DateinameExtern     => "EinlesenTextRohstoffeLogik.Rohstoffe"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstantenHTSEB.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Rohstoffnamen
               then
                  Kartentexte.Rohstoffe (AktuelleZeile) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                   EingelesenerTextExtern => Zwischenspeicher,
                                                                                                   VorhandenerTextExtern  => Kartentexte.Rohstoffe (AktuelleZeile));
                  
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextRohstoffeLogik.Rohstoffe: Außerhalb des Einlesebereichs");
                  return;
               end if;
               
               if
                 AktuelleZeile < Rohstoffnamen
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop KarteSchleife;
      
   end Rohstoffe;

end EinlesenTextRohstoffeLogik;
