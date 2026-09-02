private with SystemDatentypenHTSEB;

private with KommazahltestsHTSEB;

package KartengeneratorHimmelLogik is
   pragma Elaborate_Body;

   procedure Himmel;

private

   LadezeitBasis : Float;
   Ladezeit : Float;



   function LadezeitTesten is new KommazahltestsHTSEB.StrichrechnungNatural (Kommazahl => SystemDatentypenHTSEB.LadezeitBasis);

end KartengeneratorHimmelLogik;
