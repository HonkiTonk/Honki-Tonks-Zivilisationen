pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Karten;

package KartengeneratorFluss is

   procedure AufteilungFlussgenerierung;

private
   
   ------------------------ Später vom Nutzer einstellbar machen.
   ------------------------ Oder rauswerfen?
   FlussumgebungBonus : Float := 1.25;
   
   ------------------- Später vom Nutzer änderbar machen.
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbeneVorhanden'First .. 0) of KartenDatentypen.WahrscheinlichkeitKartengenerator;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                       -2 => 30,
                                                                       -1 => 30,
                                                                       0  => 30
                                                                      );
         
   type BeliebigerFlusswertArray is array (WahrscheinlichkeitFlussArray'Range) of KartenDatentypen.WahrscheinlichkeitKartengenerator;
   BeliebigerFlusswert : BeliebigerFlusswertArray;

   type KartenWertArray is array (WahrscheinlichkeitFlussArray'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenWertArray;
   
   procedure GenerierungFlüsse;
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
      
      
   function FlussumgebungTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end KartengeneratorFluss;
