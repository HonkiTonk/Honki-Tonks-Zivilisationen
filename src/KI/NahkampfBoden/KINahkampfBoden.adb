pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten, KIDatentypen;
use KIDatentypen;

with KIBewegungDurchfuehren, KINahkampfBodenAufgabeErmitteln, KINahkampfBodenAufgabeDurchfuehren, LeseEinheitenGebaut;

package body KINahkampfBoden is

   procedure KINahkampfBoden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      NotAus := 1;
      
      AktivitätSchleife:
      loop
         
         case
           NotAus
         is
            when 8 =>
               return;
               
            when others =>
               null;
         end case;
         
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheit.ID
           or
             LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheit.Bewegungspunkte
         then
            return;
            
         else
            null;
         end if;
         
         if
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen
           and
             LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.NullKoordinate
         then
            return;
            
         else
            null;
         end if;
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.NullKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Nicht_Vorhanden
           and
             LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Keine_Aufgabe
         then
            KINahkampfBodenAufgabeErmitteln.NahkampfBodenAufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            null;
         end if;
      
         if
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) > GlobaleKonstanten.LeerEinheit.Bewegungspunkte
           and
             LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.NullKoordinate
         then
            null;
            
         elsif
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.NullKoordinate
           and
             LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Verschanzen
         then
            return;
            
         elsif
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) > GlobaleKonstanten.LeerEinheit.Bewegungspunkte
           and
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) > GlobaleKonstanten.LeerEinheit.ID
           and
             LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Keine_Aufgabe
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Nicht_Vorhanden
           and
             LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.NullKoordinate
         then
            KINahkampfBodenAufgabeDurchfuehren.NahkampfBodenAufgabeDurchfuehren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         else
            return;
         end if;
         
         NotAus := NotAus + 1;
         
      end loop AktivitätSchleife;
      
   end KINahkampfBoden;

end KINahkampfBoden;
