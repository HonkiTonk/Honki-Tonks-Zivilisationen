pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen; use KampfDatentypen;
with AufgabenDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KartenfelderwerteLogik;

package body KampfwerteEinheitErmittelnLogik is
   
   function Gesamtverteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      Grundverteidigung := LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      Bonusverteidigung := KartenfelderwerteLogik.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                    RasseExtern       => EinheitRasseNummerExtern.Rasse);
        
      GesamteVerteidigung := Grundverteidigung + Bonusverteidigung;
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when AufgabenDatentypen.Verschanzen_Enum =>
            GesamteVerteidigung := KampfDatentypen.KampfwerteGroß (Float (GesamteVerteidigung) * Verschanzungsbonus);
                  
         when others =>
            null;
      end case;
      
      return GesamteVerteidigung;
      
   end Gesamtverteidigung;
   
   
   
   function Gesamtangriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      Grundangriff := LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                      IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      Bonusangriff := KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                          RasseExtern       => EinheitRasseNummerExtern.Rasse);
      
      GesamterAngriff := Grundangriff + Bonusangriff;
      
      return GesamterAngriff;
      
   end Gesamtangriff;

end KampfwerteEinheitErmittelnLogik;
