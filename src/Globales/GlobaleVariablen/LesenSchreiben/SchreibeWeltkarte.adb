pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;
with KartenKonstanten;

with LeseWeltkarte;

package body SchreibeWeltkarte is
   
   procedure Basisgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.Basisgrund := GrundExtern;
      
   end Basisgrund;
   
   

   procedure Zusatzgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund.Zusatzgrund := GrundExtern;
      
   end Zusatzgrund;
   
   
   
   procedure Gesamtgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
   is begin
      
      Weltkarte.Karte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund := GrundExtern;
      
   end Gesamtgrund;
   
   
   
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
   
   
   
   procedure EinheitSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      EinheitentauschExtern : in Boolean)
   is begin
      
      if
        KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse
      then
         null;
         
      elsif
        LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern) /= EinheitenKonstanten.LeerRasseNummer
        and
          EinheitentauschExtern = False
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
