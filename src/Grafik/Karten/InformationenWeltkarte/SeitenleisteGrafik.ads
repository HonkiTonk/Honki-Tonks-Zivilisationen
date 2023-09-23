private with Sf.System.Vector2;
private with Sf.System.Vector3;

with SpeziesDatentypen;

private with EinheitenRecords;
private with StadtRecords;
private with KartenRecords;
private with GrafikRecordKonstanten;

package SeitenleisteGrafik is
   pragma Elaborate_Body;

   procedure SeitenleisteGrafik
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum);

private

   StadtSpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;

   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;

   Textpositionsinformationen : Sf.System.Vector3.sfVector3f;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end SeitenleisteGrafik;
