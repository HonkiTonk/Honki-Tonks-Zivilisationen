pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with StadtKonstanten;
with KartenRecordKonstanten;

with Karten;
with Fehler;

package body LeseStadtGebaut is

   function ID
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.Karten_Verbesserung_Stadt_ID_Enum
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID;
      
   end ID;
   
   
   
   function Koordinaten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Koordinaten.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
        or
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Koordinaten.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Koordinaten := KartenRecordKonstanten.LeerKartenKoordinaten;

      else
         null;
      end if;
            
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Koordinaten;
      
   end Koordinaten;
   
   
   
   function EinwohnerArbeiter
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinwohnerArbeiterExtern : in Boolean)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) < StadtKonstanten.LeerStadt.EinwohnerArbeiter (1)
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) := StadtKonstanten.LeerStadt.EinwohnerArbeiter (1);
               
            else
               null;
            end if;
                        
            return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1);
            
         when False =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) < StadtKonstanten.LeerStadt.EinwohnerArbeiter (2)
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) := StadtKonstanten.LeerStadt.EinwohnerArbeiter (2);
               
            else
               null;
            end if;
            
            return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2);
      end case;
      
   end EinwohnerArbeiter;
   
   
      
   function Nahrungsmittel
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel < StadtKonstanten.LeerStadt.Nahrungsmittel
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := StadtKonstanten.LeerStadt.Nahrungsmittel;
         
      else
         null;
      end if;
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel;
      
   end Nahrungsmittel;
   
   
   
   function Nahrungsproduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion;
      
   end Nahrungsproduktion;
   
   
   
   function Ressourcen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen;
      
   end Ressourcen;
   
   
   
   function Produktionrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate;
      
   end Produktionrate;
   
   
   
   function Geldgewinnung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung;
      
   end Geldgewinnung;
   
   
   
   function PermanenteKostenPosten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelcherPostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum)
      return EinheitStadtDatentypen.GesamtePermanenteKosten
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern);
      
   end PermanenteKostenPosten;
   
   
      
   function Forschungsrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate < StadtKonstanten.LeerStadt.Forschungsrate
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate := StadtKonstanten.LeerStadt.Forschungsrate;
         
      else
         null;
      end if;
            
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate;
      
   end Forschungsrate;
   
   
   
   function Bauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.BauprojektRecord
   is begin
      
      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt.Nummer
      is
         when EinheitStadtDatentypen.MinimimMaximumID'First =>
            Fehler.LogikFehler (FehlermeldungExtern => "LeseStadtGebaut.Bauprojekt - Aktuelles Bauprojekt ist ungültig.");
            
         when others =>
            null;
      end case;
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt;
      
   end Bauprojekt;
   
   
   
   function Bauzeit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit;
      
   end Bauzeit;
   
   
   
   function Korruption
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption;
      
   end Korruption;
   
   
   
   function Zufriedenheit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Zufriedenheit;
      
   end Zufriedenheit;
   
   
   
   function GebäudeVorhanden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in EinheitStadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (WelchesGebäudeExtern);
      
   end GebäudeVorhanden;
   
   
   
   function Name
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name;
      
   end Name;
   
   
   
   function UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      YKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      XKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YKoordinateExtern, XKoordinateExtern);
      
   end UmgebungBewirtschaftung;
   
   
   
   function UmgebungGröße
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.UmgebungsbereichDrei
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße < StadtKonstanten.LeerStadt.UmgebungGröße
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := StadtKonstanten.LeerStadt.UmgebungGröße;
         
      else
         null;
      end if;
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;
      
   end UmgebungGröße;
      
   
      
   function Meldungen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelcheMeldungExtern : in EinheitStadtDatentypen.Stadt_Meldung_Art_Enum)
      return EinheitStadtDatentypen.Stadt_Meldung_Enum
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
      
      
   function KIBeschäftigung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIDatentypen.Stadt_Aufgabe_Enum
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung;
      
   end KIBeschäftigung;
   
   
   
   function GanzerEintrag
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.StadtGebautRecord
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer);
      
   end GanzerEintrag;
   
end LeseStadtGebaut;
