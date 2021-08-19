pragma SPARK_Mode (On);

package body LeseStadtGebaut is

   function ID
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Stadt_ID_Enum
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID;
      
   end ID;
   
   
   
   function Position
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position;
      
   end Position;
   
   
   
   function EinwohnerArbeiter
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinwohnerArbeiterExtern : in Boolean)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1);
            
         when False =>
            return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2);
      end case;
      
   end EinwohnerArbeiter;
   
      
      
   function Nahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel;
      
   end Nahrungsmittel;
   
   
   
   function Nahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion;
      
   end Nahrungsproduktion;
   
   
   
   function Ressourcen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen;
      
   end Ressourcen;
   
   
   
   function Produktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate;
      
   end Produktionrate;
   
   
   
   function Geldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung;
      
   end Geldgewinnung;
   
   
   
   function PermanenteKostenPosten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelcherPostenExtern : in GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum)
      return GlobaleDatentypen.GesamtePermanenteKosten
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern);
      
   end PermanenteKostenPosten;
   
   
      
   function Forschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate;
      
   end Forschungsrate;
   
   
   
   function Bauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt;
      
   end Bauprojekt;
   
   
   
   function Bauzeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit;
      
   end Bauzeit;
   
   
   
   function Korruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption;
      
   end Korruption;
   
   
   
   function GebäudeVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in GlobaleDatentypen.GebäudeID)
      return Boolean
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (WelchesGebäudeExtern);
      
   end GebäudeVorhanden;
   
   
   
   function Name
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name;
      
   end Name;
   
   
   
   function UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      YPosition, XPosition : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
      return Boolean
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition);
      
   end UmgebungBewirtschaftung;
   
   
   
   function UmgebungGröße
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.LoopRangeMinusDreiZuDrei
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;
      
   end UmgebungGröße;
      
   
      
   function Meldungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelcheMeldungExtern : in GlobaleDatentypen.Stadt_Meldung_Art_Enum)
      return GlobaleDatentypen.Stadt_Meldung_Enum
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
      
      
   function KIBeschäftigung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Stadt_Aufgabe_Enum
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung;
      
   end KIBeschäftigung;

end LeseStadtGebaut;
