private with SystemDatentypenHTSEB;

private with KommazahltestsHTSEB;

package KartengeneratorUnterflaecheLogik is
   pragma Elaborate_Body;

   procedure GenerierungLandschaft;

private

   LadezeitBasis : Float;
   Ladezeit : Float;



   function LadezeitTesten is new KommazahltestsHTSEB.StrichrechnungNatural (Kommazahl => SystemDatentypenHTSEB.LadezeitBasis);

end KartengeneratorUnterflaecheLogik;
