pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with StadtKonstanten;
with KartenKonstanten;
with EinheitenKonstanten;

with Fehler;

-- Mal den AchsenKartenfeldNaturalRecord auf AchsenKartenfeldPositiveRecord umschreiben oder hier überall eine Umwandlung einbauen? äöü
-- Gilt auch für alle anderen KoordinatenExtern. äöü
-- Bei all diesen Lese/Schreibe aufrufe mal Teile der Contracts als normale Prüfung einbauen. äöü
-- Aufgrund des Doppelzugriffs von Logik- und Grafiktask ist das wohl nötig. äöü
package body LeseWeltkarte is
   
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Basisgrund_Enum
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            -- Kann hier Leer zurückgegeben werden, war bisher Vernichtet? Wahrscheinlich muss ich da noch ein paar Dinge anpassen. äöü
            return KartengrundDatentypen.Leer_Basisgrund_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.Basisgrund;
      end case;
      
   end Basisgrund;
   
   
   
   function Zusatzgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            -- Kann hier Leer zurückgegeben werden, war bisher Vernichtet? Wahrscheinlich muss ich da noch ein paar Dinge anpassen. äöü
            return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.Zusatzgrund;
      end case;
      
   end Zusatzgrund;
   
   
   
   function Gesamtgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.KartengrundRecord
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            -- Kann hier Leer zurückgegeben werden, war bisher Vernichtet? Wahrscheinlich muss ich da noch ein paar Dinge anpassen. äöü
            return (KartengrundDatentypen.Leer_Basisgrund_Enum, KartengrundDatentypen.Leer_Zusatzgrund_Enum);
            
         when others =>
            return (Basisgrund (KoordinatenExtern => KoordinatenExtern), Zusatzgrund (KoordinatenExtern => KoordinatenExtern));
      end case;
      
   end Gesamtgrund;
   
   
   
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
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern);
      end case;
        
   end Sichtbar;
   
   
   
   function Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Kartenfluss_Enum
   is begin
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss;
      
   end Fluss;
   
   
   
   function Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Karten_Weg_Enum
   is begin
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Weg;
      
   end Weg;
   
   
   
   function Verbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Verbesserung;
      end case;
      
   end Verbesserung;
   
   
   
   function Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource;
      
   end Ressource;
   
   
   
   function BelegterGrund
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse = RasseExtern
        and
          Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer > StadtKonstanten.LeerNummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrund;
   
      
   
   -- Mal besser benennen! äöü
   function BelegterGrundLeer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse = StadtKonstanten.LeerRasse
        and
          Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer = StadtKonstanten.LeerNummer
      then
         return True;
         
      elsif
        Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse = StadtKonstanten.LeerRasse
        or
          Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer = StadtKonstanten.LeerNummer
      then
         Fehler.LogikFehler (FehlermeldungExtern => "LeseWeltkarte.BelegterGrundLeer: Rasse oder Nummer falsch.");
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrundLeer;
   
   
   
   function StadtbelegungGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
   is begin
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund;
      
   end StadtbelegungGrund;
     
   
      
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
     
      if
        Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse = StadtRasseNummerExtern.Rasse
        and
          Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer = StadtRasseNummerExtern.Nummer
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
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse;
      
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
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Einheit;
      end case;
      
   end EinheitenbelegungGrund;

end LeseWeltkarte;
