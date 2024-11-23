with EinheitenDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;
with Weltkarte;
with SpeziesKonstanten;

with LeseWeltkarte;

with MeldungssystemHTB1;
with FehlermeldungssystemZusatzinformationen;

package body SchreibeWeltkarte is
   
   procedure Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Basisgrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Basisgrund := GrundExtern;
      end case;
      
   end Basisgrund;
   
   

   procedure Zusatzgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Zusatzgrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Zusatzgrund := GrundExtern;
      end case;
      
   end Zusatzgrund;
   
   
   
   procedure Gesamtgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Gesamtgrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Basisgrund := GrundExtern.Basisgrund;
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Zusatzgrund := GrundExtern.Zusatzgrund;
      end case;
      
   end Gesamtgrund;
   
   
   
   procedure Feldeffekt
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldeffektExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Feldeffekt: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Effekte (FeldeffektExtern) := True;
      end case;
      
   end Feldeffekt;
   
   
   
   procedure AlleFeldeffekte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.AlleFeldeffekte: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Effekte := FeldeffekteExtern;
      end case;
      
   end AlleFeldeffekte;
   
   
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtbarExtern : in Boolean)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Sichtbar: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Sichtbar (SpeziesExtern) := SichtbarExtern;
      end case;
        
   end Sichtbar;
   
   
   
   procedure GesamteSichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SichtbarkeitExtern : in KartenRecords.SichtbarkeitArray)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.GesamteSichtbarkeit: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Sichtbar := SichtbarkeitExtern;
      end case;
      
   end GesamteSichtbarkeit;
   
   
   
   procedure Fluss
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Fluss: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Fluss := FlussExtern;
      end case;
      
   end Fluss;
   
   
   
   procedure Ressource
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Ressource: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Ressource := RessourceExtern;
      end case;
      
   end Ressource;
   
   
   
   procedure Weg
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Weg: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Weg := WegExtern;
      end case;
      
   end Weg;
   
   
   
   procedure Verbesserung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.Verbesserung: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Verbesserung := VerbesserungExtern;
      end case;
      
   end Verbesserung;
   
   
   
   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.KartenfeldNaturalRecord;
      BelegterGrundExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTB1.Logik (MeldungExtern => "SchreibeWeltkarte.BelegterGrund: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Stadtbelegung := BelegterGrundExtern;
      end case;
      
   end BelegterGrund;
   
   
   
   procedure EinheitSchreiben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitentauschExtern : in Boolean)
   is
      use type KartenDatentypen.Ebene;
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
   begin
            
      if
        KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene
      then
         null;
         
      elsif
        LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern) /= EinheitenKonstanten.LeerEinheit
        and
          EinheitentauschExtern = False
      then
         null;
         
      else
         Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Einheit := EinheitSpeziesNummerExtern;
      end if;
      
   end EinheitSchreiben;
   
   
   
   procedure EinheitEntfernen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenDatentypen.Ebene;
      use type EinheitenDatentypen.Einheitenbereich;
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
   begin
      
      if
        EinheitSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
        or
          EinheitSpeziesNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
          or
            KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene
      then
         null;
         
      elsif
        LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern) /= EinheitSpeziesNummerExtern
      then
         null;
         
      else
         Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte).Einheit := EinheitenKonstanten.LeerEinheit;
      end if;
      
   end EinheitEntfernen;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      Weltkarte.Karte := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (EintragExtern : in WeltkarteRecords.WeltkarteRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte) := EintragExtern;
      
   end GanzerEintrag;
   
end SchreibeWeltkarte;
