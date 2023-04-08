with KartenKonstanten;

with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIZielSuchenLogik;

package body KIEinheitFestlegenErkundenLogik is

   function Erkunden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      Kartenwert := KIZielSuchenLogik.ZielSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                  ZielartExtern              => KIDatentypen.Erkunden_Enum);
      
      case
        Kartenwert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return False;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => Kartenwert);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Erkunden_Enum);
            return True;
      end case;
      
   end Erkunden;

end KIEinheitFestlegenErkundenLogik;
