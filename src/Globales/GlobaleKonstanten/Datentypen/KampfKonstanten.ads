pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen;

package KampfKonstanten is
   pragma Preelaborate;

   LeerKampfwert : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;

end KampfKonstanten;
