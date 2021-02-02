with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package StadtWerteFestlegen is

   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;

   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);
   procedure StadtUmgebungGrößeFestlegen (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);

private
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   KartenWert : GlobaleRecords.AchsenAusKartenfeldRecord;

end StadtWerteFestlegen;
