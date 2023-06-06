with AufgabenDatentypen;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with FeldkampfEinheitLogik;
with Kampfgrenzen;

package body KampfwerteEinheitErmittelnLogik is
 
   -- Einheitenwert * Verbesserung * Basisgrund * Zusatzgrund * Ressource * Fluss * Straße * Gebäudebonus * Feldeffekte * Rang
   function Gesamtverteidigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.KampfwerteGroß
   is
      use type KampfDatentypen.Kampfbonus;
   begin
      
      Verteidigung (TaskExtern) := LeseEinheitenDatenbank.Verteidigung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                        IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      Verteidigung (TaskExtern) := FeldkampfEinheitLogik.Feldkampf (KoordinatenExtern    => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                    SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                                    KampfartExtern       => KampfDatentypen.Verteidigung_Enum,
                                                                    KampfBasiswertExtern => Verteidigung (TaskExtern),
                                                                    TaskExtern    => TaskExtern);
      
      -- Möglicherweise ein konstantes Array anlegen, wo man dann die rangabhängigen Bonis reinschreibt? äöü
      Verteidigung (TaskExtern)
        := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Verteidigung (TaskExtern),
                                             KampfbonusExtern => (1.00 + KampfDatentypen.Kampfbonus (LeseEinheitenGebaut.Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)) / 10.00));
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when AufgabenDatentypen.Verschanzen_Enum =>
            Verteidigung (TaskExtern) := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Verteidigung (TaskExtern),
                                                                           KampfbonusExtern => Verschanzungsbonus);
                  
         when others =>
            null;
      end case;
      
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when StadtKonstanten.LeerNummer =>
            Verteidigung (TaskExtern) := Verteidigung (TaskExtern) / FehlendeHeimatstadtMalus;
            
         when others =>
            null;
      end case;
           
      return Verteidigung (TaskExtern);
      
   end Gesamtverteidigung;
   
   
   
   -- Einheitenwert * Verbesserung * Basisgrund * Zusatzgrund * Ressource * Fluss * Straße * Gebäudebonus * Feldeffekte * Rang
   function Gesamtangriff
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.KampfwerteGroß
   is
      use type KampfDatentypen.Kampfbonus;
   begin
      
      Angriff (TaskExtern) := LeseEinheitenDatenbank.Angriff (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                              IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      Angriff (TaskExtern) := FeldkampfEinheitLogik.Feldkampf (KoordinatenExtern    => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                               SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                               KampfartExtern       => KampfDatentypen.Angriff_Enum,
                                                               KampfBasiswertExtern => Angriff (TaskExtern),
                                                               TaskExtern    => TaskExtern);
      
      Angriff (TaskExtern)
        := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Angriff (TaskExtern),
                                             KampfbonusExtern => (1.00 + KampfDatentypen.Kampfbonus (LeseEinheitenGebaut.Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)) / 10.00));
      
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when StadtKonstanten.LeerNummer =>
            Angriff (TaskExtern) := Angriff (TaskExtern) / FehlendeHeimatstadtMalus;
            
         when others =>
            null;
      end case;
      
      return Angriff (TaskExtern);
      
   end Gesamtangriff;

end KampfwerteEinheitErmittelnLogik;
