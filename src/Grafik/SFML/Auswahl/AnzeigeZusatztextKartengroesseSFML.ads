pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.System.Vector2;

with KartenDatentypen;

with UmwandlungenAdaNachEigenes;

package AnzeigeZusatztextKartengroesseSFML is

   procedure AnzeigeZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural);
   
private
   
   LeerFestgelegt : constant Boolean := False;
   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   
   PositionText : Sf.System.Vector2.sfVector2f;
   
   type TextAccessArray is array (1 .. 2) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             others => Sf.Graphics.Text.create
                                            );
   
   procedure Textbearbeitung
     (AktuelleAuswahlExtern : in Natural);
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural);
   
   procedure PositionFestlegen;
   
   
   
   function SchriftartFestlegen
     return Boolean;

   function SchriftfarbeFestlegen
     return Boolean;

   function SchriftgrößeFestlegen
     return Boolean;
   
   function ZahlAlsStringKartenfeldPositiv is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end AnzeigeZusatztextKartengroesseSFML;
