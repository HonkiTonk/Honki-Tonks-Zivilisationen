pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen; use AufgabenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with Vergleiche;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with KIBewegungDurchfuehrenLogik;
with KIEinheitHandlungenLogik;

package body KIEinheitGefahrenverhaltenLogik is
   
   procedure GefahrenHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindlicheEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      -- Platzhalter
      if
        FeindlicheEinheitExtern.Rasse = EinheitenKonstanten.LeerRasse
      then
         null;
         
      else
         null;
      end if;
      
      AktivitätSchleife:
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.SchwierigkeitsgradAktivität (SpielVariablen.Allgemeines.Schwierigkeitsgrad) loop
         
         case
           KIEinheitHandlungenLogik.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitHandlungenLogik.Aufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         if
           Vergleiche.KoordinateLeervergleich (KoordinateExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = False
         then
            KIBewegungDurchfuehrenLogik.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         elsif
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
         then
            null;
            -- KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            exit AktivitätSchleife;
         end if;
         
      end loop AktivitätSchleife;
      
   end GefahrenHandlungen;

end KIEinheitGefahrenverhaltenLogik;
