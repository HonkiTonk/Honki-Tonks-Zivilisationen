with AufgabenDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with KartenRecords;

with LeseEinheitenGebaut;

with KIDatentypen;
with KIKonstanten;

with KIBewegungDurchfuehrenLogik;
with KIEinheitHandlungenLogik;

package body KIEinheitGefahrenverhaltenLogik is
   
   procedure GefahrenHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindlicheEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
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
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KartenRecordKonstanten.LeerKoordinate
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
