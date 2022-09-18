pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;
with KartenKonstanten;

with LeseWeltkarte;

with Fehler;

package body SchreibeWeltkarte is

   procedure AktuellerGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.AktuellerGrund := GrundExtern;
      
   end AktuellerGrund;
   
   
   
   procedure BasisGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum'Range | KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum'Range =>
            Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWeltkarte.BasisGrund - Zusatzgrund auf Basisgrund geschrieben.");
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.BasisGrund := GrundExtern;
      end case;
      
   end BasisGrund;
   
   
   
   procedure GleicherGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund := (GrundExtern, GrundExtern);
      
   end GleicherGrund;
   
   
   
   procedure UnterschiedlicherGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BasisgrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AktuellerGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund := (BasisgrundExtern, AktuellerGrundExtern);
      
   end UnterschiedlicherGrund;
   
   
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern) := SichtbarExtern;
        
   end Sichtbar;
   
   
   
   procedure Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss := FlussExtern;
      
   end Fluss;
   
   
   
   procedure Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Weg := WegExtern;
      
   end Weg;
   
   
   
   procedure Verbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      -- Wird benötigt da beim Bauen einer Stadt sicherheitshalber alles auf Null gesetzt wird und dabei auch die Kartenverbesserung hier.
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            null;
            
         when others =>
            Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Verbesserung := VerbesserungExtern;
      end case;
      
   end Verbesserung;
   
   
   
   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource := RessourceExtern;
      
   end Ressource;
   
   
   
   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegterGrundExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund := BelegterGrundExtern;
      
   end BelegterGrund;
   
   
   
   procedure Bewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in KartenDatentypen.GesamteFeldbewertung)
   is begin
      
      Bewertungwert := BewertungExtern / 125;
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung (RasseExtern) := KartenDatentypen.Bewertung_Enum'Val (Bewertungwert);
      
   end Bewertung;
   
   
   
   procedure EinheitSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse
      then
         null;
         
      elsif
        LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern) /= EinheitenKonstanten.LeerRasseNummer
      then
         null;
         
      else
         Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Einheit := EinheitRasseNummerExtern;
      end if;
      
   end EinheitSchreiben;
   
   
   
   procedure EinheitEntfernen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse = EinheitenKonstanten.LeerRasse
        or
          EinheitRasseNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
          or
            KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse
      then
         null;
         
      elsif
        LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern) /= EinheitRasseNummerExtern
      then
         null;
         
      else
         Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Einheit := EinheitenKonstanten.LeerRasseNummer;
      end if;
      
   end EinheitEntfernen;
   
end SchreibeWeltkarte;
