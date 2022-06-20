pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with KIEinheitAllgemeines;

package body KIEinheitStandardverhalten is
   
   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AktivitätSchleife:
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.Schwierigkeitsgrad (SpielVariablen.Schwierigkeitsgrad) loop
         
         case
           KIEinheitAllgemeines.Bewegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitAllgemeines.Aufgabenumsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitAllgemeines.Aufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
      end loop AktivitätSchleife;
      
   end NormaleHandlungen;

end KIEinheitStandardverhalten;
