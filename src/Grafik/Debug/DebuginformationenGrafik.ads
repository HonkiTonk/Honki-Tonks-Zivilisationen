with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with EinheitenRecords;

private with KartenRecords;

package DebuginformationenGrafik is
   pragma Elaborate_Body;

   function EInheiteninformationenKI
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
               --     EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               --   and
               --     LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               --   and
                 MaximaleTextbreiteExtern > 0.00
               and
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
              ),
   
       Post => (
                  EInheiteninformationenKI'Result > 0.00
               );

private
   
   YTextpositionDebug : Float;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   
   Koordinaten : KartenRecords.KartenfeldNaturalRecord;
   
end DebuginformationenGrafik;
