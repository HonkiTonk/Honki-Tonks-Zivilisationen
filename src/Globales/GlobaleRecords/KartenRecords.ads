pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with EinheitStadtDatentypen;
with KartenDatentypen;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;

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
   type FelderwertungArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.GesamtbewertungFeld;
   type SichtbarkeitArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of Boolean;
   
   type BelegterGrundRecord is record
      
      RasseBelegt : SystemDatentypen.Rassen_Enum;
      StadtBelegt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
   end record;
   
   type KartenRecord is record

      Grund : KartenGrundDatentypen.Karten_Grund_Enum;
      Hügel : Boolean;
      Sichtbar : SichtbarkeitArray;
      
      Fluss : KartenGrundDatentypen.Karten_Grund_Enum;
      VerbesserungWeg : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      VerbesserungGebiet : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      Ressource : KartenGrundDatentypen.Karten_Grund_Enum;
      
      DurchStadtBelegterGrund : BelegterGrundRecord;
      Felderwertung : FelderwertungArray;

   end record;
   
   
   
   type CursorRecord is record
      
      KoordinatenAktuell : AchsenKartenfeldPositivRecord;
      KoordinatenAlt : AchsenKartenfeldPositivRecord;
      KoordinatenStadt : AchsenStadtfeldRecord;
      
   end record;
   
   
   
   type KartenformRecord is record
      
      EAchseEinstellung : KartenDatentypen.Kartenform_E_Achse_Einstellbar_Enum;
      YAchseEinstellung : KartenDatentypen.Kartenform_Y_Achse_Einstellbar_Enum;
      XAchseEinstellung : KartenDatentypen.Kartenform_X_Achse_Einstellbar_Enum;
      
      YZuerstBerechnenXZuerstBerechnen : Boolean;
      
   end record;

end KartenRecords;
