pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen, KIDatentypen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package KIBewegungBerechnen is
   
   procedure BewegungPlanen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   procedure NeuesZielErmittelnGefahr
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RichtungExtern : in KIDatentypen.Richtung_Enum)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
private
   
   BewegungMöglich : Boolean;
   
   Bewegung : GlobaleDatentypen.Bewegung_Enum;
   
   AbbruchWert : Natural;

   AnfangKoordinaten : GlobaleRecords.AchsenKartenfeldPositivRecord;
   MöglicheNeueKoordinaten : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   ZielKoordinaten : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   Kartenwert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   type WegpunkteArray is array (-GlobaleRecords.KIBewegungPlanArray'Last .. GlobaleRecords.KIBewegungPlanArray'Last,
                                 -GlobaleRecords.KIBewegungPlanArray'Last .. GlobaleRecords.KIBewegungPlanArray'Last) of GlobaleRecords.AchsenKartenfeldPositivRecord;
   Wegpunkte : WegpunkteArray;

   function IstDasEineAltePosition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

end KIBewegungBerechnen;
