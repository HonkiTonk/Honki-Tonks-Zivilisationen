pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with KartenDatentypen;

with UmwandlungenAdaNachEigenes;

package AnzeigeZusatztextKartengroesseSFML is

   procedure AnzeigeZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural);
   
private
      
   PositionText : Sf.System.Vector2.sfVector2f;
   
   procedure Textbearbeitung
     (AktuelleAuswahlExtern : in Natural);
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural);
   
   procedure PositionFestlegen;
   
      
   
   function ZahlAlsStringKartenfeldPositiv is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end AnzeigeZusatztextKartengroesseSFML;
