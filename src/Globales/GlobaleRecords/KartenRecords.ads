pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartengrundDatentypen;
with RassenDatentypen;

package KartenRecords is
   
   type YXAchsenKartenfeldNaturalRecord is record
            
      YAchse : KartenDatentypen.KartenfeldNatural;
      XAchse : KartenDatentypen.KartenfeldNatural;
            
   end record;
   
   
   
   type YXAchsenKartenfeldPositivRecord is record
      
      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;
      
   end record;
   
   
   
   type YXAchsenKartenfeldRecord is record
      
      YAchse : KartenDatentypen.Kartenfeld;
      XAchse : KartenDatentypen.Kartenfeld;
      
   end record;
   
   

   type AchsenKartenfeldRecord is record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.Kartenfeld;
      XAchse : KartenDatentypen.Kartenfeld;
      
   end record;
   
   
   
   type AchsenKartenfeldNaturalRecord is tagged record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.KartenfeldNatural;
      XAchse : KartenDatentypen.KartenfeldNatural;
      
   end record;
   
   
   
   type AchsenKartenfeldVorhandenRecord is record
      
      EAchse : KartenDatentypen.EbeneVorhanden;
      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;
      
   end record;
   
   
   
   type FelderwertungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.Bewertung_Enum;
   type SichtbarkeitArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Boolean;
   
   type KartengrundRecord is record
      
      BasisGrund : KartengrundDatentypen.Kartengrund_Enum;
      AktuellerGrund : KartengrundDatentypen.Kartengrund_Enum;
      
   end record;
   
      
      
   type CursorRecord is record
      
      KoordinatenAktuell : AchsenKartenfeldNaturalRecord;
      KoordinatenAlt : AchsenKartenfeldNaturalRecord;
      
   end record;
   
   
   
   type KartenformRecord is record
      
      EAchseOben : KartenDatentypen.Kartenform_E_Einstellbar_Enum;
      EAchseUnten : KartenDatentypen.Kartenform_E_Einstellbar_Enum;
      YAchseNorden : KartenDatentypen.Kartenform_Y_Einstellbar_Enum;
      YAchseSüden : KartenDatentypen.Kartenform_Y_Einstellbar_Enum;
      XAchseWesten : KartenDatentypen.Kartenform_X_Einstellbar_Enum;
      XAchseOsten : KartenDatentypen.Kartenform_X_Einstellbar_Enum;
      
   end record;
   
   
   
   type KartenpoleRecord is record
      
      Nordpol : KartenDatentypen.Kartenpole_Enum;
      Südpol : KartenDatentypen.Kartenpole_Enum;
      Westpol : KartenDatentypen.Kartenpole_Enum;
      Ostpol : KartenDatentypen.Kartenpole_Enum;
      
   end record;
   
   
   
   type LandgrößenRecord is record
      
      MinimaleYAchse : KartenDatentypen.KartenfeldPositiv;
      MaximaleYAchse : KartenDatentypen.KartenfeldPositiv;
      
      MinimaleXAchse : KartenDatentypen.KartenfeldPositiv;
      MaximaleXAchse : KartenDatentypen.KartenfeldPositiv;
      
   end record;
   
   
   
   type PermanenteKartenparameterRecord is tagged record
      
      Kartengröße : YXAchsenKartenfeldPositivRecord;
      Kartenform : KartenformRecord;
      
   end record;
   
   
   
   type TemporäreKartenparameterRecord is new PermanenteKartenparameterRecord with record
            
      Kartenart : KartenDatentypen.Kartenart_Enum;
      Kartentemperatur : KartenDatentypen.Kartentemperatur_Enum;
      Kartenressourcen : KartenDatentypen.Kartenressourcen_Enum;
      Kartenpole : KartenpoleRecord;
            
   end record;
   
end KartenRecords;
