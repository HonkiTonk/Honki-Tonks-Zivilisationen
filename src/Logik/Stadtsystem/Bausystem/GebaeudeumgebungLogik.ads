with SpeziesDatentypen;
with StadtDatentypen;
with StadtRecords;
with StadtKonstanten;

private with KartenRecords;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with KartenDatentypen;
private with KartenextraDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package GebaeudeumgebungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function RichtigeUmgebungVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
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
      
      NotwendigeRessource : KartenextraDatentypen.Ressourcen_Enum;
   
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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Detailprüfung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end GebaeudeumgebungLogik;
