with SystemDatentypenHTSEB;

private with KommazahltestsHTSEB;

with LadezeitenDatentypen;

package LadezeitenLogik is
   pragma Elaborate_Body;
      
   procedure RundenendeNullsetzen;
   procedure RundenendeSchreiben
     (ZeitExtern : in SystemDatentypenHTSEB.LadezeitBasis)
     with
       Pre => (
                 ZeitExtern in SystemDatentypenHTSEB.LadezeitBasis'Range
              );
   
   procedure RundenendeMaximum;
   
   procedure SpielstandNullsetzen;
   procedure SpielstandSchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielstand_Enum;
      ZeitExtern : in SystemDatentypenHTSEB.LadezeitBasis)
     with
       Pre => (
                 ZeitExtern in SystemDatentypenHTSEB.LadezeitBasis'Range
              );
   
   procedure SpielstandMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielstand_Enum);

   procedure KartengeneratorNullsetzen;
   procedure KartengeneratorSchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.Kartengenerator_Enum;
      ZeitExtern : in SystemDatentypenHTSEB.LadezeitBasis)
     with
       Pre => (
                 ZeitExtern in SystemDatentypenHTSEB.LadezeitBasis'Range
              );
   
   procedure KartengeneratorMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Kartengenerator_Enum);
   
   procedure KINullsetzen;
   procedure KIEinzelnNullsetzen
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum);
     
   procedure KISchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum;
      ZeitExtern : in SystemDatentypenHTSEB.LadezeitBasis)
     with
       Pre => (
                 ZeitExtern in SystemDatentypenHTSEB.LadezeitBasis'Range
              );
   
   procedure KIMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum);
   
   
   
   function RundenendeLesen
     return SystemDatentypenHTSEB.LadezeitBasis;
   
   function KartengeneratorLesen
     (BerechnungszeitExtern : in LadezeitenDatentypen.Kartengenerator_Enum)
      return SystemDatentypenHTSEB.LadezeitBasis;
   
   function KILesen
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum)
      return SystemDatentypenHTSEB.LadezeitBasis;
   
   function SpielstandLesen
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielstand_Enum)
      return SystemDatentypenHTSEB.LadezeitBasis;
   
private
   
   AnfangLadezeit : constant SystemDatentypenHTSEB.LadezeitBasis := SystemDatentypenHTSEB.LadezeitBasis'First;
   EndeLadezeit : constant SystemDatentypenHTSEB.LadezeitBasis := SystemDatentypenHTSEB.LadezeitBasis'Last;
   
   Rundenende : SystemDatentypenHTSEB.LadezeitBasis;
   
   type KartengeneratorArray is array (LadezeitenDatentypen.Kartengenerator_Enum'Range) of SystemDatentypenHTSEB.LadezeitBasis;
   Kartengenerator : KartengeneratorArray;
      
   type KIArray is array (LadezeitenDatentypen.KI_Enum'Range) of SystemDatentypenHTSEB.LadezeitBasis;
   KI : KIArray;
   
   type SpielstandArray is array (LadezeitenDatentypen.Spielstand_Enum'Range) of SystemDatentypenHTSEB.LadezeitBasis;
   Spielstand : SpielstandArray;
   
   
   
   function LadezeitTesten is new KommazahltestsHTSEB.StrichrechnungNatural (Kommazahl => SystemDatentypenHTSEB.LadezeitBasis);

end LadezeitenLogik;
