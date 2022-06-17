pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Fehler;

package body SchreibeKarten is

   procedure AktuellerGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).AktuellerGrund := GrundExtern;
      
   end AktuellerGrund;
   
   
   
   procedure BasisGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum'Range | KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum'Range =>
            Fehler.LogikFehler (FehlermeldungExtern => "SchreibeKarten.BasisGrund - Zusatzgrund wird auf Basisgrund geschrieben.");
            
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).BasisGrund := GrundExtern;
      end case;
      
   end BasisGrund;
   
   
   
   procedure GleicherGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      BasisGrund (KoordinatenExtern => KoordinatenExtern,
                  GrundExtern       => GrundExtern);
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).AktuellerGrund := GrundExtern;
      
   end GleicherGrund;
   
   
   
   procedure UnterschiedlicherGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BasisgrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AktuellerGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      BasisGrund (KoordinatenExtern => KoordinatenExtern,
                  GrundExtern       => BasisgrundExtern);
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).AktuellerGrund := AktuellerGrundExtern;
      
   end UnterschiedlicherGrund;
   
   
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern) := SichtbarExtern;
        
   end Sichtbar;
   
   
   
   procedure Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss := FlussExtern;
      
   end Fluss;
   
   
   
   procedure Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Weg := WegExtern;
      
   end Weg;
   
   
   
   procedure Verbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Verbesserung := VerbesserungExtern;
      
   end Verbesserung;
   
   
   
   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource := RessourceExtern;
      
   end Ressource;
   
   
   
   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegterGrundExtern : in KartenRecords.BelegterGrundRecord)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund := BelegterGrundExtern;
      
   end BelegterGrund;
   
   
   
   procedure Bewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in KartenDatentypen.GesamteFeldbewertung)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung (RasseExtern) := BewertungExtern;
      
   end Bewertung;
end SchreibeKarten;
