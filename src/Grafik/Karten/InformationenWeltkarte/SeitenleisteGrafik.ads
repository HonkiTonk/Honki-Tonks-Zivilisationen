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

   ViewbereicheIdentisch : Boolean;

   XPositionText : Float;

   StadtSpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;

   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;

   Textinformationen : GrafikRecords.YTextpositionLeerzeilenRecord;

   Viewbereich : GrafikRecords.ViewbereichRecord := GrafikRecordKonstanten.Anfangsviewbereich;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;



   function ViewbereicheVergleichen
     (ViewbereicheExtern : in GrafikRecords.ViewbereichRecord)
      return Boolean;

end SeitenleisteGrafik;
