pragma SPARK_Mode (On);

with Karten;

package body KarteneigenschaftSuchen is

   function KartenGrundEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin

      Grund := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse).Grund;
      
      return Grund;
      
   end KartenGrundEinheitSuchen;



   function KartenFlussEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin
      
      return 0;
      
   end KartenFlussEinheitSuchen;
   
   

   function KartenStraßeEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
   is begin
      
      return 0;
      
   end KartenStraßeEinheitSuchen;
   
   

   function KartenVerbesserungEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
   is begin
      
      return 0;
      
   end KartenVerbesserungEinheitSuchen;
   
   

   function KartenRessourceEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin
      
      return 0;
      
   end KartenRessourceEinheitSuchen;

end KarteneigenschaftSuchen;
