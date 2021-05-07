pragma SPARK_Mode (On);

with Karten, StadtWerteFestlegen;

package body KarteneigenschaftVereinfachung is

   function KartenGrundVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin

      Grund := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund;
      
      return Grund;
      
   end KartenGrundVereinfachung;



   function KartenFlussVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin

      Fluss := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Fluss;
      
      return Fluss;
      
   end KartenFlussVereinfachung;
   
   

   function KartenStraßeVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
   is begin

      Straße := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                   GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                   GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße;
      
      return Straße;
      
   end KartenStraßeVereinfachung;
   
   

   function KartenVerbesserungVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
   is begin

      Verbesserung := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet;
      
      return Verbesserung;
      
   end KartenVerbesserungVereinfachung;
   
   

   function KartenRessourceVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin

      Ressource := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Ressource;
      
      return Ressource;
      
   end KartenRessourceVereinfachung;
   
   
   
   function KartenBelegterGrundVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.BelegterGrund
   is begin

      BelegterStadtGrund := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund;
      
      return BelegterStadtGrund;
      
   end KartenBelegterGrundVereinfachung;
   
   
   
   function KartenBelegterGrundAbgleich
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      BelegterStadtGrund := KartenBelegterGrundVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        BelegterStadtGrund
      in
        GlobaleDatentypen.BelegterGrund (EinheitRasseNummerExtern.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert .. GlobaleDatentypen.BelegterGrund (EinheitRasseNummerExtern.Rasse)
        * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleVariablen.StadtGebaut'Last (2))
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
      
      KartenFeldbewertung := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Felderwertung;
      
      return KartenFeldbewertung;
      
   end KartenFelderbewertungVereinfachung;

end KarteneigenschaftVereinfachung;
