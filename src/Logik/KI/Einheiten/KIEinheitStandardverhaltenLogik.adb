with LeseAllgemeines;

with KIDatentypen;
with KIKonstanten;

with KIEinheitHandlungenLogik;

package body KIEinheitStandardverhaltenLogik is
   
   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AktivitätSchleife:
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.SchwierigkeitsgradAktivität (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         case
           KIEinheitHandlungenLogik.Aufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
                  
         case
           KIEinheitHandlungenLogik.Bewegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitHandlungenLogik.Aufgabenumsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
                  
      end loop AktivitätSchleife;
      
   end NormaleHandlungen;

end KIEinheitStandardverhaltenLogik;
