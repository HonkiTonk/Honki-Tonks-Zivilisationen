with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with StadtRecords;
private with EinheitenDatentypen;
private with KartenDatentypen;
private with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenVerbesserungenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function StadtumgebungVerbessern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   VerbesserungTesten : Boolean;
   WelcheVerbesserung : Boolean;

   Stadtumgebung : KartenRecords.UmgebungDreiRecord;

   EinheitAufFeld : EinheitenRecords.SpeziesEinheitnummerRecord;

   ZielVerbesserungKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   VerbesserungAnlegen : KartenRecords.KartenfeldNaturalRecord;
   VerbesserungKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   StadtKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   EinheitKoordinaten : KartenRecords.KartenfeldNaturalRecord;



   function StädteDurchgehen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  StädteDurchgehen'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  StädteDurchgehen'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

   function DirekteUmgebung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  DirekteUmgebung'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  DirekteUmgebung'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

   function StadtumgebungErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
              ),

       Post => (
                  StadtumgebungErmitteln'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  StadtumgebungErmitteln'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

   function AllgemeineVerbesserungenPrüfungen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

   function VerbesserungErsetzen
     return Boolean;

end KIEinheitFestlegenVerbesserungenLogik;
