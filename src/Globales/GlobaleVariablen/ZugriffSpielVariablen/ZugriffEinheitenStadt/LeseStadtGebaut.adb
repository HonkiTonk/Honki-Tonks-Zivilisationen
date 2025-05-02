with TextKonstantenHTSEB;

with GebautVariablen;
with SpeziesKonstanten;

package body LeseStadtGebaut is

   function ID
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).ID;
      
   end ID;
   
   
   
   function Koordinaten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
            
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Koordinaten;
      
   end Koordinaten;
   
   
   
   function EinwohnerArbeiter
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean)
      return StadtDatentypen.Einwohner
   is begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (1);
            
         when False =>
            return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (2);
      end case;
      
   end EinwohnerArbeiter;
   
   
   
   function Arbeitslose
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtDatentypen.Einwohner
   is
      use type StadtDatentypen.Einwohner;
   begin
      
      return EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                EinwohnerArbeiterExtern => True)
        - EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                             EinwohnerArbeiterExtern => False);
      
   end Arbeitslose;
   
   
   
   function Nahrungsmittel
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsmittel;
      
   end Nahrungsmittel;
   
   
   
   function Nahrungsproduktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsproduktion;
      
   end Nahrungsproduktion;
   
   
   
   function Material
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material;
      
   end Material;
   
   
   
   function Produktionrate
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate;
      
   end Produktionrate;
   
   
   
   function Geldgewinnung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Geldgewinnung;
      
   end Geldgewinnung;
   
   
   
   function PermanenteKostenPosten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Vorhanden_Enum)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern);
      
   end PermanenteKostenPosten;
   
   
      
   function Forschungsrate
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
   is begin
            
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Forschungsrate;
      
   end Forschungsrate;
   
   
   
   function Bauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.BauprojektRecord
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauprojekt;
      
   end Bauprojekt;
   
   
   
   function Bauzeit
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Produktion
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauzeit;
      
   end Bauzeit;
   
   
   
   function Korruption
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.StadtLagermenge
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Korruption;
      
   end Korruption;
   
   
   
   function Zufriedenheit
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.ZufriedenheitVorhanden
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit;
      
   end Zufriedenheit;
   
   
   
   -- Hier mal das Welches entfernen. äöü
   function GebäudeVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Gebäude (WelchesGebäudeExtern);
      
   end GebäudeVorhanden;
   
   
   
    function AlleGebäude
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtArrays.GebäudeArray
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Gebäude;
      
   end AlleGebäude;
   
   
   
   function Name
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type StadtDatentypen.Städtebereich;
   begin
      
      if
        StadtSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
        or
          StadtSpeziesNummerExtern.Nummer = StadtKonstanten.LeerNummer
      then
         return TextKonstantenHTSEB.LeerUnboundedString;
      
      else
         return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Name;
      end if;
   
   end Name;
   
   
   
   -- Y/X noch durch Senkrechte/Waagerechte ersetzen. äöü
   function UmgebungBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.SenkrechteUmgebungDrei;
      XKoordinateExtern : in KartenDatentypen.WaagerechteUmgebungDrei)
      return Boolean
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungBewirtschaftung (YKoordinateExtern, XKoordinateExtern);
      
   end UmgebungBewirtschaftung;
   
   
   
   function GesamteBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.UmgebungBewirtschaftungArray
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungBewirtschaftung;
      
   end GesamteBewirtschaftung;
   
   
   
   function Gesamtumgebung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenRecords.UmgebungDreiRecord
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße;
      
   end Gesamtumgebung;
   
   
   
   function Umgebungssenkrechte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenDatentypen.SenkrechteUmgebungDrei
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Senkrechte;
      
   end Umgebungssenkrechte;
     
   
   
   function Umgebungswaagerechte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenDatentypen.WaagerechteUmgebungDrei
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Waagerechte;
      
   end Umgebungswaagerechte;
      
   
      
   function Meldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum)
      return StadtDatentypen.Stadt_Meldung_Enum
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
      
      
   function KIBeschäftigung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KIDatentypen.Stadt_Aufgabe_Enum
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).KIBeschäftigung;
      
   end KIBeschäftigung;
   
   
   
   function GanzerEintrag
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.StadtGebautRecord
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer);
      
   end GanzerEintrag;
   
end LeseStadtGebaut;
