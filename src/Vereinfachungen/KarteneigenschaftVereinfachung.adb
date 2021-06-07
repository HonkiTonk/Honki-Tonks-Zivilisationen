pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karten;

package body KarteneigenschaftVereinfachung is

   function KartenGrundVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin

      return Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund;
      
   end KartenGrundVereinfachung;
   
   
   
   function KartenHügelVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin

      return Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Hügel;
      
   end KartenHügelVereinfachung;



   function KartenFlussVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin

      return Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Fluss;
   end KartenFlussVereinfachung;
   
   

   function KartenStraßeVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
   is begin

      return Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße;
      
   end KartenStraßeVereinfachung;
   
   

   function KartenVerbesserungVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
   is begin

      return Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet;
      
   end KartenVerbesserungVereinfachung;
   
   

   function KartenRessourceVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin

      return Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Ressource;
      
   end KartenRessourceVereinfachung;
   
   
   
   function KartenBelegterGrundVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.BelegterGrund
   is begin

      return Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund;
      
   end KartenBelegterGrundVereinfachung;
   
   
   
   function KartenBelegterGrundAbgleich
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      BelegterStadtGrund := KartenBelegterGrundVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        BelegterStadtGrund
      in
        GlobaleKonstanten.FeldBelegung (EinheitRasseNummerExtern.Rasse, 1) .. GlobaleKonstanten.FeldBelegung (EinheitRasseNummerExtern.Rasse, 2)
      then      
         return True;
         
      else
         return False;
      end if;
      
   end KartenBelegterGrundAbgleich;
   
   
   
   function KartenFelderbewertungVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Felderwertung;
      
   end KartenFelderbewertungVereinfachung;

end KarteneigenschaftVereinfachung;
