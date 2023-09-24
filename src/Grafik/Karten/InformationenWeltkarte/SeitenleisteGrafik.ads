private with Sf.System.Vector2;

with SpeziesDatentypen;

private with EinheitenRecords;
private with StadtRecords;
private with KartenRecords;
private with GrafikRecordKonstanten;
private with GrafikRecords;

package SeitenleisteGrafik is
   pragma Elaborate_Body;

   procedure SeitenleisteGrafik
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum);

private

   StadtSpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;

   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   Textinformationen : GrafikRecords.TextpositionLeerzeilenRecord;

end SeitenleisteGrafik;
