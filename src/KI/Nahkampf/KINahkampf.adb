pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten, KIDatentypen;
use KIDatentypen;

with LeseEinheitenGebaut;

with KIBewegungDurchfuehren, KINahkampfAufgabeErmitteln, KINahkampfAufgabeDurchfuehren;

package body KINahkampf is

   procedure KINahkampf
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      NotAus := 1;
      
      AktivitätSchleife:
      while NotAus /= GlobaleDatentypen.Sichtweite'Last loop
         
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
           LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
           and
             LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Keine_Aufgabe
         then
            KINahkampfAufgabeErmitteln.NahkampfAufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
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
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
           and
             LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.NullKoordinate
         then
            KINahkampfAufgabeDurchfuehren.NahkampfAufgabeDurchfuehren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         else
            return;
         end if;
         
         NotAus := NotAus + 1;
         
      end loop AktivitätSchleife;
      
   end KINahkampf;

end KINahkampf;
