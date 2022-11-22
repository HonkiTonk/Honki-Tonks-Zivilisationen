with RassenDatentypen;
with StadtDatentypen;
with SpielVariablen;
with StadtRecords;

private with KartenRecords;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with KartenDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

private with LeseWeltkarteneinstellungen;

package GebaeudeumgebungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
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
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Detailprüfung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end GebaeudeumgebungLogik;
