with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with StadtDatentypen;
private with EinheitenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package StadtbausystemLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Bauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private
   use type StadtDatentypen.GebäudeID;
   use type EinheitenDatentypen.EinheitenID;

   EinheitenAnfang : EinheitenDatentypen.EinheitenIDVorhanden;

   GebäudeAnfang : StadtDatentypen.GebäudeIDVorhanden;

   BaubareGebäude : Natural;
   BaubareEinheiten : Natural;

   AktuelleAuswahl : StadtRecords.BauprojektauswahlRecord := (0, StadtDatentypen.Leer_Bauprojektart);
   GewähltesBauprojekt : StadtRecords.BauprojektRecord;
   NeuesBauprojekt : StadtRecords.BauprojektRecord;

   procedure MöglicheGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure MöglicheEinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );



   function AuswahlBauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AktuelleBauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtRecords.BauprojektRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 (if AktuelleBauprojektExtern.Gebäude /= 0 then AktuelleBauprojektExtern.Einheit = 0)
               and
                 (if AktuelleBauprojektExtern.Einheit /= 0 then AktuelleBauprojektExtern.Gebäude = 0)
              ),

       Post => (
                (if AuswahlBauprojekt'Result.Gebäude /= 0 then AuswahlBauprojekt'Result.Einheit = 0)
                and
                  (if AuswahlBauprojekt'Result.Einheit /= 0 then AuswahlBauprojekt'Result.Gebäude = 0)
               );

end StadtbausystemLogik;
