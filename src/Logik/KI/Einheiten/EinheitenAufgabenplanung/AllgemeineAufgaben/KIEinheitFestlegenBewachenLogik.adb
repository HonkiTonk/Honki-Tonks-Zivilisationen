with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;

with LeseStadtGebaut;
with SchreibeEinheitenGebaut;

with EinheitSuchenLogik;

with KIDatentypen;

with KIAufgabenVerteiltLogik;

package body KIEinheitFestlegenBewachenLogik is

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
            
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert));
         
         case
           Stadtkoordinaten.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               EinheitNummer := 1;
               
            when others =>
               EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                     KoordinatenExtern => Stadtkoordinaten,
                                                                                     LogikGrafikExtern => True);
         end case;
         
         if
           EinheitNummer = EinheitenKonstanten.LeerNummer
           and
             False = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bewachen_Enum,
                                                                 RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                                 ZielKoordinatenExtern => Stadtkoordinaten)
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => Stadtkoordinaten);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Stadt_Bewachen_Enum);
            return True;
               
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return False;
      
   end StadtBewachen;

end KIEinheitFestlegenBewachenLogik;
