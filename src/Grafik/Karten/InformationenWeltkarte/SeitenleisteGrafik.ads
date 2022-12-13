private with Sf.System.Vector2;

with RassenDatentypen;

private with EinheitenRecords;
private with StadtRecords;
private with KartenRecords;

package SeitenleisteGrafik is
   pragma Elaborate_Body;

   procedure SeitenleisteGrafik
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

private

   StadtVorhanden : Boolean;

   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;

   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;

   Leerwert : Sf.System.Vector2.sfVector2f;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end SeitenleisteGrafik;
