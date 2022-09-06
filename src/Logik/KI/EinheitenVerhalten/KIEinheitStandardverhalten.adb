pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;
with KIKonstanten;

with KIEinheitHandlungen;

package body KIEinheitStandardverhalten is
   
   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AktivitätSchleife:
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.Schwierigkeitsgrad (SpielVariablen.Allgemeines.Schwierigkeitsgrad) loop
         
         case
           KIEinheitHandlungen.Aufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitHandlungen.Bewegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitHandlungen.Aufgabenumsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
                  
      end loop AktivitätSchleife;
      
   end NormaleHandlungen;

end KIEinheitStandardverhalten;
