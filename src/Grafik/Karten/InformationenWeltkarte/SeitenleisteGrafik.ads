private with Sf.System.Vector2;

with SpeziesDatentypen;

private with EinheitenRecords;
private with StadtRecords;
private with KartenRecords;

package SeitenleisteGrafik is
   pragma Elaborate_Body;

   procedure SeitenleisteGrafik
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum);

private

   StadtVorhanden : Boolean;

   StadtSpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;

   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;

   Leerwert : Sf.System.Vector2.sfVector2f;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end SeitenleisteGrafik;
