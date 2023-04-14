with TextKonstanten;
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
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
            
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).KoordinatenAktuell;
      
   end Koordinaten;
   
   
   
   function EinwohnerArbeiter
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean)
      return ProduktionDatentypen.Einwohner
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
      return ProduktionDatentypen.Einwohner
   is
      use type ProduktionDatentypen.Einwohner;
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
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
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
      return ProduktionDatentypen.Feldproduktion
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit;
      
   end Zufriedenheit;
   
   
   
   function GebäudeVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).GebäudeVorhanden (WelchesGebäudeExtern);
      
   end GebäudeVorhanden;
   
   
   
    function AlleGebäude
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtArrays.GebäudeArray
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).GebäudeVorhanden;
      
   end AlleGebäude;
   
   
   
   function Name
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      if
        StadtSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
        or
          StadtSpeziesNummerExtern.Nummer = StadtKonstanten.LeerNummer
      then
         return TextKonstanten.LeerUnboundedString;
      
      else
         return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Name;
      end if;
   
   end Name;
   
   
   
   function UmgebungBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      XKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei)
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
   
   
   
   function UmgebungGröße
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KartenDatentypen.UmgebungsbereichDrei
   is begin
      
      return GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße;
      
   end UmgebungGröße;
      
   
      
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
