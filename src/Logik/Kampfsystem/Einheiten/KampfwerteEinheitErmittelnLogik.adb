with AufgabenDatentypen;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KartenfelderwerteLogik;

package body KampfwerteEinheitErmittelnLogik is
   
   function Gesamtverteidigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      Grundverteidigung (LogikGrafikExtern) := LeseEinheitenDatenbank.Verteidigung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                    IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      Bonusverteidigung (LogikGrafikExtern) := KartenfelderwerteLogik.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                                        SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies);
        
      GesamteVerteidigung (LogikGrafikExtern) := Rangbonus (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                            KampfwertExtern            => (Grundverteidigung (LogikGrafikExtern) + Bonusverteidigung (LogikGrafikExtern)));
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when AufgabenDatentypen.Verschanzen_Enum =>
            GesamteVerteidigung (LogikGrafikExtern) := KampfDatentypen.KampfwerteGroß (Float (GesamteVerteidigung (LogikGrafikExtern)) * Verschanzungsbonus);
                  
         when others =>
            null;
      end case;
      
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when StadtKonstanten.LeerNummer =>
            GesamteVerteidigung (LogikGrafikExtern) := GesamteVerteidigung (LogikGrafikExtern) / 2;
            
         when others =>
            null;
      end case;
           
      return GesamteVerteidigung (LogikGrafikExtern);
      
   end Gesamtverteidigung;
   
   
   
   function Gesamtangriff
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      Grundangriff (LogikGrafikExtern) := LeseEinheitenDatenbank.Angriff (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                          IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      Bonusangriff (LogikGrafikExtern) := KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                              SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies);
      
      GesamterAngriff (LogikGrafikExtern) := Rangbonus (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        KampfwertExtern            => (Grundangriff (LogikGrafikExtern) + Bonusangriff (LogikGrafikExtern)));
      
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when StadtKonstanten.LeerNummer =>
            GesamterAngriff (LogikGrafikExtern) := GesamterAngriff (LogikGrafikExtern) / 2;
            
         when others =>
            null;
      end case;
      
      return GesamterAngriff (LogikGrafikExtern);
      
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
