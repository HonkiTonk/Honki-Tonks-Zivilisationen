with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIZielSuchenLogik;

package body KIEinheitFestlegenSiedelnLogik is

   function StadtBauen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      NeueStadtKoordinaten := KIZielSuchenLogik.ZielSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                            ZielartExtern              => KIDatentypen.Siedeln_Enum);
      
      case
        NeueStadtKoordinaten = KartenRecordKonstanten.LeerKoordinate
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => NeueStadtKoordinaten);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Stadt_Bauen_Enum);
            return True;
      end case;
      
   end StadtBauen;

end KIEinheitFestlegenSiedelnLogik;
