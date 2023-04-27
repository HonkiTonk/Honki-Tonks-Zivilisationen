with Sf.System.Vector2;

private with KartenDatentypen;
private with RueckgabeDatentypen;

private with UmwandlungenAdaNachEigenes;

package ZusatztextKartengroesseGrafik is
   pragma Elaborate_Body;

   function ZusatztextKartengröße
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
                  ZusatztextKartengröße'Result.x >= 0.00
                and
                  ZusatztextKartengröße'Result.y >= 0.00
               );
   
private
   
   Ebenenanzahl : constant Wide_Wide_String (1 .. 2) := "5x";
   KleinesX : constant Wide_Wide_String (1 .. 1) := "x";
   
   Textbreite : Float;
   
   Rückgabewert : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type StandardKartengrößenArray is array (1 .. 9) of RueckgabeDatentypen.Kartengrößen_Standard_Enum;
   StandardKartengrößen : constant StandardKartengrößenArray := (
                                                                     1 => RueckgabeDatentypen.Auswahl_Eins_Enum,
                                                                     2 => RueckgabeDatentypen.Auswahl_Zwei_Enum,
                                                                     3 => RueckgabeDatentypen.Auswahl_Drei_Enum,
                                                                     4 => RueckgabeDatentypen.Auswahl_Vier_Enum,
                                                                     5 => RueckgabeDatentypen.Auswahl_Fünf_Enum,
                                                                     6 => RueckgabeDatentypen.Auswahl_Sechs_Enum,
                                                                     7 => RueckgabeDatentypen.Auswahl_Sieben_Enum,
                                                                     8 => RueckgabeDatentypen.Auswahl_Acht_Enum,
                                                                     9 => RueckgabeDatentypen.Auswahl_Neun_Enum
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

end ZusatztextKartengroesseGrafik;
