pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

private with KartenDatentypen;
private with RueckgabeDatentypen;

private with UmwandlungenAdaNachEigenes;

package AnzeigeZusatztextKartengroesseSFML is

   procedure AnzeigeZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural);
   
private
      
   PositionText : Sf.System.Vector2.sfVector2f;
   
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
                                         
   procedure Textbearbeitung
     (AktuelleAuswahlExtern : in Natural);
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural);
   
   procedure PositionFestlegen;
   
      
   
   function ZahlAlsStringKartenfeldPositiv is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end AnzeigeZusatztextKartengroesseSFML;
