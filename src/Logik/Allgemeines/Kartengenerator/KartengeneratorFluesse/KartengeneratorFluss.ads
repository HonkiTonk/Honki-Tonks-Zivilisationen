pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

private with KartenRecords;
private with ZahlenDatentypen;

private with Karten;

package KartengeneratorFluss is

   procedure AufteilungFlussgenerierung;

private
   
   ------------------------ Später vom Nutzer einstellbar machen.
   ------------------------ Oder rauswerfen?
   FlussumgebungBonus : Float := 1.25;
   
   type MultiplikatorArray is array (KartenDatentypen.EbenePlanet'Range) of ZahlenDatentypen.EigenesPositive;
   Multiplikator : MultiplikatorArray;
   
   ------------------- Später vom Nutzer änderbar machen.
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbenePlanet'Range) of KartenDatentypen.Auswahlbereich;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                       -2 => 30,
                                                                       -1 => 30,
                                                                       0  => 30
                                                                      );
         
   type BeliebigerFlusswertArray is array (WahrscheinlichkeitFlussArray'Range) of KartenDatentypen.Auswahlbereich;
   BeliebigerFlusswert : BeliebigerFlusswertArray;

   type KartenWertArray is array (WahrscheinlichkeitFlussArray'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenWertArray;
   
   procedure GenerierungFlüsse;
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet);
   
      
      
   function FlussumgebungTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

end KartengeneratorFluss;
