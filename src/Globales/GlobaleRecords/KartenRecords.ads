pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;
with RassenDatentypen;

package KartenRecords is

   type AchsenStadtfeldRecord is record
      
      YAchse : KartenDatentypen.Stadtfeld;
      XAchse : KartenDatentypen.Stadtfeld;
      
   end record;
   
   
   
   type YXAchsenKartenfeldMitNullwertRecord is record
            
      YAchse : KartenDatentypen.KartenfeldPositivMitNullwert;
      XAchse : KartenDatentypen.KartenfeldPositivMitNullwert;
            
   end record;
   
   
   
   type YXAchsenKartenfeldPositivRecord is record
      
      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;
      
   end record;
   
   
   
   type YXAchsenKartenfeldRecord is record
      
      YAchse : KartenDatentypen.Kartenfeld;
      XAchse : KartenDatentypen.Kartenfeld;
      
   end record;
   
   
   
   --------------------- Auch mal eine Version ohne Nullwert anlegen.
   -- Mal auf Nullwert umbenennen? ---------------
   type AchsenKartenfeldPositivRecord is tagged record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.KartenfeldPositivMitNullwert;
      XAchse : KartenDatentypen.KartenfeldPositivMitNullwert;
      
   end record;
   
   

   type AchsenKartenfeldRecord is record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.Kartenfeld;
      XAchse : KartenDatentypen.Kartenfeld;
      
   end record;
   
   
   
   -- Die Bewertung rauswerfen und entsprechend die Einheiten beim Bauen einer Stadt alles Bewerten lassen?
   -- Felderbelegung stattdessen einbauen?
   type FelderwertungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.GesamtbewertungFeld;
   type SichtbarkeitArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Boolean;
   
   type BelegterGrundRecord is record
      
      RasseBelegt : RassenDatentypen.Rassen_Enum;
      StadtBelegt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
   end record;
   
   type KartenRecord is record

      Grund : KartengrundDatentypen.Kartengrund_Enum;
      Hügel : Boolean;
      Sichtbar : SichtbarkeitArray;
      
      Fluss : KartengrundDatentypen.Kartenfluss_Enum;
      Ressource : KartengrundDatentypen.Karten_Ressourcen_Enum;
      
      Weg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
      Verbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      
      DurchStadtBelegterGrund : BelegterGrundRecord;
      Felderwertung : FelderwertungArray;

   end record;
   
   
   
   type CursorRecord is record
      
      KoordinatenAktuell : AchsenKartenfeldPositivRecord;
      KoordinatenAlt : AchsenKartenfeldPositivRecord;
      KoordinatenStadt : AchsenStadtfeldRecord;
      
   end record;
   
   
   
   type KartenformRecord is record
      
      EAchseOben : KartenDatentypen.Kartenform_E_Einstellbar_Enum;
      EAchseUnten : KartenDatentypen.Kartenform_E_Einstellbar_Enum;
      YAchseNorden : KartenDatentypen.Kartenform_Y_Einstellbar_Enum;
      YAchseSüden : KartenDatentypen.Kartenform_Y_Einstellbar_Enum;
      XAchseWesten : KartenDatentypen.Kartenform_X_Einstellbar_Enum;
      XAchseOsten : KartenDatentypen.Kartenform_X_Einstellbar_Enum;
      
      YZuerstBerechnenXZuerstBerechnen : Boolean;
      
   end record;
   
   
   
   type KartenpoleRecord is record
      
      YAchseNorden : KartenDatentypen.Kartenpole_Enum;
      YAchseSüden : KartenDatentypen.Kartenpole_Enum;
      XAchseWesten : KartenDatentypen.Kartenpole_Enum;
      XAchseOsten : KartenDatentypen.Kartenpole_Enum;
      
   end record;
   
   
   
   type KartenpoleKorrekturRecord is record 
      
      Norden : KartenDatentypen.KartenfeldPositivMitNullwert;
      Süden : KartenDatentypen.KartenfeldPositivMitNullwert;
      Westen : KartenDatentypen.KartenfeldPositivMitNullwert;
      Osten : KartenDatentypen.KartenfeldPositivMitNullwert;
      
   end record;
   
   
   
   type KartenparameterRecord is record
      
      Kartengröße : KartenDatentypen.Kartengröße_Enum;
      Kartenart : KartenDatentypen.Kartenart_Enum;
      Kartentemperatur : KartenDatentypen.Kartentemperatur_Enum;
      Kartenressourcen : KartenDatentypen.Kartenressourcen_Enum;
      Kartenpole : KartenpoleRecord;
      
      Kartenform : KartenformRecord;
      
   end record;
   
end KartenRecords;
