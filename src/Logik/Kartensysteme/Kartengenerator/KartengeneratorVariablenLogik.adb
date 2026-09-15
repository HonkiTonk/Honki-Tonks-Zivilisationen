package body KartengeneratorVariablenLogik is
   
   -- protected body Variablenzugriff is

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
     (RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;
      WahrscheinlichkeitExtern : in SystemDatentypenHTSEB.NullBisHundert)
   is begin
      
      KartenrohstoffeWahrscheinlichkeiten (RohstoffExtern) := WahrscheinlichkeitExtern;
      
   end RohstoffwahrscheinlichkeitenSchreiben;
   
   
   
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
     (RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return SystemDatentypenHTSEB.NullBisHundert
   is begin
      
      return KartenrohstoffeWahrscheinlichkeiten (RohstoffExtern);
      
   end RohstoffwahrscheinlichkeitenLesen;
      
   -- end Variablenzugriff;

end KartengeneratorVariablenLogik;
