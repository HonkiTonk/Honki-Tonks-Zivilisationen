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

   -- protected Variablenzugriff is

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

   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

private

   PolgrundOberfläche : KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum := KartenbasisgrundDatentypen.Eis_Enum;
   PolgrundUnterfläche : KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum := KartenbasisgrundDatentypen.Untereis_Enum;

   Polsenkrechte : KartengeneratorRecordKonstanten.SenkrechtePolregionenArray := KartengeneratorRecordKonstanten.SenkrechterEisrand;
   Polwaagerechte : KartengeneratorRecordKonstanten.WaagerechtePolregionenArray := KartengeneratorRecordKonstanten.WaagerechterEisrand;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);

   PolfreierBereich : KartenRecords.LandgrößenNaturalRecord;

   -- Wenn das neue Rohstoffsystem da ist kann das weg. äöü
   KartenrohstoffeWahrscheinlichkeiten : KartenArrays.KartenrohstoffeWahrscheinlichkeitenArray;

   -- end Variablenzugriff;

end KartengeneratorVariablenLogik;
