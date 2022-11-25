with LeseAllgemeines;

with KIDatentypen;
with KIKonstanten;
with KIVariablen;

with KIEinheitHandlungstestsLogik;
with KIEinheitenAufgabenplanungLogik;
with KIEinheitenbewegungLogik;
with KIEinheitenAufgabenumsetzungLogik;
with KIEinheitAufgabenabbruchLogik;

package body KIEinheitLogik is

   procedure Einheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
            
      case
        KIVariablen.Kriegszustand
      is
         when False =>
            if
              KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return;
               
            else
               null;
            end if;
            
         when True =>
            if
              KIEinheitHandlungstestsLogik.BewachtStadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
              or
                KIEinheitHandlungstestsLogik.Unbewegbar (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return;
               
            else
               KIEinheitAufgabenabbruchLogik.Friedenshandlung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            end if;
      end case;
                
      Handlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Einheit;
   
   
   
   procedure Handlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AktivitätSchleife:
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.SchwierigkeitsgradAktivität (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         case
           KIEinheitenAufgabenplanungLogik.Aufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
                  
         case
           KIEinheitenbewegungLogik.Bewegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitenAufgabenumsetzungLogik.Aufgabenumsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
                  
      end loop AktivitätSchleife;
      
   end Handlungen;

end KIEinheitLogik;
