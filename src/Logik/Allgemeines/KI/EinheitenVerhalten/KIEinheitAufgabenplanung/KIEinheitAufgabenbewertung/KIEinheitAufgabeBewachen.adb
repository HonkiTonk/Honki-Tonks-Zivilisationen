pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with KartenVerbesserungDatentypen;

with LeseStadtGebaut;

with EinheitSuchen;

with KIAufgabenVerteilt;

package body KIEinheitAufgabeBewachen is

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      EinheitNummer := 1;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)));
         end case;
         
         if
           EinheitNummer = EinheitenKonstanten.LeerNummer
           and
             KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bewachen_Enum,
                                                    RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                    ZielKoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)))
           = False
         then
            return KIDatentypen.AufgabenWichtigkeitKlein'Last;
               
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return 0;
                                    
   end StadtBewachen;

end KIEinheitAufgabeBewachen;
