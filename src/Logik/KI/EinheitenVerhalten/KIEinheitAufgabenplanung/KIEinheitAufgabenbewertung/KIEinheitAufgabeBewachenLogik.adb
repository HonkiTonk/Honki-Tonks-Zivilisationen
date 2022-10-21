pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with KartenverbesserungDatentypen;

with LeseStadtGebaut;

with EinheitSuchenLogik;

with KIKonstanten;

with KIAufgabenVerteiltLogik;

package body KIEinheitAufgabeBewachenLogik is

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      EinheitNummer := 1;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert));
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                     KoordinatenExtern => StadtKoordinaten,
                                                                                     LogikGrafikExtern => True);
         end case;
         
         if
           EinheitNummer = EinheitenKonstanten.LeerNummer
           and
             False = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bewachen_Enum,
                                                                 RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                                 ZielKoordinatenExtern => StadtKoordinaten)
         then
            return KIDatentypen.AufgabenWichtigkeitKlein'Last;
               
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return KIKonstanten.LeerAufgabenbewertung;
                                    
   end StadtBewachen;

end KIEinheitAufgabeBewachenLogik;
