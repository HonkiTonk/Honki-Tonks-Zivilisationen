with SpeziesDatentypen;
with StadtKonstanten;
with StadtRecords;

private with KartenRecords;
private with ProduktionDatentypen;
private with StadtDatentypen;

with LeseSpeziesbelegung;
with LeseGrenzen;

package StadtproduktionLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;
   
   procedure Stadtproduktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure StadtProduktionBerechnung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private

   Feldeffekt : Boolean;
   
   VorhandeneEinwohner : StadtDatentypen.Einwohner;

   NahrungsverbrauchEinwohnerMultiplikator : ProduktionDatentypen.Stadtproduktion;
   RessourcenverbrauchKorruptionMultiplikator : ProduktionDatentypen.Stadtproduktion;
   GeldverbrauchKorruptionMultiplikator : ProduktionDatentypen.Stadtproduktion;
   ForschungsverbrauchKorruptionMultiplikator : ProduktionDatentypen.Stadtproduktion;
   
   Nahrungsgewinnung : ProduktionDatentypen.Stadtproduktion;
   Materialgewinnung : ProduktionDatentypen.Stadtproduktion;
   Geldgewinnung : ProduktionDatentypen.Stadtproduktion;
   Forschungsgewinnung : ProduktionDatentypen.Stadtproduktion;
   
   NutzbarerBereich : KartenRecords.UmgebungDreiRecord;
   
   Bauprojekt : StadtRecords.BauprojektRecord;

   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.KartenfeldNaturalRecord;
      
   procedure FelderProduktionBerechnen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure KorruptionBerechnen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure ZufriedenheitBerechnen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   procedure WeitereNahrungsproduktionÄnderungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure WeitereProduktionrateÄnderungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure WeitereGeldgewinnungÄnderungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure WeitereForschungsrateÄnderungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end StadtproduktionLogik;
