with StadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with Weltkarte;
with SpeziesKonstanten;

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
   
   
   
   function Effekt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WelcherEffektExtern : in KartengrundDatentypen.Effekt_Kartenfeld_Enum)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return False;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Effekte (WelcherEffektExtern);
      end case;
      
   end Effekt;
   
   
   
   function Feldeffekte
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.FeldeffektArray
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return (False, False, False, False);
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Effekte;
      end case;
      
   end Feldeffekte;
     
   
      
   function Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return False;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (SpeziesExtern);
      end case;
        
   end Sichtbar;
   
   
   
   function Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenextraDatentypen.Fluss_Enum
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenextraDatentypen.Leer_Fluss_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss;
      end case;
      
   end Fluss;
   
   
   
   function Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Weg_Enum
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
      return KartenverbesserungDatentypen.Verbesserung_Enum
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
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenextraDatentypen.Leer_Ressource_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource;
      end case;
      
   end Ressource;
   
   
   
   function BelegterGrund
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.BelegterGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern)
                                        & "Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return False;
            
         when others =>
            null;
      end case;
            
      if
        Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Spezies = SpeziesExtern
        and
          Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Nummer > StadtKonstanten.LeerNummer
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
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.UnbelegterGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return True;
            
         when others =>
            null;
      end case;
      
      if
        Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Spezies = SpeziesKonstanten.LeerSpezies
        and
          Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Nummer = StadtKonstanten.LeerNummer
      then
         return True;
         
      elsif
        Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Spezies = SpeziesKonstanten.LeerSpezies
        or
          Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Nummer = StadtKonstanten.LeerNummer
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.UnbelegterGrund: Werte ungültig: Spezies: "
                                     & Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Spezies'Wide_Wide_Image & " Nummer: "
                                     & Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Nummer'Wide_Wide_Image);
         return True;
         
      else
         return False;
      end if;
      
   end UnbelegterGrund;
   
   
   
   function StadtbelegungGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.StadtbelegungGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return StadtKonstanten.LeerStadt;
            
         when others =>
            null;
      end case;
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung;
      
   end StadtbelegungGrund;
     
   
      
   function BestimmteStadtBelegtGrund
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.BestimmteStadtBelegtGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return False;
            
         when others =>
            null;
      end case;
     
      if
        Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Spezies = StadtSpeziesNummerExtern.Spezies
        and
          Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Nummer = StadtSpeziesNummerExtern.Nummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BestimmteStadtBelegtGrund;
   
   
   
   function SpeziesBelegtGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return SpeziesDatentypen.Spezies_Enum
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.SpeziesBelegtGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return SpeziesDatentypen.Leer_Spezies_Enum;
            
         when others =>
            null;
      end case;
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Stadtbelegung.Spezies;
      
   end SpeziesBelegtGrund;
   
   
   
   function EinheitenbelegungGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseWeltkarte.EinheitenbelegungGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return EinheitenKonstanten.LeerEinheit;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Einheit;
      end case;
      
   end EinheitenbelegungGrund;
   
   
   
   function GanzerEintrag
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
      return WeltkarteRecords.WeltkarteRecord
   is begin
      
      return Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
      
   end GanzerEintrag;

end LeseWeltkarte;
