with BefehleDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

with KIDatentypen;

with KIEinheitUmsetzenBewachenLogik;

package body KIEinheitUmsetzenModernisierenLogik is

   function EinheitVerbessern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      NullWert := AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                         BefehlExtern               => BefehleDatentypen.Einheit_Verbessern_Enum,
                                         AnlegenTestenExtern        => True,
                                         KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when KIDatentypen.Stadt_Bewachen_Enum =>
            NullWert := KIEinheitUmsetzenBewachenLogik.StadtBewachen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when others =>
            null;
      end case;
      
      return False;
            
   end EinheitVerbessern;

end KIEinheitUmsetzenModernisierenLogik;
