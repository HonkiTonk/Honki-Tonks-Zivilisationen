with AufgabenDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KartenfelderwerteLogik;

package body KampfwerteEinheitErmittelnLogik is
   
   function Gesamtverteidigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      Grundverteidigung := LeseEinheitenDatenbank.Verteidigung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      Bonusverteidigung := KartenfelderwerteLogik.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                    SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies);
        
      GesamteVerteidigung := Rangbonus (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                        KampfwertExtern          => (Grundverteidigung + Bonusverteidigung));
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when AufgabenDatentypen.Verschanzen_Enum =>
            GesamteVerteidigung := KampfDatentypen.KampfwerteGroß (Float (GesamteVerteidigung) * Verschanzungsbonus);
                  
         when others =>
            null;
      end case;
      
      return GesamteVerteidigung;
      
   end Gesamtverteidigung;
   
   
   
   function Gesamtangriff
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      Grundangriff := LeseEinheitenDatenbank.Angriff (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                      IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      Bonusangriff := KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                          SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies);
      
      GesamterAngriff := Rangbonus (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                    KampfwertExtern          => (Grundangriff + Bonusangriff));
      
      return GesamterAngriff;
      
   end Gesamtangriff;
   
   
   
   -- Das hier später noch einmal anpassen/erweitern. äöü
   function Rangbonus
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwertExtern : in KampfDatentypen.KampfwerteGroß)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      return KampfDatentypen.KampfwerteGroß (Float (KampfwertExtern) * (1.00 + Float (LeseEinheitenGebaut.Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)) / 10.00));
      
   end Rangbonus;

end KampfwerteEinheitErmittelnLogik;
