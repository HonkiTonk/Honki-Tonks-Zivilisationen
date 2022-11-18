with StadtDatentypen;
with StadtKonstanten;
with KartenKonstanten;
with EinheitenKonstanten;

with Fehlermeldungssystem;
with FehlermeldungssystemZusatzinformationen;

package body LeseWeltkarte is
   
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartengrundDatentypen.Basisgrund_Enum
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
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
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartengrundDatentypen.Leer_Fluss_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss;
      end case;
      
   end Fluss;
   
   
   
   function Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Karten_Weg_Enum
   is begin
            
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenverbesserungDatentypen.Leer_Weg_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Weg;
      end case;
      
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
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartengrundDatentypen.Leer_Ressource_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource;
      end case;
      
   end Ressource;
   
   
   
   function BelegterGrund
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.BelegterGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern)
                                        & "Rasse: " & RasseExtern'Wide_Wide_Image);
            
         when others =>
            null;
      end case;
            
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
   
      
   
   function UnbelegterGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.UnbelegterGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            null;
      end case;
      
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
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.UnbelegterGrund - Werte ungültig. Rasse: "
                             & Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Rasse'Wide_Wide_Image & " Nummer: "
                             & Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.Nummer'Wide_Wide_Image);
         return True;
         
      else
         return False;
      end if;
      
   end UnbelegterGrund;
   
   
   
   function StadtbelegungGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.StadtbelegungGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            null;
      end case;
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund;
      
   end StadtbelegungGrund;
     
   
      
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.BestimmteStadtBelegtGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            null;
      end case;
     
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
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.RasseBelegtGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            null;
      end case;
      
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
