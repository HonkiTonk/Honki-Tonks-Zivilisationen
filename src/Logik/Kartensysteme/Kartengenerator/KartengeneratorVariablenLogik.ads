with SystemDatentypenHTSEB;

with KartenRecords;
with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartenartDatentypen;
with KartenbasisgrundDatentypen;
with KartenDatentypen;
with KartenrohstoffeDatentypen;

private with KartenArrays;

-- Man kann den Polgrund noch nicht einstellen, auch irgendwann mal einbauen. äöü
package KartengeneratorVariablenLogik is
   pragma Elaborate_Body;

   procedure OberflächenpolSchreiben
     (BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum);

   procedure UnterflächenpolSchreiben
     (BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum);

   procedure SenkrechterPolSchreiben
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      HimmelsrichtungExtern : in KartenartDatentypen.Senkrechte_Himmelsrichtungen_Enum);

   procedure WaagerechterPolSchreiben
     (WaagerechteExtern : in KartenDatentypen.WaagerechteNatural;
      HimmelsrichtungExtern : in KartenartDatentypen.Waagerechte_Himmelsrichtungen_Enum);

   procedure Standardpole;

   procedure LandgrößenSchreiben
     (GrößeExtern : in KartenRecords.LandgrößenRecord);

   procedure PolfreierBereichSchreiben
     (BereichExtern : in KartenRecords.LandgrößenNaturalRecord);

   -- Wenn das neue Rohstoffsystem da ist kann das weg. äöü
   procedure RohstoffwahrscheinlichkeitenSchreiben
     (RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;
      WahrscheinlichkeitExtern : in SystemDatentypenHTSEB.NullBisHundert);

   procedure KartengrößeSchreiben
     (GrößeExtern : in KartenRecords.KartenfeldumgebungPositivRecord);

   procedure KartenebenenSchreiben
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord);

   procedure KartenformSchreiben
     (FormExtern : in KartenRecords.KartenformRecord);

   procedure KartenartSchreiben
     (ArtExtern : in KartenartDatentypen.Kartenart_Enum);

   procedure KartentemperaturSchreiben
     (TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum);

   procedure KartenrohstoffeSchreiben
     (RohstoffeExtern : in KartenartDatentypen.Kartenrohstoffemenge_Enum);

   procedure KartenpoleSchreiben
     (PoleExtern : in KartenRecords.KartenpoleRecord);

   procedure KartenpolEinzelnSchreiben
     (PolExtern : in KartenartDatentypen.Kartenpole_Enum;
      HimmelsrichtungExtern : in KartenartDatentypen.Himmelsrichtungen_Enum);

   procedure KartenparameterSchreiben
     (ParameterExtern : in KartenRecords.TemporäreKartenparameterRecord);



   function OberflächenpolLesen
     return KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum;

   function UnterflächenpolLesen
     return KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum;

   function SenkrechterPolLesen
     (HimmelsrichtungExtern : in KartenartDatentypen.Senkrechte_Himmelsrichtungen_Enum)
      return KartenDatentypen.SenkrechteNatural;

   function WaagerechterPolLesen
     (HimmelsrichtungExtern : in KartenartDatentypen.Waagerechte_Himmelsrichtungen_Enum)
      return KartenDatentypen.WaagerechteNatural;

   function LandgrößenLesen
     return KartenRecords.LandgrößenRecord;

   function PolfreierBereichLesen
     return KartenRecords.LandgrößenNaturalRecord;

   -- Wenn das neue Rohstoffsystem da ist kann das weg. äöü
   function RohstoffwahrscheinlichkeitenLesen
     (RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return SystemDatentypenHTSEB.NullBisHundert;

   function KartengrößeLesen
     return KartenRecords.KartenfeldumgebungPositivRecord;

   function KartenebenenLesen
     return KartenRecords.KartenebenenVorhandenRecord;

   function KartenformLesen
     return KartenRecords.KartenformRecord;

   function KartenartLesen
     return KartenartDatentypen.Kartenart_Enum;

   function KartentemperaturLesen
     return KartenartDatentypen.Kartentemperatur_Enum;

   function KartenrohstoffeLesen
     return KartenartDatentypen.Kartenrohstoffemenge_Enum;

   function KartenpoleLesen
     return KartenRecords.KartenpoleRecord;

private

   PolgrundOberfläche : KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum := KartenbasisgrundDatentypen.Eis_Enum;
   PolgrundUnterfläche : KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum := KartenbasisgrundDatentypen.Untereis_Enum;

   Polsenkrechte : KartengeneratorRecordKonstanten.SenkrechtePolregionenArray := KartengeneratorRecordKonstanten.SenkrechterEisrand;
   Polwaagerechte : KartengeneratorRecordKonstanten.WaagerechtePolregionenArray := KartengeneratorRecordKonstanten.WaagerechterEisrand;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);

   PolfreierBereich : KartenRecords.LandgrößenNaturalRecord;

   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

   -- Wenn das neue Rohstoffsystem da ist kann das weg. äöü
   KartenrohstoffeWahrscheinlichkeiten : KartenArrays.KartenrohstoffeWahrscheinlichkeitenArray;

end KartengeneratorVariablenLogik;
