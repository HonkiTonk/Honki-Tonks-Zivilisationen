with KartenKonstanten;
with KartenDatentypen;
with StadtKonstanten;

with LeseStadtGebaut;
with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIAufgabenVerteiltLogik;

package body KIEinheitFestlegenBewachenLogik is

   function StadtBewachen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
   begin
            
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) loop
         
         Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtNummerSchleifenwert));
         
         if
           Stadtkoordinaten.XAchse = KartenKonstanten.LeerXAchse
         then
            null;
               
         elsif
           False = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bewachen_Enum,
                                                               SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                               ZielKoordinatenExtern => Stadtkoordinaten)
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => Stadtkoordinaten);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Stadt_Bewachen_Enum);
            return True;
               
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return False;
      
   end StadtBewachen;

end KIEinheitFestlegenBewachenLogik;
