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
        
      GesamteVerteidigung := Rangbonus (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        KampfwertExtern          => (Grundverteidigung + Bonusverteidigung));
      
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
      
      GesamterAngriff := Rangbonus (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    KampfwertExtern          => (Grundangriff + Bonusangriff));
      
      return GesamterAngriff;
      
   end Gesamtangriff;
   
   
   
   -- Das hier später noch einmal anpassen/erweitern. äöü
   function Rangbonus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwertExtern : in KampfDatentypen.KampfwerteGroß)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      return KampfDatentypen.KampfwerteGroß (Float (KampfwertExtern) * (1.00 + Float (LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) / 10.00));
      
   end Rangbonus;

end KampfwerteEinheitErmittelnLogik;
