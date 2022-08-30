pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

private with KartenDatentypen;
private with RueckgabeDatentypen;

private with UmwandlungenAdaNachEigenes;

package AnzeigeZusatztextKartengroesseSFML is

   function AnzeigeZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
               and
                 RealeViewbreiteExtern >= 0.00
              ),
         
       Post => (
                  AnzeigeZusatztextKartengröße'Result.x >= 0.00
                and
                  AnzeigeZusatztextKartengröße'Result.y >= 0.00
               );
   
private
   
   Textbreite : Float;
   
   Rückgabewert : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type StandardKartengrößenArray is array (1 .. 9) of RueckgabeDatentypen.Kartengrößen_Standard_Enum;
   StandardKartengrößen : constant StandardKartengrößenArray := (
                                                                     1 => RueckgabeDatentypen.Kartengröße_20_20_Enum,
                                                                     2 => RueckgabeDatentypen.Kartengröße_40_40_Enum,
                                                                     3 => RueckgabeDatentypen.Kartengröße_80_80_Enum,
                                                                     4 => RueckgabeDatentypen.Kartengröße_120_80_Enum,
                                                                     5 => RueckgabeDatentypen.Kartengröße_120_160_Enum,
                                                                     6 => RueckgabeDatentypen.Kartengröße_160_160_Enum,
                                                                     7 => RueckgabeDatentypen.Kartengröße_240_240_Enum,
                                                                     8 => RueckgabeDatentypen.Kartengröße_320_320_Enum,
                                                                     9 => RueckgabeDatentypen.Kartengröße_1000_1000_Enum
                                                                    );
                                         
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural);
   
   
   
   function PositionFestlegen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
               and
                 RealeViewbreiteExtern >= 0.00
              ),
         
       Post => (
                  PositionFestlegen'Result.x >= 0.00
                and
                  PositionFestlegen'Result.y >= 0.00
               );
   
   function ZahlAlsStringKartenfeldPositiv is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end AnzeigeZusatztextKartengroesseSFML;
