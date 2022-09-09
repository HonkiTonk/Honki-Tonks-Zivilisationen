pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with StadtKonstanten;
with KartenKonstanten;
with EinheitenKonstanten;

with Fehler;

-- Mal den AchsenKartenfeldNaturalRecord auf AchsenKartenfeldPositiveRecord umschreiben oder hier überall eine Umwandlung einbauen? äöü
-- Gilt auch für alle anderen KoordinatenExtern. äöü
package body LeseKarten is
   
   function BasisGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.BasisGrund;
      
   end BasisGrund;
   
   
   
   function AktuellerGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.AktuellerGrund;
      
   end AktuellerGrund;
   
   
   
   function VorhandenerGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.KartengrundRecord
   is begin
      
      return (BasisGrund (KoordinatenExtern => KoordinatenExtern), AktuellerGrund (KoordinatenExtern => KoordinatenExtern));
      
   end VorhandenerGrund;
   
   
   
   function Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return False;
            
         when others =>
            return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern);
      end case;
        
   end Sichtbar;
   
   
   
   function Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Kartenfluss_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss;
      
   end Fluss;
   
   
   
   function Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Karten_Weg_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Weg;
      
   end Weg;
   
   
   
   function Verbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Verbesserung;
      
   end Verbesserung;
   
   
   
   function Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource;
      
   end Ressource;
   
   
   
   function Bewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Bewertung_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung (RasseExtern);
      
   end Bewertung;
   
   
   
   function BelegterGrund
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse = RasseExtern
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer > StadtKonstanten.LeerNummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrund;
   
      
   
   function BelegterGrundLeer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse = StadtKonstanten.LeerRasse
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer = StadtKonstanten.LeerNummer
      then
         return True;
         
      elsif
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse = StadtKonstanten.LeerRasse
        or
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer = StadtKonstanten.LeerNummer
      then
         Fehler.LogikFehler (FehlermeldungExtern => "LeseKarten.BelegterGrundLeer - Rasse oder Nummer falsch.");
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrundLeer;
   
   
   
   function StadtbelegungGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund;
      
   end StadtbelegungGrund;
     
   
      
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
     
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse = StadtRasseNummerExtern.Rasse
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer = StadtRasseNummerExtern.Nummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BestimmteStadtBelegtGrund;
   
   
   
   function RasseBelegtGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return RassenDatentypen.Rassen_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse;
      
   end RasseBelegtGrund;
   
   
   
   function EinheitenbelegungGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.RasseEinheitnummerRecord
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return EinheitenKonstanten.LeerRasseNummer;
            
         when others =>
            return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Einheit;
      end case;
      
   end EinheitenbelegungGrund;

end LeseKarten;
