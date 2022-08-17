pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf;
private with Sf.System.Vector2;

private with RassenDatentypen;
private with TextaccessVariablen;

package AnzeigeZusatztextRassenmenueSFML is

   procedure AnzeigeZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive);

private

   LinksRechts : Boolean;
   Rückgabewert : Boolean;

   RasseAnzeigen : RassenDatentypen.Rassen_Verwendet_Enum;

   SchleifenAnfang : Positive;
   SchleifenEnde : Positive;

   Zwischenwert : Integer;

   AnfangsabstandExtratext : constant Float := 5.00;
   EndabstandExtratext : constant Float := 15.00;
   BreiteTextfeld : Float;

   AktuellerTextbereichEins : Unbounded_Wide_Wide_String;
   AktuellerTextbereichZwei : Unbounded_Wide_Wide_String;

   VerhältnisTextfeld : constant Sf.System.Vector2.sfVector2f := (0.48, 0.80);
   PositionHintergrund : Sf.System.Vector2.sfVector2f;

   type RassenTexteArray is array (TextaccessVariablen.ZusatztextRassenAccessArray'Range) of Unbounded_Wide_Wide_String;
   RassenTexte : RassenTexteArray;

   procedure Textbearbeitung
     (AktuelleRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);



   function ZeilenumbruchEinbauen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
     with
       Pre => (
                 TextExtern'Length > 0
              ),

       Post => (
                  ZeilenumbruchEinbauen'Result'Length > 0
               );

end AnzeigeZusatztextRassenmenueSFML;
