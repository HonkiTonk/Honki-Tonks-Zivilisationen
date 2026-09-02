with SystemDatentypenHTSEB;

private with KommazahltestsHTSEB;

with LadezeitenDatentypen;

package LadezeitenLogik is
   pragma Elaborate_Body;
   
   Rundenende : Float;
   
   -- Das Float durch Ladezeitenfloat ersetzen? äöü
   type KartengeneratorArray is array (LadezeitenDatentypen.Kartengenerator_Enum'Range) of Float;
   Kartengenerator : KartengeneratorArray;
      
   type KIArray is array (LadezeitenDatentypen.KI_Enum'Range) of Float;
   KI : KIArray;
   
   type SpielstandArray is array (LadezeitenDatentypen.Spielstand_Enum'Range) of Float;
   Spielstand : SpielstandArray;
      
   procedure RundenendeNullsetzen;
   procedure RundenendeSchreiben
     (ZeitExtern : in Float)
     with
       Pre => (
                 ZeitExtern in 0.00 .. 100.00
              );
   
   procedure RundenendeMaximum;
   
   procedure SpielstandNullsetzen;
   procedure SpielstandSchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielstand_Enum;
      ZeitExtern : in Float)
     with
       Pre => (
                 ZeitExtern in 0.00 .. 100.00
              );
   
   procedure SpielstandMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielstand_Enum);

   procedure KartengeneratorNullsetzen;
   procedure KartengeneratorSchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.Kartengenerator_Enum;
      ZeitExtern : in Float)
     with
       Pre => (
                 ZeitExtern in 0.00 .. 100.00
              );
   
   procedure KartengeneratorMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Kartengenerator_Enum);
   
   procedure KINullsetzen;
   procedure KIEinzelnNullsetzen
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum);
     
   procedure KISchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum;
      ZeitExtern : in Float)
     with
       Pre => (
                 ZeitExtern in 0.00 .. 100.00
              );
   
   procedure KIMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum);
   
private
   
   AnfangLadezeit : constant SystemDatentypenHTSEB.LadezeitBasis := SystemDatentypenHTSEB.LadezeitBasis'First;
   EndeLadezeit : constant SystemDatentypenHTSEB.LadezeitBasis := SystemDatentypenHTSEB.LadezeitBasis'Last;
   
   
   
   function LadezeitTesten is new KommazahltestsHTSEB.StrichrechnungNatural (Kommazahl => SystemDatentypenHTSEB.LadezeitBasis);

end LadezeitenLogik;
