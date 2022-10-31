pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with StadtDatentypen;
with SpielVariablen;
with StadtRecords;

private with KartenRecords;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with Weltkarte;

package GebaeudeumgebungLogik is
   pragma Elaborate_Body;

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Ergebnis : Boolean;
   
   Umgebungsgröße : KartenDatentypen.UmgebungsbereichDrei;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type AnforderungenRecord is record
      
      NotwendigFluss : Boolean;
      
      NotwendigerGrund : KartengrundDatentypen.Basisgrund_Enum;
      
      NotwendigeRessource : KartengrundDatentypen.Kartenressourcen_Enum;
   
      NotwendigeVerbesserung : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   
      NotwendigesGebäude : StadtDatentypen.GebäudeIDMitNullwert;
      
   end record;
   
   Anforderungen : AnforderungenRecord;
   
   -- Das einzelne Array wäre mit sich selbst dann ein ODER und mit den anderen Arrays ein UND. äöü
   type ErfülltRecord is record
      
      Fluss : Boolean;
      Grund : Boolean;
      Ressource : Boolean;
      Verbesserung : Boolean;
      Gebäude : Boolean;
      
   end record;
   
   Erfüllt : ErfülltRecord;
   
   
   
   function UmgebungPrüfen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Detailprüfung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end GebaeudeumgebungLogik;
