with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with StadtDatentypen;
with SpeziesDatentypen;
with ProduktionDatentypen;
with EinheitenDatentypen;
with KartenDatentypen;
with KartenRecords;
with KartenverbesserungDatentypen;
with StadtRecords;
with KartenKonstanten;
with StadtKonstanten;
with StadtArrays;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

with KIDatentypen;

package LeseStadtGebaut is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;
   use type StadtDatentypen.GebäudeIDMitNullwert;
   use type EinheitenDatentypen.EinheitenIDMitNullWert;
   
   function ID
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (ID);
   
   function Koordinaten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  Koordinaten'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  Koordinaten'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
                and
                  (if Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse then Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse and Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse then Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse then Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
   pragma Inline (Koordinaten);
   
   function EinwohnerArbeiter
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean)
      return ProduktionDatentypen.Einwohner
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Arbeitslose
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Einwohner
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function Nahrungsmittel
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Nahrungsmittel);
   
   function Nahrungsproduktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Nahrungsproduktion);
   
   function Material
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Material);
   
   function Produktionrate
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Produktionrate);
   
   function Geldgewinnung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Geldgewinnung);
   
   function PermanenteKostenPosten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (PermanenteKostenPosten);
      
   function Forschungsrate
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Forschungsrate);
   
   function Bauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.BauprojektRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
           
       Post => (
                (if Bauprojekt'Result.Gebäude /= 0 then Bauprojekt'Result.Einheit = 0)
                and
                  (if Bauprojekt'Result.Einheit /= 0 then Bauprojekt'Result.Gebäude = 0)
               );
   pragma Inline (Bauprojekt);
   
   function Bauzeit
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Bauzeit);

   function Korruption
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Korruption);
   
   function Zufriedenheit
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Feldproduktion
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Zufriedenheit);
   
   function GebäudeVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GebäudeVorhanden);
   
   function AlleGebäude
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtArrays.GebäudeArray
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (AlleGebäude);
   
   function Name
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function UmgebungBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      XKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (UmgebungBewirtschaftung);
   
   function GesamteBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.UmgebungBewirtschaftungArray
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GesamteBewirtschaftung);
   
   function UmgebungGröße
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenDatentypen.UmgebungsbereichDrei
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  UmgebungGröße'Result >= 0
               );
   pragma Inline (UmgebungGröße);
      
   function Meldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum)
      return StadtDatentypen.Stadt_Meldung_Enum
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Meldungen);
      
   function KIBeschäftigung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KIDatentypen.Stadt_Aufgabe_Enum
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (KIBeschäftigung);
   
   function GanzerEintrag
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.StadtGebautRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GanzerEintrag);

end LeseStadtGebaut;
