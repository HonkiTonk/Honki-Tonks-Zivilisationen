with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with StadtDatentypen; use StadtDatentypen;
with RassenDatentypen; use RassenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with KartenRecords;
with KartenverbesserungDatentypen;
with StadtRecords;
with KartenKonstanten;
with Weltkarte;

with KIDatentypen;

package LeseStadtGebaut is
   pragma Elaborate_Body;

   function ID
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Koordinaten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  Koordinaten'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  Koordinaten'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
                and
                  (if Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse then Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse and Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse then Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse then Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
   
   function EinwohnerArbeiter
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean)
      return ProduktionDatentypen.Einwohner
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Arbeitslose
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Einwohner
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function Nahrungsmittel
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Nahrungsproduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Ressourcen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Produktionrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Geldgewinnung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function PermanenteKostenPosten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function Forschungsrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Bauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return StadtRecords.BauprojektRecord
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
           
       Post => (
                (if Bauprojekt'Result.Gebäude /= 0 then Bauprojekt'Result.Einheit = 0)
                and
                  (if Bauprojekt'Result.Einheit /= 0 then Bauprojekt'Result.Gebäude = 0)
               );
   
   function Bauzeit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Korruption
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Zufriedenheit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Feldproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function GebäudeVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Name
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String;

   function UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      XKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function UmgebungGröße
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KartenDatentypen.UmgebungsbereichDrei
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  UmgebungGröße'Result >= 0
               );
      
   function Meldungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum)
      return StadtDatentypen.Stadt_Meldung_Enum
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function KIBeschäftigung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KIDatentypen.Stadt_Aufgabe_Enum
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function GanzerEintrag
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return StadtRecords.StadtGebautRecord
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end LeseStadtGebaut;
