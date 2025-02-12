with KartenKonstanten;
with EinheitenKonstanten;
with Weltkarte;
with SpeziesKonstanten;
with KartenRecordKonstanten;

with MeldungssystemHTSEB;
with FehlermeldungssystemZusatzinformationen;

package body LeseWeltkarte is
   
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartengrundDatentypen.Basisgrund_Enum
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartengrundDatentypen.Leer_Basisgrund_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Basisgrund;
      end case;
      
   end Basisgrund;
   
   
   
   function Zusatzgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Zusatzgrund;
      end case;
      
   end Zusatzgrund;
   
   
   
   function Gesamtgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.KartengrundRecord
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return (KartengrundDatentypen.Leer_Basisgrund_Enum, KartengrundDatentypen.Leer_Zusatzgrund_Enum);
            
         when others =>
            return (Basisgrund (KoordinatenExtern => KoordinatenExtern), Zusatzgrund (KoordinatenExtern => KoordinatenExtern));
      end case;
      
   end Gesamtgrund;
   
   
   
   function Effekt
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      WelcherEffektExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return False;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Effekte (WelcherEffektExtern);
      end case;
      
   end Effekt;
   
   
   
   function Feldeffekte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.FeldeffektArray
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartenRecordKonstanten.LeerEffekte;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Effekte;
      end case;
      
   end Feldeffekte;
     
   
      
   function Sichtbar
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return False;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Sichtbar (SpeziesExtern);
      end case;
        
   end Sichtbar;
   
   
   
   function GesamteSichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.SichtbarkeitArray
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartenRecordKonstanten.LeerSichtbarkeit;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Sichtbar;
      end case;
      
   end GesamteSichtbarkeit;
   
   
   
   function Fluss
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenextraDatentypen.Fluss_Enum
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartenextraDatentypen.Leer_Fluss_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Fluss;
      end case;
      
   end Fluss;
   
   
   
   function Weg
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Weg_Enum
   is begin
            
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartenverbesserungDatentypen.Leer_Weg_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Weg;
      end case;
      
   end Weg;
   
   
   
   function Verbesserung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Verbesserung_Enum
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Verbesserung;
      end case;
      
   end Verbesserung;
   
   
   
   function Ressource
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return KartenextraDatentypen.Leer_Ressource_Enum;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Ressource;
      end case;
      
   end Ressource;
   
   
   
   function BelegterGrund
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseWeltkarte.BelegterGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern)
                                        & "Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return False;
            
         when others =>
            null;
      end case;
            
      if
        Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Spezies = SpeziesExtern
        and
          Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Nummer > StadtKonstanten.LeerNummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrund;
   
      
   
   function UnbelegterGrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseWeltkarte.UnbelegterGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return True;
            
         when others =>
            null;
      end case;
      
      if
        Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Spezies = SpeziesKonstanten.LeerSpezies
        and
          Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Nummer = StadtKonstanten.LeerNummer
      then
         return True;
         
      elsif
        Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Spezies = SpeziesKonstanten.LeerSpezies
        or
          Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Nummer = StadtKonstanten.LeerNummer
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LeseWeltkarte.UnbelegterGrund: Werte ungültig: Spezies: "
                                     & Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Spezies'Wide_Wide_Image & " Nummer: "
                                     & Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Nummer'Wide_Wide_Image);
         return True;
         
      else
         return False;
      end if;
      
   end UnbelegterGrund;
   
   
   
   function StadtbelegungGrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseWeltkarte.StadtbelegungGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return StadtKonstanten.LeerStadt;
            
         when others =>
            null;
      end case;
      
      return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung;
      
   end StadtbelegungGrund;
     
   
      
   function BestimmteStadtBelegtGrund
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseWeltkarte.BestimmteStadtBelegtGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return False;
            
         when others =>
            null;
      end case;
     
      if
        Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Spezies = StadtSpeziesNummerExtern.Spezies
        and
          Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Nummer = StadtSpeziesNummerExtern.Nummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BestimmteStadtBelegtGrund;
   
   
   
   function SpeziesBelegtGrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return SpeziesDatentypen.Spezies_Enum
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseWeltkarte.SpeziesBelegtGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return SpeziesDatentypen.Leer_Spezies_Enum;
            
         when others =>
            null;
      end case;
      
      return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung.Spezies;
      
   end SpeziesBelegtGrund;
   
   
   
   function EinheitenbelegungGrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseWeltkarte.EinheitenbelegungGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            return EinheitenKonstanten.LeerEinheit;
            
         when others =>
            return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Einheit;
      end case;
      
   end EinheitenbelegungGrund;
   
   
   
   function GanzerEintrag
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
      return WeltkarteRecords.WeltkarteRecord
   is begin
      
      return Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte);
      
   end GanzerEintrag;

end LeseWeltkarte;
