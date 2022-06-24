pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with KIEinheitHandlungen;

package body KIEinheitStandardverhalten is
   
   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AktivitätSchleife:
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.Schwierigkeitsgrad (SpielVariablen.Schwierigkeitsgrad) loop
         
         case
           KIEinheitHandlungen.Aufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               -- Put_Line ("1.1:" & AktivitätSchleifenwert'Wide_Wide_Image);
               exit AktivitätSchleife;
               
            when False =>
               null;
               -- Put_Line ("1.2:" & AktivitätSchleifenwert'Wide_Wide_Image);
         end case;
         
         case
           KIEinheitHandlungen.Bewegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               -- Put_Line ("2.1:" & AktivitätSchleifenwert'Wide_Wide_Image);
               exit AktivitätSchleife;
               
            when False =>
               null;
               -- Put_Line ("2.2:" & AktivitätSchleifenwert'Wide_Wide_Image);
         end case;
         
         case
           KIEinheitHandlungen.Aufgabenumsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               -- Put_Line ("3.1:" & AktivitätSchleifenwert'Wide_Wide_Image);
               exit AktivitätSchleife;
               
            when False =>
               null;
               -- Put_Line ("3.2:" & AktivitätSchleifenwert'Wide_Wide_Image);
         end case;
                  
      end loop AktivitätSchleife;
      
   end NormaleHandlungen;

end KIEinheitStandardverhalten;
