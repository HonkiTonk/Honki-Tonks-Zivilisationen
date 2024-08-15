with KartenDatentypen;
with KartengrundDatentypen;
with SpeziesDatentypen;
with KartenartDatentypen;
with BewertungDatentypen;
with KartenextraDatentypen;

-- Die ganzen Records hier mal besser benennen? äöü
package KartenRecords is
   pragma Pure;
   
   type YXAchsenKartenfeldPositivRecord is record
      
      YAchse : KartenDatentypen.SenkrechtePositiv;
      XAchse : KartenDatentypen.WaagerechtePositiv;
      
   end record;
   
   
   
   type YXAchsenKartenfeldNaturalRecord is record
            
      YAchse : KartenDatentypen.SenkrechteNatural;
      XAchse : KartenDatentypen.WaagerechteNatural;
            
   end record;
   
   
   
   type YXAchsenKartenfeldRecord is record
      
      YAchse : KartenDatentypen.Senkrechte;
      XAchse : KartenDatentypen.Waagerechte;
      
   end record;
   
   
   
   type SichtweiteRecord is record
      
      YAchse : KartenDatentypen.SenkrechteSichtweiteNatural;
      XAchse : KartenDatentypen.WaagerechteSichtweiteNatural;
      
   end record;
   
   
   
   type YAchseAnfangEndeRecord is record
      
      Anfang : KartenDatentypen.Senkrechte;
      Ende : KartenDatentypen.Senkrechte;
      
   end record;
   
   
   
   type XAchseAnfangEndeRecord is record
      
      Anfang : KartenDatentypen.Waagerechte;
      Ende : KartenDatentypen.Waagerechte;
      
   end record;
   
   
   
   -- Das hier vielleicht mal mit AchsenKartenfeldNaturalRecord zusammenführen? äöü
   type AchsenKartenfeldVorhandenRecord is record
      
      EAchse : KartenDatentypen.EbeneVorhanden;
      YAchse : KartenDatentypen.SenkrechtePositiv;
      XAchse : KartenDatentypen.WaagerechtePositiv;
      
   end record;
   
   
   
   type AchsenKartenfeldNaturalRecord is record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.SenkrechteNatural;
      XAchse : KartenDatentypen.WaagerechteNatural;
      
   end record;
   
   

   type AchsenKartenfeldRecord is record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.Senkrechte;
      XAchse : KartenDatentypen.Waagerechte;
      
   end record;
   
   
   
   type EffektbereichRecord is record
      
      YAchseAnfang : KartenDatentypen.Senkrechte;
      YAchseEnde : KartenDatentypen.SenkrechteNatural;
      XAchseAnfang : KartenDatentypen.Waagerechte;
      XAchseEnde : KartenDatentypen.WaagerechteNatural;
      
   end record;
   
   
   
   type EffekthöheRecord is record
      
      EAchseAnfang : KartenDatentypen.EbeneVorhanden;
      EAchseEnde : KartenDatentypen.EbeneVorhanden;
      
   end record;
   
   
   
   type EffekteArray is array (KartenextraDatentypen.Effekt_Vorhanden_Enum'Range) of Boolean;
   type EffektbereichArray is array (EffekteArray'Range) of EffektbereichRecord;
   type FeldeffektArray is array (KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of Boolean;
   
   
   
   type FelderwertungArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of BewertungDatentypen.Bewertung_Enum;
   type SichtbarkeitArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of Boolean;
   -- Mehr davon einbauen um den Arbeitsspeicherverbrauch zu reduzieren. äöü
   for SichtbarkeitArray'Component_Size use 1;
   for SichtbarkeitArray'Size use 18;
   for SichtbarkeitArray'Alignment use 1;
   
   type KartengrundRecord is record
      
      Basisgrund : KartengrundDatentypen.Basisgrund_Enum;
      Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
      
   end record;
   
   
      
   type ImmerVorhandenRecord is record
      
      Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
      Sichtbarkeit : SichtbarkeitArray;
      
   end record;
   
      
      
   type CursorRecord is record
      
      KoordinatenAktuell : AchsenKartenfeldNaturalRecord;
      KoordinatenAlt : AchsenKartenfeldNaturalRecord;
      
   end record;
   
   
   
   type KartenformYAchseRecord is record
      
      YAchseNorden : KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
      YAchseSüden : KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
      
   end record;
   
   
   
   type KartenformXAchseRecord is record
      
      XAchseWesten : KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
      XAchseOsten : KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
      
   end record;
   
   
   
   type KartenformRecord is record
      
      EAchseOben : KartenartDatentypen.Kartenform_E_Einstellbar_Enum;
      EAchseUnten : KartenartDatentypen.Kartenform_E_Einstellbar_Enum;
      YAchseNorden : KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
      YAchseSüden : KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
      XAchseWesten : KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
      XAchseOsten : KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
      
   end record;
   
   
   
   type KartenpoleRecord is record
      
      Nordpol : KartenartDatentypen.Kartenpole_Enum;
      Südpol : KartenartDatentypen.Kartenpole_Enum;
      Westpol : KartenartDatentypen.Kartenpole_Enum;
      Ostpol : KartenartDatentypen.Kartenpole_Enum;
      
   end record;
   
   
   
   type LandgrößenRecord is record
      
      MinimaleYAchse : KartenDatentypen.SenkrechtePositiv;
      MaximaleYAchse : KartenDatentypen.SenkrechtePositiv;
      
      MinimaleXAchse : KartenDatentypen.WaagerechtePositiv;
      MaximaleXAchse : KartenDatentypen.WaagerechtePositiv;
      
   end record;
   
   
   
   type PermanenteKartenparameterRecord is record
      
      Kartengröße : YXAchsenKartenfeldPositivRecord;
      Kartenform : KartenformRecord;
      
   end record;
   
   
   
   type TemporäreKartenparameterRecord is record
      
      Kartengröße : YXAchsenKartenfeldPositivRecord;
      Kartenform : KartenformRecord;
            
      Kartenart : KartenartDatentypen.Kartenart_Enum;
      Kartentemperatur : KartenartDatentypen.Kartentemperatur_Enum;
      Kartenressourcen : KartenartDatentypen.Kartenressourcenmenge_Enum;
      Kartenpole : KartenpoleRecord;
            
   end record;
   
   
   
   type UmgebungskreuzRecord is record
      
      Links : Boolean;
      Rechts : Boolean;
      Oben : Boolean;
      Unten : Boolean;
      
   end record;
   
   
   
   type UmgebungssternRecord is record
      
      Links_Oben_Enum : Boolean;
      Oben_Enum : Boolean;
      Rechts_Oben_Enum : Boolean;
      Rechts_Enum : Boolean;
      Rechts_Unten_Enum : Boolean;
      Unten_Enum : Boolean;
      Links_Unten_Enum : Boolean;
      Links_Enum : Boolean;
            
   end record;
   
   
   
   type BewegungsbewertungRecord is record
            
      Koordinaten : AchsenKartenfeldNaturalRecord;
      
      Bewertung : KartenDatentypen.SenkrechteNatural;
            
   end record;
   
end KartenRecords;
