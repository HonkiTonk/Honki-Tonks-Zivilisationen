package body KartengeneratorVariablenLogik is

   procedure OberflächenpolSchreiben
     (BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum)
   is begin
      
      PolgrundOberfläche := BasisgrundExtern;
      
   end OberflächenpolSchreiben;
   
   
   
   procedure UnterflächenpolSchreiben
     (BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum)
   is begin
      
      PolgrundUnterfläche := BasisgrundExtern;
      
   end UnterflächenpolSchreiben;
   
   
   
   procedure SenkrechterPolSchreiben
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      HimmelsrichtungExtern : in KartenartDatentypen.Senkrechte_Himmelsrichtungen_Enum)
   is begin
      
      Polsenkrechte (HimmelsrichtungExtern) := SenkrechteExtern;
      
   end SenkrechterPolSchreiben;
   
   
   
   procedure WaagerechterPolSchreiben
     (WaagerechteExtern : in KartenDatentypen.WaagerechteNatural;
      HimmelsrichtungExtern : in KartenartDatentypen.Waagerechte_Himmelsrichtungen_Enum)
   is begin
      
      Polwaagerechte (HimmelsrichtungExtern) := WaagerechteExtern;
      
   end WaagerechterPolSchreiben;
   
   
   
   procedure Standardpole
   is begin
      
      Polsenkrechte := KartengeneratorRecordKonstanten.SenkrechterEisrand;
      Polwaagerechte := KartengeneratorRecordKonstanten.WaagerechterEisrand;
            
   end Standardpole;
   
   
   
   procedure LandgrößenSchreiben
     (GrößeExtern : in KartenRecords.LandgrößenRecord)
   is begin
      
      Landgrößen := GrößeExtern;
      
   end LandgrößenSchreiben;
   
   
   
   procedure PolfreierBereichSchreiben
     (BereichExtern : in KartenRecords.LandgrößenNaturalRecord)
   is begin
      
      PolfreierBereich := BereichExtern;
      
   end PolfreierBereichSchreiben;
   
   
   
   -- Wenn das neue Rohstoffsystem da ist kann das weg. äöü
   procedure RohstoffwahrscheinlichkeitenSchreiben
     (RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;
      WahrscheinlichkeitExtern : in SystemDatentypenHTSEB.NullBisHundert)
   is begin
      
      KartenrohstoffeWahrscheinlichkeiten (RohstoffeExtern) := WahrscheinlichkeitExtern;
      
   end RohstoffwahrscheinlichkeitenSchreiben;
   
   
   
   procedure KartengrößeSchreiben
     (GrößeExtern : in KartenRecords.KartenfeldumgebungPositivRecord)
   is begin
      
      Kartenparameter.Kartengröße := GrößeExtern;
      
   end KartengrößeSchreiben;
   
   
   
   procedure KartenebenenSchreiben
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
   is begin
      
      Kartenparameter.Kartenebene := EbenenExtern;
      
   end KartenebenenSchreiben;
   
   
   
   procedure KartenformSchreiben
     (FormExtern : in KartenRecords.KartenformRecord)
   is begin
      
      Kartenparameter.Kartenform := FormExtern;
      
   end KartenformSchreiben;
   
   
   
   procedure KartenartSchreiben
     (ArtExtern : in KartenartDatentypen.Kartenart_Enum)
   is begin
      
      Kartenparameter.Kartenart := ArtExtern;
      
   end KartenartSchreiben;
   
   
   
   procedure KartentemperaturSchreiben
     (TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
   is begin
      
      Kartenparameter.Kartentemperatur := TemperaturExtern;
      
   end KartentemperaturSchreiben;
   
   
   
   procedure KartenrohstoffeSchreiben
     (RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum)
   is begin
      
      Kartenparameter.Kartenrohstoffe := RohstoffeExtern;
      
   end KartenrohstoffeSchreiben;
   
   
   
   procedure KartenpoleSchreiben
     (PoleExtern : in KartenRecords.KartenpoleRecord)
   is begin
      
      Kartenparameter.Kartenpole := PoleExtern;
      
   end KartenpoleSchreiben;
   
   
   
   procedure KartenpolEinzelnSchreiben
     (PolExtern : in KartenartDatentypen.Kartenpole_Enum;
      HimmelsrichtungExtern : in KartenartDatentypen.Himmelsrichtungen_Enum)
   is begin
      
      case
        HimmelsrichtungExtern
      is
         when KartenartDatentypen.Norden_Enum =>
            Kartenparameter.Kartenpole.Nordpol := PolExtern;
            
         when KartenartDatentypen.Süden_Enum =>
            Kartenparameter.Kartenpole.Südpol := PolExtern;
            
         when KartenartDatentypen.Westen_Enum =>
            Kartenparameter.Kartenpole.Westpol := PolExtern;
            
         when KartenartDatentypen.Osten_Enum =>
            Kartenparameter.Kartenpole.Ostpol := PolExtern;
      end case;
      
   end KartenpolEinzelnSchreiben;
   
   
   
   procedure KartenparameterSchreiben
     (ParameterExtern : in KartenRecords.TemporäreKartenparameterRecord)
   is begin
      
      Kartenparameter := ParameterExtern;
      
   end KartenparameterSchreiben;
      
   
      
   function OberflächenpolLesen
     return KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum
   is begin
      
      return PolgrundOberfläche;
      
   end OberflächenpolLesen;
   
   
   
   function UnterflächenpolLesen
     return KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum
   is begin
      
      return PolgrundUnterfläche;
      
   end UnterflächenpolLesen;
   
   
   
   function SenkrechterPolLesen
     (HimmelsrichtungExtern : in KartenartDatentypen.Senkrechte_Himmelsrichtungen_Enum)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      return Polsenkrechte (HimmelsrichtungExtern);
      
   end SenkrechterPolLesen;
   
   
   
   function WaagerechterPolLesen
     (HimmelsrichtungExtern : in KartenartDatentypen.Waagerechte_Himmelsrichtungen_Enum)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      return Polwaagerechte (HimmelsrichtungExtern);
      
   end WaagerechterPolLesen;
   
   
   
   function LandgrößenLesen
     return KartenRecords.LandgrößenRecord
   is begin
      
      return Landgrößen;
      
   end LandgrößenLesen;
   
   
   
   function PolfreierBereichLesen
     return KartenRecords.LandgrößenNaturalRecord
   is begin
      
      return PolfreierBereich;
      
   end PolfreierBereichLesen;
   
   
   
   -- Wenn das neue Rohstoffsystem da ist kann das weg. äöü
   function RohstoffwahrscheinlichkeitenLesen
     (RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return SystemDatentypenHTSEB.NullBisHundert
   is begin
      
      return KartenrohstoffeWahrscheinlichkeiten (RohstoffeExtern);
      
   end RohstoffwahrscheinlichkeitenLesen;
   
   
   
   function KartengrößeLesen
     return KartenRecords.KartenfeldumgebungPositivRecord
   is begin
      
      return Kartenparameter.Kartengröße;
      
   end KartengrößeLesen;
   
   
   
   function KartenebenenLesen
     return KartenRecords.KartenebenenVorhandenRecord
   is begin
      
      return Kartenparameter.Kartenebene;
      
   end KartenebenenLesen;
   
   
   
   function KartenformLesen
     return KartenRecords.KartenformRecord
   is begin
      
      return Kartenparameter.Kartenform;
      
   end KartenformLesen;
   
   
   
   function KartenartLesen
     return KartenartDatentypen.Kartenart_Enum
   is begin
      
      return Kartenparameter.Kartenart;
      
   end KartenartLesen;
   
   
   
   function KartentemperaturLesen
     return KartenartDatentypen.Kartentemperatur_Enum
   is begin
      
      return Kartenparameter.Kartentemperatur;
      
   end KartentemperaturLesen;
   
   
   
   function KartenrohstoffeLesen
     return KartenrohstoffeDatentypen.Rohstoffanzahl_Enum
   is begin
      
      return Kartenparameter.Kartenrohstoffe;
      
   end KartenrohstoffeLesen;
   
   
   
   function KartenpoleLesen
     return KartenRecords.KartenpoleRecord
   is begin
      
      return Kartenparameter.Kartenpole;
      
   end KartenpoleLesen;

end KartengeneratorVariablenLogik;
