with KartenDatentypen;
with KartengrundDatentypen;
with SpeziesDatentypen;
with KartenartDatentypen;
with BewertungDatentypen;

package KartenRecords is
   pragma Pure;
   
   type YXAchsenKartenfeldPositivRecord is record
      
      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;
      
   end record;
   
   
   
   type YXAchsenKartenfeldNaturalRecord is record
            
      YAchse : KartenDatentypen.KartenfeldNatural;
      XAchse : KartenDatentypen.KartenfeldNatural;
            
   end record;
   
   
   
   type YXAchsenKartenfeldRecord is record
      
      YAchse : KartenDatentypen.Kartenfeld;
      XAchse : KartenDatentypen.Kartenfeld;
      
   end record;
   
   
   
   type AchseAnfangEndeRecord is record
      
      Anfang : KartenDatentypen.Kartenfeld;
      Ende : KartenDatentypen.Kartenfeld;
      
   end record;
   
   
   
   -- Das hier vielleicht mal mit AchsenKartenfeldNaturalRecord zusammenführen? äöü
   type AchsenKartenfeldVorhandenRecord is record
      
      EAchse : KartenDatentypen.EbeneVorhanden;
      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;
      
   end record;
   
   
   
   type AchsenKartenfeldNaturalRecord is record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.KartenfeldNatural;
      XAchse : KartenDatentypen.KartenfeldNatural;
      
   end record;
   
   

   type AchsenKartenfeldRecord is record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.Kartenfeld;
      XAchse : KartenDatentypen.Kartenfeld;
      
   end record;
   
   
   
   type EffektbereichRecord is record
      
      YAchseAnfang : KartenDatentypen.Kartenfeld;
      YAchseEnde : KartenDatentypen.KartenfeldNatural;
      XAchseAnfang : KartenDatentypen.Kartenfeld;
      XAchseEnde : KartenDatentypen.KartenfeldNatural;
      
   end record;
   
   
   
   type EffekthöheRecord is record
      
      EAchseAnfang : KartenDatentypen.EbeneVorhanden;
      EAchseEnde : KartenDatentypen.EbeneVorhanden;
      
   end record;
   
   
   
   type EffekteArray is array (KartengrundDatentypen.Effekt_Vorhanden_Enum'Range) of Boolean;
   type EffektbereichArray is array (EffekteArray'Range) of EffektbereichRecord;
   type FeldeffektArray is array (KartengrundDatentypen.Effekt_Kartenfeld_Enum'Range) of Boolean;
   
   
   
   type FelderwertungArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of BewertungDatentypen.Bewertung_Enum;
   type SichtbarkeitArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of Boolean;
   
   type KartengrundRecord is record
      
      Basisgrund : KartengrundDatentypen.Basisgrund_Enum;
      Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
      
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
      
      MinimaleYAchse : KartenDatentypen.KartenfeldPositiv;
      MaximaleYAchse : KartenDatentypen.KartenfeldPositiv;
      
      MinimaleXAchse : KartenDatentypen.KartenfeldPositiv;
      MaximaleXAchse : KartenDatentypen.KartenfeldPositiv;
      
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
      
      Bewertung : KartenDatentypen.KartenfeldNatural;
            
   end record;
   
end KartenRecords;
