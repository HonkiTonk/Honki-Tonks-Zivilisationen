pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;
with RassenDatentypen;

package KartenRecords is

   type AchsenStadtfeldRecord is record
      
      YAchse : KartenDatentypen.Stadtfeld;
      XAchse : KartenDatentypen.Stadtfeld;
      
   end record;
   
   
   
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
   
   
   
   -- Die Bewertung rauswerfen und entsprechend die Einheiten beim Bauen einer Stadt alles Bewerten lassen?
   -- Felderbelegung stattdessen einbauen?
   type FelderwertungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.GesamteFeldbewertung;
   type SichtbarkeitArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Boolean;
   
   type BelegterGrundRecord is record
      
      RasseBelegt : RassenDatentypen.Rassen_Enum;
      StadtBelegt : StadtDatentypen.MaximaleStädteMitNullWert;
      
   end record;
   
   type KartenRecord is record

      AktuellerGrund : KartengrundDatentypen.Kartengrund_Enum;
      BasisGrund : KartengrundDatentypen.Kartengrund_Enum;
      Sichtbar : SichtbarkeitArray;
      
      Fluss : KartengrundDatentypen.Kartenfluss_Enum;
      Ressource : KartengrundDatentypen.Kartenressourcen_Enum;
      
      Weg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
      Verbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      
      DurchStadtBelegterGrund : BelegterGrundRecord;
      Felderwertung : FelderwertungArray;

   end record;
   
   
   
   type CursorRecord is record
      
      KoordinatenAktuell : AchsenKartenfeldNaturalRecord;
      KoordinatenAlt : AchsenKartenfeldNaturalRecord;
      KoordinatenStadt : AchsenStadtfeldRecord;
      
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
   
   
   
   type LandabständeRecord is record
      
      MinimaleYAchse : KartenDatentypen.KartenfeldNatural;
      MaximaleYAchse : KartenDatentypen.KartenfeldNatural;
      
      MinimaleXAchse : KartenDatentypen.KartenfeldNatural;
      MaximaleXAchse : KartenDatentypen.KartenfeldNatural;
      
   end record;
   
   
   
   type KartenparameterRecord is record
      
      Kartengröße : YXAchsenKartenfeldPositivRecord;
      Kartenart : KartenDatentypen.Kartenart_Enum;
      Kartentemperatur : KartenDatentypen.Kartentemperatur_Enum;
      Kartenressourcen : KartenDatentypen.Kartenressourcen_Enum;
      Kartenpole : KartenpoleRecord;
      
      Kartenform : KartenformRecord;
      
   end record;
   
end KartenRecords;
