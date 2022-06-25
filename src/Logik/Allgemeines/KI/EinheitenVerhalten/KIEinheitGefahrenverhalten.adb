pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen; use AufgabenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with Vergleiche;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with KIBewegungDurchfuehren;
with KIAufgabenPlanung;
with KIEinheitHandlungen;

package body KIEinheitGefahrenverhalten is
   
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
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.Schwierigkeitsgrad (SpielVariablen.Allgemeines.Schwierigkeitsgrad) loop
         
         case
           KIEinheitHandlungen.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitHandlungen.Aufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         if
           Vergleiche.KoordinateLeervergleich (KoordinateExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = False
         then
            KIBewegungDurchfuehren.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts_Enum
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
         then
            KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            exit AktivitätSchleife;
         end if;
         
      end loop AktivitätSchleife;
      
   end GefahrenHandlungen;

end KIEinheitGefahrenverhalten;
