with KartenDatentypen;
with KartengrundDatentypen;
with SpeziesDatentypen;
with KartenartDatentypen;
with ZufallsgeneratorenDatentypenHTSEB;
with KartenextraDatentypen;

package KartenRecords is
   pragma Pure;
   
   type KartenfeldumgebungPositivRecord is record
      
      Senkrechte : KartenDatentypen.SenkrechtePositiv;
      Waagerechte : KartenDatentypen.WaagerechtePositiv;
      
   end record;
   
   
   
   type KartenfeldumgebungNaturalRecord is record
            
      Senkrechte : KartenDatentypen.SenkrechteNatural;
      Waagerechte : KartenDatentypen.WaagerechteNatural;
            
   end record;
   
   
   
   type KartenfeldumgebungRecord is record
      
      Senkrechte : KartenDatentypen.Senkrechte;
      Waagerechte : KartenDatentypen.Waagerechte;
      
   end record;
   
   
   
   type SichtweitePositiveRecord is record
      
      Senkrechte : KartenDatentypen.SenkrechteSichtweite;
      Waagerechte : KartenDatentypen.WaagerechteSichtweite;
      
   end record;
   
   
   
   type SichtweiteNaturalRecord is record
      
      Senkrechte : KartenDatentypen.SenkrechteSichtweiteNatural;
      Waagerechte : KartenDatentypen.WaagerechteSichtweiteNatural;
      
   end record;
   
   
   
   type UmgebungEinsRecord is record
      
      Senkrechte : KartenDatentypen.SenkrechteUmgebungEins;
      Waagerechte : KartenDatentypen.WaagerechteUmgebungEins;
      
   end record;
   
   
   
   type UmgebungZweiRecord is record
      
      Senkrechte : KartenDatentypen.SenkrechteUmgebungZwei;
      Waagerechte : KartenDatentypen.WaagerechteUmgebungZwei;
      
   end record;
   
   
   
   type UmgebungDreiRecord is record
      
      Senkrechte : KartenDatentypen.SenkrechteUmgebungDrei;
      Waagerechte : KartenDatentypen.WaagerechteUmgebungDrei;
      
   end record;
   
   
   
   type SenkrechteAnfangEndeRecord is record
      
      Anfang : KartenDatentypen.Senkrechte;
      Ende : KartenDatentypen.Senkrechte;
      
   end record;
   
   
   
   type WaagerechteAnfangEndeRecord is record
      
      Anfang : KartenDatentypen.Waagerechte;
      Ende : KartenDatentypen.Waagerechte;
      
   end record;
   
   
   
   type KartenfeldVorhandenRecord is record
      
      Ebene : KartenDatentypen.EbeneVorhanden;
      Senkrechte : KartenDatentypen.SenkrechtePositiv;
      Waagerechte : KartenDatentypen.WaagerechtePositiv;
      
   end record;
   
   
   
   type KartenfeldNaturalRecord is record
      
      Ebene : KartenDatentypen.Ebene;
      Senkrechte : KartenDatentypen.SenkrechteNatural;
      Waagerechte : KartenDatentypen.WaagerechteNatural;
      
   end record;
   
   

   type KartenfeldRecord is record
      
      Ebene : KartenDatentypen.Ebene;
      Senkrechte : KartenDatentypen.Senkrechte;
      Waagerechte : KartenDatentypen.Waagerechte;
      
   end record;
   
   
   
   -- Könnte man das nicht mit EffekthöheRecord zusammenführen? äöü
   type EffektbereichRecord is record
      
      SenkrechteAnfang : KartenDatentypen.Senkrechte;
      SenkrechteEnde : KartenDatentypen.SenkrechteNatural;
      WaagerechteAnfang : KartenDatentypen.Waagerechte;
      WaagerechteEnde : KartenDatentypen.WaagerechteNatural;
      
   end record;
   
   
   
   type EffekthöheRecord is record
      
      EbeneAnfang : KartenDatentypen.EbeneVorhanden;
      EbeneEnde : KartenDatentypen.EbeneVorhanden;
      
   end record;
   
   
   
   type EffekteArray is array (KartenextraDatentypen.Effekt_Vorhanden_Enum'Range) of Boolean;
   type EffektbereichArray is array (EffekteArray'Range) of EffektbereichRecord;
   type FeldeffektArray is array (KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of Boolean;
   
   
   
   type FelderwertungArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of ZufallsgeneratorenDatentypenHTSEB.Bewertung_Enum;
   type SichtbarkeitArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of Boolean;
   -- Mehr davon einbauen um den Arbeitsspeicherverbrauch zu reduzieren? äöü
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
   
      
      
   type ZeigerRecord is record
      
      KoordinatenAktuell : KartenfeldNaturalRecord;
      KoordinatenAlt : KartenfeldNaturalRecord;
      
   end record;
   
   
   
   type KartenformSenkrechteRecord is record
      
      SenkrechteNorden : KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
      SenkrechteSüden : KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
      
   end record;
   
   
   
   type KartenformWaagerechteRecord is record
      
      WaagerechteWesten : KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
      WaagerechteOsten : KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
      
   end record;
   
   
   
   type KartenformRecord is record
      
      EbeneOben : KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum;
      EbeneUnten : KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum;
      SenkrechteNorden : KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
      SenkrechteSüden : KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
      WaagerechteWesten : KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
      WaagerechteOsten : KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
      
   end record;
   
   
   
   type KartenpoleRecord is record
      
      Nordpol : KartenartDatentypen.Kartenpole_Enum;
      Südpol : KartenartDatentypen.Kartenpole_Enum;
      Westpol : KartenartDatentypen.Kartenpole_Enum;
      Ostpol : KartenartDatentypen.Kartenpole_Enum;
      
   end record;
   
   
   
   type LandgrößenRecord is record
      
      MinimaleSenkrechte : KartenDatentypen.SenkrechtePositiv;
      MaximaleSenkrechte : KartenDatentypen.SenkrechtePositiv;
      
      MinimaleWaagerechte : KartenDatentypen.WaagerechtePositiv;
      MaximaleWaagerechte : KartenDatentypen.WaagerechtePositiv;
      
   end record;
   
   
   
   type PermanenteKartenparameterRecord is record
      
      Kartengröße : KartenfeldumgebungPositivRecord;
      Kartenform : KartenformRecord;
      
   end record;
   
   
   
   type TemporäreKartenparameterRecord is record
      
      Kartengröße : KartenfeldumgebungPositivRecord;
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
            
      Koordinaten : KartenfeldNaturalRecord;
      
      Bewertung : KartenDatentypen.SenkrechteNatural;
            
   end record;
   
end KartenRecords;
