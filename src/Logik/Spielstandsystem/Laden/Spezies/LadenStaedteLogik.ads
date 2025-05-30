with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Strings.Wide_Wide_Unbounded;

private with SystemDatentypenHTSEB;

with SpeziesDatentypen;

private with StadtRecords;
private with StadtDatentypen;
private with KartenverbesserungDatentypen;
private with ProduktionDatentypen;
private with KartenRecords;
private with KIDatentypen;
private with StadtArrays;
private with ZahlenDatentypen;

package LadenStaedteLogik is
   pragma Elaborate_Body;

   function Städte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Kartenplatzierung : Boolean;
   
   Belegung : SpeziesDatentypen.Spieler_Belegt_Enum;

   VorhandeneStädte : StadtDatentypen.Städtebereich;
   
   ID : KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
   
   Koordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   EinwohnerArbeiter : StadtRecords.EinwohnerArbeiterArray;
   
   Nahrungsmittel : ProduktionDatentypen.Stadtproduktion;
   
   Nahrungsproduktion : ProduktionDatentypen.Stadtproduktion;
   
   Material : ProduktionDatentypen.StadtLagermenge;
   
   Produktionrate : ProduktionDatentypen.Stadtproduktion;
   
   Geldgewinnung : ProduktionDatentypen.Stadtproduktion;
   
   AlleKostenposten : StadtRecords.PermanenteKostenArray;
   
   Forschungsrate : ProduktionDatentypen.Stadtproduktion;
   
   Bauprojekt : StadtRecords.BauprojektRecord;
   
   Bauzeit : ProduktionDatentypen.Produktion;
   
   Korruption : ProduktionDatentypen.Stadtproduktion;
   
   Zufriedenheit : ProduktionDatentypen.ZufriedenheitVorhanden;
   
   Gebäude : SystemDatentypenHTSEB.VierByte;
   
   VorhandeneGebäude : StadtArrays.GebäudeArray;
   
   Stadtname : Unbounded_Wide_Wide_String;
   
   Bewirtschaftung : SystemDatentypenHTSEB.EinByte;
   
   Bewirtschaftungsbelegung : StadtRecords.UmgebungBewirtschaftungArray;
   
   Gesamtumgebung : KartenRecords.UmgebungDreiRecord;
   
   Meldungen : StadtRecords.StadtMeldungenArray;
   
   KIBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;
   
   Potenz : ZahlenDatentypen.EigenesNatural;
   
   
   
   function Stadtwerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BelegungExtern : in SpeziesDatentypen.Spieler_Belegt_Enum;
      DateiLadenExtern : in File_Type;
      StadtExtern : in StadtDatentypen.StädtebereichVorhanden)
      return Boolean;

end LadenStaedteLogik;
