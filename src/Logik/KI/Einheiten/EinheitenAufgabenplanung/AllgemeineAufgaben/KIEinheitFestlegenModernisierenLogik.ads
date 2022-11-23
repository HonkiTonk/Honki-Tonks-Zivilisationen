with RassenDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;

private with StadtRecords;
private with KartenRecords;
private with KartenDatentypen;
private with EinheitenDatentypen;
private with StadtKonstanten;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitFestlegenModernisierenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   NeueEinheitenID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   StadtKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   PlatzGefunden : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function EinheitVerbessernPlatz
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitNummerExtern <= LeseGrenzen.Einheitengrenze (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenModernisierenLogik;
