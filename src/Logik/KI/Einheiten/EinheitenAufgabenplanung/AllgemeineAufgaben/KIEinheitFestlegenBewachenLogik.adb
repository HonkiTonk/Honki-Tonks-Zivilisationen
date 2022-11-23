with KartenKonstanten;
with KartenDatentypen;
with StadtKonstanten;

with LeseStadtGebaut;
with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIAufgabenVerteiltLogik;

package body KIEinheitFestlegenBewachenLogik is

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
   begin
            
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => EinheitRasseNummerExtern.Rasse) loop
         
         Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert));
         
         if
           Stadtkoordinaten.XAchse = KartenKonstanten.LeerXAchse
         then
            null;
               
         elsif
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
