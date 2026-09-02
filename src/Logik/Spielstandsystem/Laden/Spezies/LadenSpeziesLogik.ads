with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with KommazahltestsHTSEB;

package LadenSpeziesLogik is
   pragma Elaborate_Body;

   function SpezieswerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private

   LadezeitBasis : Float;
   Ladezeit : Float;
   
   
   
   function LadezeitTesten is new KommazahltestsHTSEB.StrichrechnungNatural (Kommazahl => SystemDatentypenHTSEB.LadezeitBasis);

end LadenSpeziesLogik;
