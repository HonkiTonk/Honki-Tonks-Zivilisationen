pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with KartenRecordKonstanten;

package body LeseStadtGebaut is

   function ID
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).ID;
      
   end ID;
   
   
   
   function Koordinaten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      if
        SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KoordinatenAktuell.YAchse > Karten.Kartenparameter.Kartengröße.YAchse
        or
          SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KoordinatenAktuell.XAchse > Karten.Kartenparameter.Kartengröße.XAchse
      then
         SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KoordinatenAktuell := KartenRecordKonstanten.LeerKartenKoordinaten;

      else
         null;
      end if;
            
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KoordinatenAktuell;
      
   end Koordinaten;
   
   
   
   function EinwohnerArbeiter
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean)
      return ProduktionDatentypen.Einwohner
   is begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) < StadtKonstanten.LeerStadt.EinwohnerArbeiter (1)
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) := StadtKonstanten.LeerStadt.EinwohnerArbeiter (1);
               
            else
               null;
            end if;
                        
            return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1);
            
         when False =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) < StadtKonstanten.LeerStadt.EinwohnerArbeiter (2)
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) := StadtKonstanten.LeerStadt.EinwohnerArbeiter (2);
               
            else
               null;
            end if;
            
            return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2);
      end case;
      
   end EinwohnerArbeiter;
   
   
      
   function Nahrungsmittel
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      if
        SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel < StadtKonstanten.LeerStadt.Nahrungsmittel
      then
         SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := StadtKonstanten.LeerStadt.Nahrungsmittel;
         
      else
         null;
      end if;
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel;
      
   end Nahrungsmittel;
   
   
   
   function Nahrungsproduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion;
      
   end Nahrungsproduktion;
   
   
   
   function Ressourcen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Produktion
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen;
      
   end Ressourcen;
   
   
   
   function Produktionrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate;
      
   end Produktionrate;
   
   
   
   function Geldgewinnung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung;
      
   end Geldgewinnung;
   
   
   
   function PermanenteKostenPosten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern);
      
   end PermanenteKostenPosten;
   
   
      
   function Forschungsrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      if
        SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate < StadtKonstanten.LeerStadt.Forschungsrate
      then
         SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := StadtKonstanten.LeerStadt.Forschungsrate;
         
      else
         null;
      end if;
            
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate;
      
   end Forschungsrate;
   
   
   
   function Bauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return StadtRecords.BauprojektRecord
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt;
      
   end Bauprojekt;
   
   
   
   function Bauzeit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Produktion
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauzeit;
      
   end Bauzeit;
   
   
   
   function Korruption
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption;
      
   end Korruption;
   
   
   
   function Zufriedenheit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Feldproduktion
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit;
      
   end Zufriedenheit;
   
   
   
   function GebäudeVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).GebäudeVorhanden (WelchesGebäudeExtern);
      
   end GebäudeVorhanden;
   
   
   
   function Name
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Name;
      
   end Name;
   
   
   
   function UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      XKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungBewirtschaftung (YKoordinateExtern, XKoordinateExtern);
      
   end UmgebungBewirtschaftung;
   
   
   
   function UmgebungGröße
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KartenDatentypen.UmgebungsbereichDrei
   is begin
      
      if
        SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße < StadtKonstanten.LeerStadt.UmgebungGröße
      then
         SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := StadtKonstanten.LeerStadt.UmgebungGröße;
         
      else
         null;
      end if;
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße;
      
   end UmgebungGröße;
      
   
      
   function Meldungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum)
      return StadtDatentypen.Stadt_Meldung_Enum
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
      
      
   function KIBeschäftigung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KIDatentypen.Stadt_Aufgabe_Enum
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KIBeschäftigung;
      
   end KIBeschäftigung;
   
   
   
   function GanzerEintrag
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return StadtRecords.StadtGebautRecord
   is begin
      
      return SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer);
      
   end GanzerEintrag;
   
end LeseStadtGebaut;
