pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen;

package KampfKonstanten is
   pragma Preelaborate;

   LeerKampfwert : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;

end KampfKonstanten;
