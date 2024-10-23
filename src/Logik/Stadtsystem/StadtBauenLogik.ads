with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with StadtDatentypen;
private with SystemRecords;
private with StadtRecords;
private with AufgabenDatentypen;
private with KartenKonstanten;
private with KartenverbesserungDatentypen;
private with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package StadtBauenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function StadtBauen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private
   use type KartenverbesserungDatentypen.Verbesserung_Enum;

   Stadtart : KartenverbesserungDatentypen.Verbesserung_Städte_Enum;

   WelcherWeg : AufgabenDatentypen.Einheitenbefehle_Wege_Enum;

   StadtNummer : StadtDatentypen.Städtebereich;

   StadtName : SystemRecords.TextEingabeRecord;

   Einheitenkoordinaten : KartenRecords.KartenfeldNaturalRecord;

   type StandardStadtnameArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of StadtDatentypen.StädtebereichVorhanden;
   StandardStadtname : StandardStadtnameArray := (others => StadtDatentypen.StädtebereichVorhanden'First);

   procedure StadtEintragen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure WegAnlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
              );



   function StadtBaubar
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function StadtnummerErmitteln
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return StadtDatentypen.Städtebereich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),

       Post => (
                  StadtnummerErmitteln'Result in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               );

   function HauptstadtPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenverbesserungDatentypen.Verbesserung_Städte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),

       Post => (
                  HauptstadtPrüfen'Result /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
               );

end StadtBauenLogik;
