pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen; use AufgabenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with KIBewegungDurchfuehren;
with KIAufgabenPlanung;
with KIEinheitAllgemeines;
with Vergleiche;

package body KIEinheitStandardverhalten is
   
   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AktivitätSchleife:
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.Schwierigkeitsgrad (SpielVariablen.Schwierigkeitsgrad) loop
         
         case
           KIEinheitAllgemeines.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
               -- KIEinheitAllgemeines.BewegungAufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end case;
         
         if
          Vergleiche.KoordinateLeervergleich (KoordinateExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = False
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
           and
             LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Tut_Nichts_Enum
         then
            KIAufgabenPlanung.AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            null;
         end if;
         
         case
           KIEinheitAllgemeines.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         if
           Vergleiche.KoordinateLeervergleich (KoordinateExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = False
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
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
      
   end NormaleHandlungen;

end KIEinheitStandardverhalten;
