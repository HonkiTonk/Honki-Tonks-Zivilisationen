pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen, KIKonstanten;
use KIDatentypen;

with LeseEinheitenGebaut;

with KIBewegungDurchfuehren, KISiedlerAufgabeErmitteln, KISiedlerAufgabeDurchfuehren; -- , KIGefahrErmitteln;

package body KISiedler is

   procedure KISiedler
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      -- KIGefahrErmitteln.KIGefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
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
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.NullKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
           and
             LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Keine_Aufgabe
         then
            KISiedlerAufgabeErmitteln.SiedlerAufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
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
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) > GlobaleKonstanten.LeerEinheit.Bewegungspunkte
           and
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) > GlobaleKonstanten.LeerEinheit.ID
           and
             LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.NullKoordinate
           and
             LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Keine_Aufgabe
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
         then
            KISiedlerAufgabeDurchfuehren.SiedlerAufgabeDurchfuehren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            return;
         end if;
                  
         NotAus := NotAus + 1;
         
      end loop AktivitätSchleife;
      
   end KISiedler;

end KISiedler;
