with KampfDatentypen;

package KampfKonstanten is
   pragma Pure;

   LeerKampfwert : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;
   LeerReichweite : constant KampfDatentypen.Reichweite := KampfDatentypen.Reichweite'First;
   LeerRang : constant KampfDatentypen.Rang := KampfDatentypen.Rang'First;
   LeerErfahrungspunkte : constant KampfDatentypen.Erfahrungspunkte := KampfDatentypen.Erfahrungspunkte'First;

   LeerBonus : constant KampfDatentypen.Kampfbonus := 1.00;
   LeerMalus : constant KampfDatentypen.Kampfbonus := 1.00;

end KampfKonstanten;
